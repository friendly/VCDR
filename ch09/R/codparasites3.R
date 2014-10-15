# Residual and diagnostic plots

library(countreg)
data("CodParasites", package = "countreg")

# models
cp_nb  <- glm.nb(intensity ~ length + area * year, data = CodParasites)
cp_hp  <- hurdle(intensity ~ length + area * year, data = CodParasites, dist = "poisson")
cp_hnb <- hurdle(intensity ~ length + area * year, data = CodParasites, dist = "negbin")


## standard model plots, for glm models (also work for quasi-poisson, NB)
op <- par(mfrow = c(2, 2))
plot(cp_nb)
par(op)

# residual plots for hurdle models
plot(residuals(cp_hp) ~ fitted(cp_hp))

res <- residuals(cp_hp)
fit <- log(fitted(cp_hp))

plot(fit, res)



# car plots
library(car)
influencePlot(cp_nb)

spreadLevelPlot(cp_nb)
