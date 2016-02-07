#' ---
#' title: "PhdPubs data, Exercise 11.7"
#' author: "Michael Friendly"
#' date: "05 Feb 2016"
#' ---


data("PhdPubs", package="vcdExtra")

library(MASS)
library(countreg)
library(vcdExtra)

# (a)
# using all predictors
phd.nbin  <- glm.nb(articles ~ ., data=PhdPubs)

phd.hp    <- hurdle(articles ~ ., data=PhdPubs, dist = "poisson")
phd.hnb   <- hurdle(articles ~ ., data=PhdPubs, dist = "negbin")
phd.zp    <- zeroinfl(articles ~ ., data=PhdPubs, dist = "poisson")
phd.znb   <- zeroinfl(articles ~ ., data=PhdPubs, dist = "negbin")

LRstats(phd.nbin, phd.hp, phd.hnb, phd.zp, phd.znb,  sortby="BIC")

summary(phd.znb)

# simpler model for zero counts
phd.znb1   <- zeroinfl(articles ~ .|mentor, data=PhdPubs, dist = "negbin")
LRstats(phd.znb, phd.znb1)

# (b)
countreg::rootogram(phd.nbin, main="PhdPubs: Negative binomial")
countreg::rootogram(phd.znb, main="PhdPubs: Zero-inflated negative binomial")

# fit separate models for zeros and positive

phd.zero <- glm(articles==0 ~., data=PhdPubs, family=binomial)
phd.nzero <- glm.nb(articles ~ ., data=PhdPubs, subset = articles >0)

Anova(phd.zero)
Anova(phd.nzero)

library(effects)
plot(allEffects(phd.zero))
plot(allEffects(phd.nzero))

plot(Effect("mentor", phd.zero))
plot(allEffects(phd.nzero)[c(1,3,5)])

# (c) diagnostic plots

library(car)
# these don't work
residualPlot(phd.znb1, type="rstandard", col.smooth="red", id.n=3)
influencePlot(phd.znb1)

op <- par(mfrow=c(1,2), mar=c(4,4,1,1)+.1)
residualPlot(phd.zero, type="rstandard", 
      quadratic=TRUE, col.smooth="red", col.quad="blue",  id.n=3)

residualPlot(phd.zero, "mentor", type="rstandard", 
      quadratic=TRUE, col.smooth="red", col.quad="blue",  id.n=3)
par(op)

op <- par(mfrow=c(1,2), mar=c(4,4,1,1)+.1)
residualPlot(phd.nzero, type="rstandard", 
      quadratic=TRUE, col.smooth="red", col.quad="blue",  id.n=3)

residualPlot(phd.nzero, "mentor", type="rstandard", 
      quadratic=TRUE, col.smooth="red", col.quad="blue",  id.n=3)
par(op)

op <- par(mar=c(4,4,1,1)+.1)
influencePlot(phd.nzero)
par(op)

residualPlot(phd.nzero, type="rstandard", 
      groups=PhdPubs$articles, key=FALSE, smoother=NULL,
      id.n=3)

