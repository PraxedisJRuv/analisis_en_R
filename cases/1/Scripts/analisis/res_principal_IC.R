contraf <- function(m, dat) {
  d0 <- dat
  d0$tt <- min(dat$tt[dat$periodo != "pre"])        # tendencia congelada en el corte 1
  d0[c("D1", "S1", "D2", "S2")] <- 0
  d0$periodo <- factor("pre",   levels = levels(dat$periodo))
  d0$pand    <- factor("resto", levels = levels(dat$pand))
  predict(m, newdata = d0, type = "response")
}
razon <- function(m, dat) {
  esp <- contraf(m, dat)
  tapply(dat$flu, dat$periodo, sum)[c("pandemia", "post")] /
    tapply(esp,   dat$periodo, sum)[c("pandemia", "post")]
}
razon(m, nac)

# Bootstrap de bloques sobre residuos (mantiene fijo el diseño ITS)
boot_razon <- function(m, dat, f, B = 500, L = 13) {
  mu <- fitted(m); th <- m$theta
  r  <- residuals(m, "pearson"); n <- length(r)
  sdv <- sqrt(mu + mu^2 / th); nb <- ceiling(n / L)
  out <- matrix(NA, B, 2, dimnames = list(NULL, c("pandemia", "post")))
  for (b in seq_len(B)) {
    ini <- sample.int(n - L + 1, nb, replace = TRUE)
    idx <- unlist(lapply(ini, function(i) i:(i + L - 1)))[1:n]
    d_b <- dat; d_b$flu <- pmax(0, round(mu + sdv * r[idx]))
    mb  <- try(suppressWarnings(ajusta(f, d_b)), silent = TRUE)
    if (!inherits(mb, "try-error") && mb$converged) out[b, ] <- razon(mb, d_b)
  }
  out
}
set.seed(1)
bt <- boot_razon(m, nac, fml_n(K, spec))
colSums(is.na(bt))                                  # fallos de convergencia
apply(bt, 2, quantile, c(.025, .5, .975), na.rm = TRUE)