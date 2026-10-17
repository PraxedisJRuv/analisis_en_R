#se va a seleccionar pand
spec <- "pand"                        # <- tu decisión
m    <- get(c(comun = "m_c", pand = "m_pand", periodo = "m_per")[spec])


#Paso 4 ahora sí
nw_vcov <- function(m, L = 12) {
  X  <- model.matrix(m); mu <- fitted(m)
  sc <- X * ((m$y - mu) / (1 + mu / m$theta))
  S  <- crossprod(sc)
  for (l in 1:L) {
    G <- crossprod(sc[-(1:l), , drop = FALSE], sc[1:(nrow(sc) - l), , drop = FALSE])
    S <- S + (1 - l / (L + 1)) * (G + t(G))
  }
  V <- vcov(m); V %*% S %*% V
}
tabla_hac <- function(m, L) {
  b <- coef(m); se <- sqrt(diag(nw_vcov(m, L)))
  cbind(IRR = exp(b), lo = exp(b - 1.96 * se), hi = exp(b + 1.96 * se),
        p = 2 * pnorm(-abs(b / se)))
}
lapply(c(8, 12, 26), function(L) round(tabla_hac(m, L), 3))