m_ph <- ajusta(fml_n(1, "periodo"), nac)
b <- coef(m_ph)
fase <- function(p) {
  a <- b[paste0("periodo", p, ":s1")]; c <- b[paste0("periodo", p, ":c1")]
  c(amplitud = unname(sqrt(a^2 + c^2)),
    sem_pico = unname(((atan2(a, c) / (2*pi)) * 52.18) %% 52.18))
}
rbind(pre = fase("pre"), post = fase("post"))

P <- 52.18
dif_sem <- function(a, b) ((b - a + P / 2) %% P) - P / 2     # diferencia circular en (-P/2, P/2]

fase <- function(p, m) {
  b  <- coef(m)
  a  <- b[paste0("periodo", p, ":s1")]
  cc <- b[paste0("periodo", p, ":c1")]
  if (anyNA(c(a, cc))) stop("el modelo no tiene términos periodo:s1/c1 (usa spec = 'periodo', K >= 1)")
  c(amplitud = unname(sqrt(a^2 + cc^2)),
    sem_pico = unname(((atan2(a, cc) / (2 * pi)) * P) %% P))
}

cambio_fase <- function(m) {
  pre  <- fase("pre",  m)
  post <- fase("post", m)
  c(dif_amplitud = unname(post["amplitud"] - pre["amplitud"]),
    dif_sem_pico = unname(dif_sem(pre["sem_pico"], post["sem_pico"])))
}

boot_fase <- function(m, dat, f, B = 500, L = 13) {
  mu  <- fitted(m); th <- m$theta
  r   <- residuals(m, "pearson"); n <- length(r)
  sdv <- sqrt(mu + mu^2 / th)
  nb  <- ceiling(n / L)
  
  out <- matrix(NA_real_, B, 2, dimnames = list(NULL, c("dif_amplitud", "dif_sem_pico")))
  for (b in seq_len(B)) {
    ini <- sample.int(n - L + 1, nb, replace = TRUE)
    idx <- unlist(lapply(ini, function(i) i:(i + L - 1)))[1:n]
    d_b <- dat
    d_b$flu <- pmax(0, round(mu + sdv * r[idx]))
    mb <- try(suppressWarnings(ajusta(f, d_b)), silent = TRUE)
    if (!inherits(mb, "try-error") && isTRUE(mb$converged))
      out[b, ] <- tryCatch(cambio_fase(mb), error = function(e) c(NA_real_, NA_real_))
  }
  out
}

# --- Ejecución: modelo con estacionalidad por periodo y K = 1 ---
f_ph <- fml_n(1, "periodo")
m_ph <- ajusta(f_ph, nac)

est <- cambio_fase(m_ph); est                    # estimación puntual
set.seed(1)
bt_f <- boot_fase(m_ph, nac, f_ph, B = 500)

colSums(is.na(bt_f))                             # fallos de convergencia
apply(bt_f, 2, quantile, c(.025, .5, .975), na.rm = TRUE)
colMeans(bt_f > 0, na.rm = TRUE)  