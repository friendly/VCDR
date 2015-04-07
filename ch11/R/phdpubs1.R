# data from Long (1997)
# see http://data.princeton.edu/wws509/stata/overdispersion.html#x2 for Stata analysis

data("PhdPubs", package="vcdExtra")

# NB: right=FALSE crucial here
hist(PhdPubs$articles, breaks=0:19, col="lightblue", xlim=c(0,20), right=FALSE,
     xlab="Number of Articles", main="")
 
#art.hist <- hist(PhdPubs$articles, breaks=0:19, plot=FALSE)
#plot(art.hist, col="lightblue", xlab="Number of Articles", xlim=c(0,20), main="")

# this omits the values with zero frequency
#art.tab <- table(PhdPubs$articles)

# coercing the vector to a factor...
art.tab <- table(factor(PhdPubs$articles, levels=0:19))

cd("C:/Dropbox/Documents/VCDR/ch11/fig")

pdf(file="phdpubs-barplot1.pdf", w=9, h=5)
op <- par(mar=c(4,4,1,1)+1)
barplot(art.tab, xlab="Number of articles", ylab="Frequency", col="lightblue")
abline(v=mean(PhdPubs$articles), col="red", lwd=3)
ci <- mean(PhdPubs$articles)+c(-1,1) * sqrt(var(PhdPubs$articles))
lines(x=ci, y=c(-4, -4), col="red", lwd=3, xpd=TRUE)
par(op)
dev.off()

pdf(file="phdpubs-barplot2.pdf", w=9, h=5)
op <- par(mar=c(4,4,1,1)+1)
barplot(art.tab+1, ylab="log(Frequency+1)", xlab="Number of articles", log="y", col="lightblue")
abline(v=mean(PhdPubs$articles), col="red", lwd=3)
lines(x=ci, y=c(.9, .9), col="red", lwd=3, xpd=TRUE)
par(op)
dev.off()

## midpoints are not correct in the above. get them from barplot
## but this requires interpolation!
mids <- barplot(art.tab, xlab="Number of articles", ylab="Frequency", col="lightblue")
abline(v=mean(PhdPubs$articles), col="red", lwd=3)
ci <- mean(PhdPubs$articles)+c(-1,1) * sqrt(var(PhdPubs$articles))
lines(x=ci, y=c(-4, -4), col="red", lwd=3, xpd=TRUE)


# using plot method for tables

plot(art.tab, ylab="Frequency", xlab="Number of articles")
points(as.numeric(names(art.tab)), art.tab, pch=16)

boxplot(articles+1 ~ married, data=PhdPubs, log="y", ylab="log(articles+1)", xlab="married", cex.lab=1.25)
 
plot(jitter(articles+1) ~ mentor, data=PhdPubs, log="y", ylab="log(articles+1)", cex.lab=1.25)
lines(lowess(PhdPubs$mentor, PhdPubs$articles+1), col="blue", lwd=3)
#abline(lm((articles+1)~mentor, data=PhdPubs))

# using ggplot2

library(ggplot2)
ggplot(PhdPubs, aes(factor(married), articles+1)) + geom_violin() + geom_jitter(size=1.5, position=position_jitter(width=0.25)) + scale_y_log10()
ggplot(PhdPubs, aes(factor(married), articles+1)) + geom_boxplot() + geom_jitter(size=1.5, position=position_jitter(width=0.25)) + scale_y_log10()

ggplot(PhdPubs, aes(mentor, articles+1)) + geom_jitter() + stat_smooth(method="loess") + scale_y_log10()

ggplot(PhdPubs, aes(mentor, articles+1)) + 
	geom_jitter(position=position_jitter(h=0.05)) + 
	stat_smooth(method="loess", size=2, fill="blue", alpha=0.25) + 
	stat_smooth(method="glm", color="red", size=1.25, se=FALSE) +
	scale_y_log10(breaks=c(1,2,5,10,20)) +
	labs(y = "log (articles+1)", x="Mentor publications")
	


#art.freq <- colSums(outer(PhdPubs$articles, 0:19, `==`))
#barplot(art.freq, names.arg=0:19, col="lightblue", xlab="Number of articles", ylab="Frequency")

# mean and variance
with(PhdPubs, c(mean=mean(articles), var=var(articles), ratio=var(articles)/mean(articles)))

