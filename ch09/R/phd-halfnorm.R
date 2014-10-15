# halfnormal plot example

data("PhdPubs", package="vcdExtra")

library(MASS)
phd.nbin  <- glm.nb(articles ~ ., data=PhdPubs)

library(car)
qqPlot(rstudent(phd.nbin), xlab="Normal quantiles", ylab="Studentized residuals", id.n=3)

# examine distribution of residuals
res <- rstudent(phd.nbin)
plot(density(res), lwd=2, col="blue", main="Density of studentized residuals")
rug(res)

# why the bimodality?
plot(jitter(log(PhdPubs$articles+1), factor=1.5), res, 
	xlab="log (articles+1)", ylab="Studentized residual")


observed <- sort(abs(rstudent(phd.nbin)))
n <- length(observed)
expected <- qnorm((1:n + n - 1/8)/(2*n + 1/2))

S <- 100
sims <- simulate(phd.nbin, nsim=S)
simdat <- cbind(PhdPubs, sims)

# calculate residuals for one simulated data set
resids <- function(y)
	rstudent(glm.nb(y ~ female + married + kid5 + phdprestige + mentor, data=simdat, start=coef(phd.nbin)))

simres <- matrix(0, nrow(simdat), S)	
for(i in 1:S) {
	simres[,i] <- sort(abs(resids(dat[,paste("sim", i, sep="_")])))
}

envelope <- 0.95
mean <- apply(simres, 1, mean)
lower <- apply(simres, 1, quantile, prob=(1 - envelope)/2)
upper <- apply(simres, 1, quantile, prob=(1 + envelope)/2)

op <- par(mar=c(4,4,1,1)+.1)
plot(expected, observed,
	xlab='Expected value of half-normal order statistic',
	ylab='Absolute value of studentized residual')
lines(expected, mean, lty=1, lwd=2, col="blue")
lines(expected, lower, lty=2, lwd=2, col="red")
lines(expected, upper, lty=2, lwd=2, col="red")
identify(expected, observed, labels=names(observed), n=3)
par(op)

cd("C:/Dropbox/Documents/VCDR/ch09/fig")
dev.copy2pdf(file="phd-halfnorm.pdf")
