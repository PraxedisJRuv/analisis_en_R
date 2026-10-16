aux <- df[!duplicated(df$t), c("t", "anio", "semana", "temporada")]
tem <- merge(nac[, c("t", "fecha", "flu", "covid")], aux, by = "t")
tem <- tem[order(tem$t), ]

res_tem <- do.call(rbind, lapply(split(tem, tem$temporada), function(s) {
  i <- which.max(s$flu); j <- which.max(s$covid)
  data.frame(temporada = s$temporada[1], n_sem = nrow(s),
             total_flu = sum(s$flu), pico_flu = s$flu[i],
             fecha_pico = s$fecha[i], sem_pico = s$semana[i],
             dur_20pct = sum(s$flu >= 0.2 * s$flu[i]),   # umbral arbitrario
             total_covid = sum(s$covid), fecha_pico_covid = s$fecha[j])
}))
res_tem

tem$pos <- ave(tem$t, tem$temporada, FUN = function(x) x - min(x) + 1)
ts_ <- unique(tem$temporada)
plot(NA, xlim = c(1, 53), ylim = range(tem$flu), xlab = "semana de temporada", ylab = "positivos")
for (k in seq_along(ts_)) lines(flu ~ pos, tem[tem$temporada == ts_[k], ], col = k, lwd = 2)
legend("topright", ts_, col = seq_along(ts_), lwd = 2, cex = 0.7)