data("CyclingDeaths", package="vcdExtra")
CyclingDeaths.tab <- table(CyclingDeaths$deaths)
CyclingDeaths.tab

(mean <- mean(CyclingDeaths$deaths))
var(CyclingDeaths$deaths)
var/mean

# poisson calculation

1 - ppois(5, lambda)
ppois(5, lambda, lower.tail=FALSE)

# exercises

with(CyclingDeaths, {
	plot(deaths ~ date, type="h", 
		lwd=3, ylab="Number of deaths", axes=FALSE)
	axis(1, at=seq(as.Date('2005-01-01'), by='years', length.out=9), labels=2005:2013)
	axis(2, at=0:3)
	lines(lowess(date, deaths), col="blue", lwd=4)
})

gf <- goodfit(CyclingDeaths.tab)
gf
summary(gf)

rootogram(gf, xlab="Number of Deaths")
distplot(CyclingDeaths.tab)
