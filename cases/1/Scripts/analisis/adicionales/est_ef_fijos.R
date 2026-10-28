d <- d[order(d$estado, d$t), ]
d$covid_l1 <- ave(d$covid, d$estado, FUN = function(x) c(0, head(x, -1)))
# intensidad relativa de COVID: respecto al promedio del propio estado
d$cov_rel <- log1p(d$covid_l1) - ave(log1p(d$covid_l1), d$estado)

dp <- d[d$fecha >= as.Date("2020-03-15"), ]       # donde COVID existe
dp$tf <- factor(dp$t)
m_fe <- MASS::glm.nb(flu ~ estado + tf + cov_rel, dp,
               control = glm.control(maxit = 500), init.theta = 1)
m_fe$converged

robust_vcov <- function(m, cluster) {
  X  <- model.matrix(m)
  mu <- fitted(m)
  th <- if (!is.null(m$theta)) m$theta else stop("el modelo no tiene theta")
  sc <- X * ((m$y - mu) / (1 + mu / th))     # scores de la NB con enlace log
  g  <- length(unique(cluster))
  meat <- crossprod(rowsum(sc, cluster)) * g / (g - 1)
  V <- vcov(m)
  V %*% meat %*% V
}

# Errores agrupados por estado (32 clusters, algo optimistas)
V  <- robust_vcov(m_fe, dp$estado)
b  <- coef(m_fe)["cov_rel"]; se <- sqrt(diag(V)["cov_rel"])
c(IRR = exp(b), lo = exp(b - 1.96*se), hi = exp(b + 1.96*se))

m_fx <- fixest::fenegbin(flu ~ cov_rel | estado + t, data = dp, cluster = ~estado)
summary(m_fx)

dp$per <- ifelse(dp$fecha < as.Date("2021-11-01"), "pandemia", "post")
m_sp <- fixest::fenegbin(flu ~ cov_rel | estado + t, data = dp, cluster = ~estado, split = ~per)
fixest::etable(m_sp)