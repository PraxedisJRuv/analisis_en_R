corte1 <- as.Date("2020-03-15"); corte2 <- as.Date("2022-04-01")

df$temporada <- ifelse(df$semana >= 27,
                       paste0(df$anio, "-", df$anio + 1),
                       paste0(df$anio - 1, "-", df$anio))

armar <- function(d, corte1, corte2, K = 4) {
  d$estado <- factor(d$estado)
  t1 <- min(d$t[d$fecha >= corte1]); t2 <- min(d$t[d$fecha >= corte2])
  d$tt <- d$t / 52.18                               # tiempo en años
  d$D1 <- as.numeric(d$t >= t1);  d$S1 <- pmax(0, d$t - t1 + 1) / 52.18
  d$D2 <- as.numeric(d$t >= t2);  d$S2 <- pmax(0, d$t - t2 + 1) / 52.18
  d$periodo <- factor(ifelse(d$t < t1, "pre", ifelse(d$t < t2, "pandemia", "post")),
                      levels = c("pre", "pandemia", "post"))
  for (k in 1:K) {
    d[[paste0("s", k)]] <- sin(2 * pi * k * d$t / 52.18)
    d[[paste0("c", k)]] <- cos(2 * pi * k * d$t / 52.18)
  }
  d
}
d <- armar(df, corte1, corte2)

prep_nac <- function(d, c1, c2, rec = 0, K = 4) {
  nac <- aggregate(cbind(flu, covid) ~ t + fecha, d, sum)
  nac <- nac[order(nac$t), ]
  nac <- nac[nac$t <= max(nac$t) - rec, ]
  nac$estado <- "Nacional"                      # armar() lo requiere
  nac <- armar(nac, c1, c2, K)
  nac$pand <- factor(ifelse(nac$periodo == "pandemia", "pand", "resto"))
  nac
}

fml_n <- function(K, spec = c("periodo", "pand", "comun"), extra = NULL) {
  spec <- match.arg(spec)
  fo   <- paste0("s", 1:K, "+c", 1:K, collapse = "+")
  seas <- switch(spec,
                 periodo = paste0("periodo:(", fo, ")"),
                 pand    = paste0("pand:(", fo, ")"),
                 comun   = fo)
  as.formula(paste("flu ~ tt + D1 + S1 + D2 + S2 +", seas,
                   if (!is.null(extra)) paste("+", extra)))
}

ajusta <- function(f, dat) { 
  m <- MASS::glm.nb(f, dat, control = glm.control(maxit = 500), init.theta = 1) #con menos iteraciones y theta pequeña, no converge
  if (!m$converged) warning("glm.nb no convergió")
  m
}

#ceros
nac <- prep_nac(d, corte1, corte2)
plot(nac$fecha, nac$flu, type = "l"); abline(v = c(corte1, corte2), lty = 2)
mean(nac$flu == 0)      # ceros nacionales (debería ser ~0; si no, revisar)
tapply(nac$flu == 0, nac$periodo, mean)
nac$fecha[nac$flu == 0]
plot(nac$fecha, nac$covid, type = "l"); abline(v = c(corte1, corte2), lty = 2); lines(nac$fecha, nac$flu, col = "red")