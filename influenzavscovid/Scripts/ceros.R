#ceros
nac <- prep_nac(d, corte1, corte2)
plot(nac$fecha, nac$flu, type = "l"); abline(v = c(corte1, corte2), lty = 2)
mean(nac$flu == 0)      # ceros nacionales (debería ser ~0; si no, revisar)
tapply(nac$flu == 0, nac$periodo, mean)
nac$fecha[nac$flu == 0]
plot(nac$fecha, nac$covid, type = "l"); abline(v = c(corte1, corte2), lty = 2); lines(nac$fecha, nac$flu, col = "red")