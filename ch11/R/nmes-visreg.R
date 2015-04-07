#' ---
#' title: "Plotting nmes.nbin with visreg"
#' author: "Michael Friendly"
#' date: "29 Mar 2015"
#' ---



data("NMES1988", package="AER")
nmes <- NMES1988[, c(1, 6:8, 13, 15, 18)]
str(nmes)
library(MASS)

# fit some baseline, main effect models
# ------------
nmes.pois   <-      glm(visits ~ ., data = nmes, family = poisson)
nmes.nbin   <-   glm.nb(visits ~ ., data = nmes)

library(visreg)
op <- par(mfrow=c(2,3), mar=c(5,4,1,1)+.1, cex.lab=1.5)
visreg(nmes.nbin, ylab="Office visits")

visreg(nmes.nbin, ylab="Office visits", scale="response")
par(op)

nmes.nbin2 <- update(nmes.nbin, . ~ . + (health+chronic+hospital)^2 + health:school )

# have to plot interactions individually
visreg(nmes.nbin2, xvar="chronic", by="health", ylab="Office visits")
visreg(nmes.nbin2, xvar="hospital", by="health", ylab="Office visits")



