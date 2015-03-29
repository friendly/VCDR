# Analysis of demand for medical care, NMES1988

data("NMES1988", package="AER")
nmes <- NMES1988[, c(1, 6:8, 13, 15, 18)]
str(nmes)
library(MASS)

# fit some baseline, main effect models
# ------------
nmes.pois   <-      glm(visits ~ ., data = nmes, family = poisson)
nmes.nbin   <-   glm.nb(visits ~ ., data = nmes)
#anova(nmes.pois, nmes.nbin, test="Chisq")

library(lmtest)
lrtest(nmes.pois, nmes.nbin)
summary(nmes.nbin)

# try interaction terms
add1(nmes.nbin, . ~ .^2, test="Chisq")

# add some interactions
 # nmes.nbin2 <- update(nmes.nbin, . ~ . + health:chronic + hospital:chronic + hospital:health + health:school )
nmes.nbin2 <- update(nmes.nbin, . ~ . + (health+chronic+hospital)^2 + health:school )
# nmes.nbin2 <- update(nmes.nbin, . ~ . + health:chronic + hospital:chronic + hospital:health + health:school )
#anova(nmes.nbin, nmes.nbin2)
lrtest(nmes.nbin, nmes.nbin2)

summary(nmes.nbin2) 

###################################
# Effects plots
# ------------
library(effects)

plot(allEffects(nmes.nbin), ylab = "Office visits")

# try partial residuals -- doesn't work very well
plot(Effect("chronic", nmes.nbin, partial.residuals=TRUE), ylab = "Office visits")


eff_nbin2 <- allEffects(nmes.nbin2,
	xlevels=list(hospital=c(0:3, 6, 8), chronic=c(0:3, 6, 8), school=seq(0,20,5))
	)

# all interactions
plot(eff_nbin2[3:6])

plot(eff_nbin2, "health:chronic", layout=c(3,1), ylab = "Office visits", colors="blue" )

plot(eff_nbin2, "health:chronic", multiline=TRUE, ci.style="bands",
	ylab = "Office visits", xlab="# Chronic conditions",
	key.args = list(x = 0.05, y = .80, corner = c(0, 0)))
	
plot(eff_nbin2, "hospital:health", multiline=TRUE, ci.style="bands",
	ylab = "Office visits", xlab="Hospital stays",
	key.args = list(x = 0.05, y = .80, corner = c(0, 0)))

plot(eff_nbin2, "hospital:chronic", ylab = "Office visits")

plot(eff_nbin2, "hospital:chronic", multiline=TRUE, ci.style="bands",
	ylab = "Office visits", xlab="Hospital stays",
	key.args = list(x = 0.05, y = .70, corner = c(0, 0)))

plot(eff_nbin2, "health:school", multiline=TRUE,  ci.style="bands",
	ylab = "Office visits", xlab="Years of education",
	key.args = list(x = 0.7, y = .15, corner = c(0, 0)))

# test nonlinear effects
# ----------------------
nmes.nbin3 <- update(nmes.nbin2, . ~ . + I(chronic^2) + I(hospital^2))

# do fm_nbin3 the long way
nmes.nbin3a <- glm.nb(visits ~ poly(hospital,2) + poly(chronic,2) 
                         + insurance + school + gender
                         + (health+chronic+hospital)^2 + health:school, data = nmes)

summary(nmes.nbin3)
anova(nmes.nbin, nmes.nbin2, nmes.nbin3)
vcdExtra::Summarise(nmes.nbin, nmes.nbin2, nmes.nbin3)

eff_nbin3 <- allEffects(nmes.nbin3,
	xlevels=list(hospital=c(0:3, 6, 8), chronic=c(0:3, 6, 8), school=seq(0,20,5))
	)

plot(eff_nbin3, "health:chronic", layout=c(3,1))

plot(eff_nbin3, "hospital:chronic")

plot(eff_nbin3, "hospital:chronic", multiline=TRUE, ci.style="bands",
	ylab = "Office visits", xlab="Hospital stays",
	key.args = list(x = 0.1, y = .75, corner = c(0, 0)))


# response surface plot
# ---------------------
library(rsm)
#persp(nmes.nbin3, hospital ~ chronic, zlab="log Office visits", col="skyblue",
#  contour=list(z="bottom", col="brown4"), 
#  at=list(school=10, health='average'), theta=-60)

persp(nmes.nbin3, hospital ~ chronic, zlab="log Office visits", col=rainbow(30),
  contour=list(col="colors", lwd=2), 
  at=list(school=10, health='average'), theta=-60)


# or, perhaps better, use splines or gam
library(splines)
nmes.nbin4 <- update(nmes.nbin2, . ~ . - chronic - hospital + ns(chronic,2) + ns(hospital,2))

nmes.nbin4 <- glm.nb(visits ~ 
                         insurance + school + gender
                         + (health+ns(chronic,2)+ns(hospital,2))^2 + health:school, data = nmes)

summary(nmes.nbin4)
anova(nmes.nbin, nmes.nbin2, nmes.nbin4)

# Using gam
# ---------

library(mgcv)
# can use either family=nb() to estimate theta or family=negbin(theta=1.245)

nmes.gamnb <- gam(visits ~ s(hospital, k=3) + s(chronic, k=3) +
                           insurance + school + gender +
                           (health+chronic+hospital)^2 + health:school,
                  family=nb(), data = nmes)

lrtest(nmes.nbin2, nmes.gamnb)

# effect plots -- this doesn't work
eff_gamnb <- allEffects(nmes.gamnb,
	xlevels=list(hospital=c(0:3, 6, 8), chronic=c(0:3, 6, 8), school=seq(0,20,5))
	)

plot(eff_gamnb, "health:chronic", layout=c(3,1))

plot(eff_gamnb, "hospital:chronic")

plot(eff_gamnb, "hospital:chronic", multiline=TRUE, ci.style="bands",
	ylab = "Office visits", xlab="Hospital stays",
	key.args = list(x = 0.1, y = .75, corner = c(0, 0)))

# perpective plots
library(rsm)
persp(nmes.gamnb, hospital ~ chronic, zlab="log Office visits", 
	col=rainbow(30), contour=list(col="colors", lwd=2), 
  at=list(school=10, health='average'), theta=-60)

persp(nmes.gamnb, school ~ chronic, zlab="log Office visits", 
	col=rainbow(30), contour=list(col="colors", lwd=2, z="top"), 
  at=list(hospital=0.3, health='average'), theta=-60)



# Using gnm -- doesnt work
# ---------
library(gnm)
library(MASS)
nmes.gnmqp <- gnm(visits ~ Exp(hospital) + Exp(chronic) +
                           insurance + school + gender +
                           (health+chronic+hospital)^2 + health:school,
                  family=quasipoisson, data = nmes)

nmes.gnmnb <- gnm(visits ~ Exp(hospital) + Exp(chronic) +
                           insurance + school + gender +
                           (health+chronic+hospital)^2 + health:school,
                  family=negative.binomial(theta=1.24), data = nmes)
