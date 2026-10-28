
#Elegir armónicos 
tab_K <- t(sapply(1:4, function(k) {
  m <- ajusta(fml_n(k, "comun"), nac)
  c(K = k, AIC = AIC(m), BIC = BIC(m), conv = m$converged)
}))
tab_K

t(sapply(1:4, function(k) {
  m <- ajusta(fml_n(k, "pand"), nac)
  c(K = k, AIC = AIC(m), BIC = BIC(m), conv = m$converged)
}))


t(sapply(1:4, function(k) {
  m <- ajusta(fml_n(k, "periodo"), nac)
  c(K = k, AIC = AIC(m), BIC = BIC(m), conv = m$converged)
}))


K <- 3    # ajusta según AIC/BIC; con BIC suele elegirse menos

#Probar si la estacionalidad cambió con 3 métricas distintas
m_c    <- ajusta(fml_n(K, "comun"),   nac)
m_pand <- ajusta(fml_n(K, "pand"),    nac)
m_per  <- ajusta(fml_n(K, "periodo"), nac)

anova(m_c, m_pand, m_per)                 # LR secuencial (están anidados)
AIC(m_c, m_pand, m_per); BIC(m_c, m_pand, m_per)
sapply(list(m_c, m_pand, m_per), function(m) m$converged)