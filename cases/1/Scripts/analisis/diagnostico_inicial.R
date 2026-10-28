diag_m <- function(m, dat, nombre) {
  dat$fit <- fitted(m)
  plot(dat$fecha, dat$flu, type = "l", main = nombre)
  lines(dat$fecha, dat$fit, col = "red"); abline(v = c(corte1, corte2), lty = 2)
  r <- residuals(m, "pearson")
  cat(nombre, "| dispersión:", round(sum(r^2) / m$df.residual, 2),
      "| theta:", round(m$theta, 2),
      "| Ljung-Box p:", signif(Box.test(r, 12, "Ljung-Box")$p.value, 3), "\n")
  acf(r, main = paste("ACF", nombre))
  invisible(r)
}
r_c    <- diag_m(m_c,    nac, "común")
r_pand <- diag_m(m_pand, nac, "solo pandemia")
r_per  <- diag_m(m_per,  nac, "por periodo")