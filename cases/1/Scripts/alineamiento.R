#script para darle el formato apropiado a las datos para las pruebas posteriores
#función para transformar los datos a una tabla de conteo entidad en semana, en lugar de conteo de entidad por semana
a_largo <- function(d, anio, nombre) {
  est <- as.character(d[[1]])
  m   <- as.matrix(d[, -1, drop = FALSE])
  sem <- as.integer(gsub("\\D", "", colnames(m)))   # extrae el número de semana
  
  out <- data.frame(estado = rep(est, times = ncol(m)),
                    anio   = anio,
                    semana = rep(sem, each = nrow(m)),
                    valor  = as.vector(m))          # as.vector recorre por columnas
  names(out)[4] <- nombre
  out
}


#Juntar todo en un dataframe apropiada para las pruebas
anios <- 2019:2026

flu <- do.call(rbind, lapply(anios, function(a)
  a_largo(lista_influenza[[as.character(a)]], a, "flu")))

anios_cov <- intersect(anios, as.integer(names(lista_covid)))
covid <- do.call(rbind, lapply(anios_cov, function(a)
  a_largo(lista_covid[[as.character(a)]], a, "covid")))

# Verificar que los nombres de estado coincidan entre ambas fuentes
setdiff(unique(flu$estado), unique(covid$estado))
setdiff(unique(covid$estado), unique(flu$estado))
# Si hay diferencias (acentos, "Distrito Federal" vs "Ciudad de México"), homogeneízalas aquí

df <- merge(flu, covid, by = c("estado", "anio", "semana"), all.x = TRUE)

# Fecha y tiempo continuo
inicio_sem1 <- function(anio) {
  d <- as.Date(paste0(anio, "-01-04"))
  d - as.integer(format(d, "%w"))
}
df$fecha <- inicio_sem1(df$anio) + 7 * (df$semana - 1)
df$t     <- as.integer((df$fecha - min(df$fecha)) / 7) + 1
df <- df[order(df$estado, df$t), ]