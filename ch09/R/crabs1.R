library(countreg)
## load data, use ordered factors as numeric, and
## grouped factor version of width
data("CrabSatellites", package = "countreg")

clog <- function(x) log(x + 0.5)
cutfac <- function(x, breaks = NULL, q=10) {
  if(is.null(breaks)) breaks <- unique(quantile(x, 0:q/q))
  x <- cut(x, breaks, include.lowest = TRUE, right = FALSE)
  levels(x) <- paste(breaks[-length(breaks)], ifelse(diff(breaks) > 1,
    c(paste("-", breaks[-c(1, length(breaks))] - 1, sep = ""), "+"), ""), sep = "")
  return(x)
}

# basic exploratory plots
#pairs(CrabSatellites)
# but better with gpairs?

library(gpairs)
gpairs(CrabSatellites[,5:1],
	diag.pars = list(fontsize=16),
	mosaic.pars = list(gp=shading_Friendly, gp_args=list(interpolate=1:4))
	)



plot(jitter(satellites) ~ width, data=CrabSatellites,
	ylab="Number of satellites (jittered)", xlab="Carapace width", cex.lab=1.25)
with(CrabSatellites, lines(lowess(width, satellites), col="red", lwd=2))

plot(satellites ~ cutfac(width), data=CrabSatellites,
	ylab="Number of satellites", xlab="Carapace width (deciles)")


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

CrabSatellites1 <- transform(CrabSatellites,
  color = as.numeric(color))

crabs.pois1 <- glm(satellites ~ weight + color, data=CrabSatellites1, family=poisson)
summary(crabs.pois1)
plot(allEffects(crabs.pois1))

# other models
library(MASS)
crabs.qpois <- glm(satellites ~ weight + color, data=CrabSatellites1, family=quasipoisson)

crabs.nbin <- glm.nb(satellites ~ weight + color, data=CrabSatellites1)
# specifying theta=1, giving the geometric model
crabs.nbin1 <- glm(satellites ~ weight + color, data=CrabSatellites1, family=negative.binomial(1))

library(countreg)
crabs.hurdle <- hurdle(satellites ~ weight + color, data=CrabSatellites1)
summary(crabs.hurdle)

# the zero part


crabs.zero <- glm(satellites==0 ~ ., data=CrabSatellites)
plot(allEffects(crabs.zero))

crabs.zero1 <- glm(satellites==0 ~ weight + color, data=CrabSatellites1)

plot(allEffects(crabs.zero1))




