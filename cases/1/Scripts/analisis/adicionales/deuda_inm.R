dur0  <- tapply(d$flu[d$fecha >= corte1 & d$fecha < corte2], d$estado[d$fecha >= corte1 & d$fecha < corte2],
                function(x) mean(x == 0))
reb   <- tapply(d$flu[d$temporada == "2022-2023"], d$estado[d$temporada == "2022-2023"], sum) /
  tapply(d$flu[d$temporada %in% c("2017-2018","2018-2019","2019-2020")],
         d$estado[d$temporada %in% c("2017-2018","2018-2019","2019-2020")], sum) * 3
cor(dur0, reb, method = "spearman")

cor.test(dur0, reb, method="spearman")
summary(dur0)