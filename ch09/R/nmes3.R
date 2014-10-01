# Analysis of demand for medical care, NMES1988

data("NMES1988", package="AER")
nmes <- NMES1988[, c(1, 6:8, 13, 15, 18)]
library(MASS)

# fit some baseline, main effect models
# ------------
nmes.pois   <-      glm(visits ~ ., data = nmes, family = poisson)
nmes.nbin   <-   glm.nb(visits ~ ., data = nmes)

# add some interactions, based on 
# add1(nmes.nbin, . ~ .^2, test="Chisq")
nmes.nbin2 <- update(nmes.nbin, . ~ . + (health+chronic+hospital)^2 + health:school)

# test nonlinear effects
# ----------------------
nmes.nbin3 <- update(nmes.nbin2, . ~ . + I(chronic^2) + I(hospital^2))

# do nmes.nbin3 the long way
nmes.nbin3a <- glm.nb(visits ~ poly(hospital,2) + poly(chronic,2) 
                         + insurance + school + gender
                         + (health+chronic+hospital)^2 + health:school, data = nmes)
# effect plots

library(effects)
eff_nbin3 <- allEffects(nmes.nbin3,
	xlevels=list(hospital=c(0:3, 6, 8), chronic=c(0:3, 6, 8), school=seq(0,20,5))
	)

plot(eff_nbin3, "health:chronic", layout=c(3,1))

plot(eff_nbin3, "hospital:chronic", multiline=TRUE, ci.style="bands",
	ylab = "Office visits", xlab="Hospital stays",
	key.args = list(x = 0.1, y = .75, corner = c(0, 0)))


# Using gam
# ---------

library(mgcv)
# can use either family=nb() to estimate theta or family=negbin(theta=1.245)

nmes.gamnb <- gam(visits ~ s(hospital, k=3) + s(chronic, k=3) +
                           insurance + school + gender +
                           (health+chronic+hospital)^2 + health:school,
                  family=nb(), data = nmes)

# effect plots -- this doesn't work
eff_gamnb <- allEffects(nmes.gamnb,
	xlevels=list(hospital=c(0:3, 6, 8), chronic=c(0:3, 6, 8), school=seq(0,20,5))
	)
#> eff_gamnb <- allEffects(nmes.gamnb,
#+ xlevels=list(hospital=c(0:3, 6, 8), chronic=c(0:3, 6, 8), school=seq(0,20,5))
#+ )
#Error in model.frame.default(visits ~ s(hospital, k = 2) + s(chronic,  : 
#  invalid type (list) for variable 's(hospital, k = 2)'


# perpective plots
library(rsm)
 
persp(nmes.gamnb, school ~ chronic, zlab="log Office visits", 
	col=rainbow(30), contour=list(col="colors", lwd=2, z="top"), 
  at=list(hospital=0.3, health='average'), theta=-60)

