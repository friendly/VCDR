#' ---
#' title: "Exploratory plots for crab satellites data"
#' author: "Michael Friendly"
#' date: "19 Oct 2015"
#' ---

library(countreg)
data("CrabSatellites", package = "countreg")
str(CrabSatellites)


cutfac <- function(x, breaks = NULL, q=10) {
  if(is.null(breaks)) breaks <- unique(quantile(x, 0:q/q))
  x <- cut(x, breaks, include.lowest = TRUE, right = FALSE)
  levels(x) <- paste(breaks[-length(breaks)], ifelse(diff(breaks) > 1,
    c(paste("-", breaks[-c(1, length(breaks))] - 1, sep = ""), "+"), ""), sep = "")
  return(x)
}

# basic exploratory plots
library(gpairs)
gpairs(CrabSatellites[,5:1],
	diag.pars = list(fontsize=16),
	mosaic.pars = list(gp=shading_Friendly, gp_args=list(interpolate=1:4))
	)

# scatterplots & boxplots
plot(jitter(satellites) ~ width, data=CrabSatellites,
	ylab="Number of satellites (jittered)", xlab="Carapace width", cex.lab=1.25)
with(CrabSatellites, lines(lowess(width, satellites), col="red", lwd=2))

op <- par(mar=c(4,4,1,1)+.1)
plot(satellites ~ cutfac(width), data=CrabSatellites,
	ylab="Number of satellites", xlab="Carapace width (deciles)")

plot(satellites ~ cutfac(weight), data = CrabSatellites,
     ylab = "Number of satellites", xlab = "Weight (deciles)")
par(op)

plot(jitter(satellites) ~ weight, data=CrabSatellites,
	ylab="Number of satellites (jittered)", xlab="Weight", cex.lab=1.25)
with(CrabSatellites, lines(lowess(weight, satellites), col="red", lwd=2))

plot(satellites ~ cutfac(weight), data=CrabSatellites,
	ylab="Number of satellites", xlab="Weight (deciles)")



crabs.pois <- glm(satellites ~ ., data=CrabSatellites, family=poisson)
summary(crabs.pois)

anova(crabs.pois, test="Chisq")

library(car)
Anova(crabs.pois)

library(effects)
plot(allEffects(crabs.pois), main="")

# treat color as numeric
CrabSatellites1 <- transform(CrabSatellites,
  color = as.numeric(color))

crabs.pois1 <- glm(satellites ~ weight + color, data=CrabSatellites1, family=poisson)
summary(crabs.pois1)
plot(allEffects(crabs.pois1))

vcdExtra::LRstats(crabs.pois, crabs.pois1)