##########################
 

# poisson model
phd.pois <- glm(articles ~ ., data=PhdPubs, family=poisson)
summary(phd.pois)

library(car)
Anova(phd.pois)

# making female and married factors helps in effect plots
PhdPubs1 <- within(PhdPubs, {
	female <- factor(female)
	married <- factor(married)
})

phd.pois1 <- glm(articles ~ ., data=PhdPubs1, family=poisson)
Anova(phd.pois1)

cbind(beta=coef(phd.pois), expbeta=exp(coef(phd.pois)), pct=100*(exp(coef(phd.pois))-1))
exp(confint(coef(phd.pois)))

##################################################

library(effects)

plot(allEffects(phd.pois), band.colors="blue", lwd=3, ylab="Number of articles")
# constant range...
plot(allEffects(phd.pois), band.colors="blue", ylim=c(0,log(10)))

## model fit

with(phd.pois, pvalue=pchisq(deviance, df.residual, lower.tail=FALSE))

# sandwich estimator
library(sandwich)
coeftest(phd.pois, vcov=sandwich)

# estimate of phi = dispersion parameter
with(phd.pois, deviance/df.residual)
sum(residuals(phd.pois, type = "pearson")^2)/phd.pois$df.residual


phd.qpois <- glm(articles ~ ., data=PhdPubs, family=quasipoisson)

library(MASS)
phd.nbin  <- glm.nb(articles ~ ., data=PhdPubs)

fit.nbin <- fitted(phd.nbin, type="response")
fit.pois <- fitted(phd.pois, type="response")

# mean - variance relation ???
# function to get quantiles of a numeric variable
cutq <- function(x, q = 10) {
    quantile <- cut(x, breaks = quantile(x, probs = 0:q/q), 
        include.lowest = TRUE, labels = 1:q)
    quantile
}

# group number of articles published by quantiles of the fitted negative binomial
#qdat <- data.frame(articles=PhdPubs$articles, group=cutq(fit.nbin, q=20))
#qdat <- aggregate(qdat$articles, 
#          list(qdat$group), 
#          FUN = function(x) c(mean=mean(x), var=var(x)))
#qdat <- data.frame(qdat$x)
#qdat <- qdat[order(qdat$mean),]

group <- cutq(fit.nbin, q=20)
qdat <- aggregate(PhdPubs$articles, 
          list(group), 
          FUN = function(x) c(mean=mean(x), var=var(x)))
qdat <- data.frame(qdat$x)
qdat <- qdat[order(qdat$mean),]

# quasi-poisson variance
phi <- summary(phd.qpois)$dispersion
qdat$qvar <- phi * qdat$mean
# negative binomial variance
qdat$nbvar <- qdat$mean + (qdat$mean^2) / phd.nbin$theta
qdat

with(qdat, {
	plot(var ~ mean, xlab="Mean number of articles", ylab="Variance", 
		pch=16, cex=1.2, cex.lab=1.2)
	abline(h=mean(PhdPubs$articles), col=gray(.40), lty="dotted")
	lines(mean, qvar, col="red", lwd=2)
	lines(mean, nbvar, col="blue", lwd=2)
	lines(lowess(mean, var), lwd=2, lty="dashed")
	text(3, mean(PhdPubs$articles), "Poisson", col=gray(.40))
	text(3, 5, "quasi-Poisson", col="red")
	text(3, 6.7, "negbin", col="blue")
	text(3, 8.5, "lowess")
})

# compare standard errors


phd.SE <- sqrt(cbind(
	pois=diag(vcov(phd.pois)),
	sand=diag(sandwich(phd.pois)), 
	qpois=diag(vcov(phd.qpois)),
	nbin=diag(vcov(phd.nbin))))
round(phd.SE,4)

# how much larger on average?
phd.SE[,2:4] / phd.SE[,1]
colMeans(phd.SE[,2:4] / phd.SE[,1])

mean(phd.SE[,2:4] / phd.SE[,1])


#########################

# rootograms

library(countreg)
countreg::rootogram(phd.pois, max=12, main="PhDPubs: Poisson")
countreg::rootogram(phd.nbin, max=12, main="PhDPubs: Negative-Binomial")


	


          



