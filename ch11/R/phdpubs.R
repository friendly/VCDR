# data from Long (1997)
# see http://data.princeton.edu/wws509/stata/overdispersion.html#x2 for Stata analysis

data("PhdPubs", package="vcdExtra")

#hist(PhdPubs$articles, breaks=0:19, col="pink", xlim=c(0,20),
#     xlab="Number of Articles")

hist(PhdPubs$articles, breaks=0:19, col="pink", xlim=c(0,20),
     xlab="Number of Articles")


# mean and variance
with(PhdPubs, c(mean=mean(articles), var=var(articles), ratio=var(articles)/mean(articles)))

##########################


# poisson model
phd.pois <- glm(articles ~ ., data=PhdPubs, family=poisson)
library(car)
Anova(phd.pois)

coef(phd.pois)
exp(coef(phd.pois))

cbind(coef(phd.pois), exp(coef(phd.pois)))

 

# estimate of phi = dispersion parameter
with(phd.pois, deviance/df.residual)
sum(residuals(phd.pois, type = "pearson")^2)/phd.pois$df.residual

library(effects)

plot(allEffects(phd.pois))


phd.qpois <- glm(articles ~ ., data=PhdPubs, family=quasipoisson)

library(MASS)
phd.nbin  <- glm.nb(articles ~ ., data=PhdPubs)

fit.nbin <- fitted(phd.nbin, type="response")
fit.pois <- fitted(phd.pois, type="response")

# mean - variance relation ???
# function to get quantiles of a numeric variable
qfun <- function(x, q = 20) {
    quantile <- cut(x, breaks = quantile(x, probs = 0:q/q), 
        include.lowest = TRUE, labels = 1:q)
    quantile
}

# group number of articles published by quantiles of the fitted negative binomial
dat <- data.frame(articles=PhdPubs$articles, group=qfun(fit.nbin))

qdat <- aggregate(dat$articles, 
          list(dat$group), 
          FUN = function(x) c(n=length(x), mean=mean(x), var=var(x)))

qdat <- 
qdat$x[order(qdat$x[,"mean"]),]

plot(var ~ mean, data=qdat, xlab="Mean number of articles", ylab="Variance", pch=15)
abline(h=mean(PhdPubs$articles), col="gray", lty="dotted")
text(3, mean(PhdPubs$articles), "Poisson", col=gray(.40))
phi <- summary(phd.qpois)$dispersion
lines(qdat[,"mean"], phi*qdat[,"mean"], col="red", lwd=2, lty="dashed")
text(3, 5, "Quasi-Poisson", col="red")

lines(lowess(qdat[,"mean"], qdat[,"var"]), col="blue", lwd=2)
text(3, 8, "lowess smooth", col="blue")





          



