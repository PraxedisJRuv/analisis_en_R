p <- nac[nac$fecha >= as.Date("2022-04-01"), ]
x <- diff(log1p(p$flu)); y <- diff(log1p(p$covid))
ccf(y, x, lag.max = 8, main = "COVID(t+k) vs influenza(t)")

p  <- nac[nac$fecha >= as.Date("2022-04-01"), ]
rf <- residuals(m, "pearson")[nac$fecha >= as.Date("2022-04-01")]
# para COVID, ajusta un modelo análogo con estacionalidad propia y toma sus residuos
ccf(rc, rf, lag.max = 8)