sens <- function(c1, c2, rec, K, spec) {
  dat <- prep_nac(d, c1, c2, rec, K = max(K, 4))
  mm  <- ajusta(fml_n(K, spec), dat)
  c(AIC = AIC(mm), conv = mm$converged, razon(mm, dat))
}
cortes <- as.Date(c("2020-02-23", "2020-03-15", "2020-04-12"))
grid   <- expand.grid(i = 1:3, rec = c(0, 4, 8, 12))
res <- t(sapply(seq_len(nrow(grid)), function(j)
  sens(cortes[grid$i[j]], corte2, grid$rec[j], K, spec)))

data.frame(corte1 = cortes[grid$i], rec = grid$rec, round(res, 3))

# Misma tabla cambiando spec ("comun", "pand", "periodo"), K (2, 3, 4) y corte2

# (1) Razón por temporada, para que no domine la ola 2022-23
nac$esp <- contraf(m, nac)
nac$temporada <- aux$temporada[match(nac$t, aux$t)]
ag <- aggregate(cbind(flu, esp) ~ temporada, nac, sum)
ag$razon <- ag$flu / ag$esp; ag

# (3) Sensibilidad de corte2, K y especificación
sens2 <- function(c2, K, spec) {
  dat <- prep_nac(d, corte1, c2, 4, K = max(K, 4))
  mm  <- ajusta(fml_n(K, spec), dat)
  c(AIC = AIC(mm), conv = mm$converged, razon(mm, dat))
}
g2 <- expand.grid(c2 = as.Date(c("2021-11-01", "2022-04-01")), K = c(1, 3),
                  spec = c("pand", "periodo"), stringsAsFactors = FALSE)
cbind(g2, round(t(sapply(seq_len(nrow(g2)), function(j)
  sens2(g2$c2[j], g2$K[j], g2$spec[j]))), 3))