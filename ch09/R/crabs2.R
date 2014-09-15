library(countreg)
data("CrabSatellites", package = "countreg")


CrabSatellites1 <- transform(CrabSatellites,
  color = as.numeric(color))

crabs.pois1 <- glm(satellites ~ weight + color, data=CrabSatellites1, family=poisson)


# other models
library(MASS)
crabs.qpois <- glm(satellites ~ weight + color, data=CrabSatellites1, family=quasipoisson)

crabs.nbin <- glm.nb(satellites ~ weight + color, data=CrabSatellites1)
# theta
summary(crabs.nbin)$theta

# specifying theta=1, giving the geometric model
crabs.nbin1 <- glm(satellites ~ weight + color, data=CrabSatellites1, family=negative.binomial(1))

########
# rootograms

library(countreg)
countreg::rootogram(crabs.pois1, max=15, main="CrabSatellites: Poisson")
countreg::rootogram(crabs.nbin, max=15, main="CrabSatellites: Negative-Binomial")

#countreg::rootogram(crabs.nbin1, main="CrabSatellites: Negative-Binomial(1)")



library(countreg)
crabs.hurdle <- hurdle(satellites ~ weight + color, data=CrabSatellites1)
summary(crabs.hurdle)

# the zero part 


crabs.zero <- glm(satellites==0 ~ ., data=CrabSatellites)
plot(allEffects(crabs.zero))

crabs.zero1 <- glm(satellites==0 ~ weight + color, data=CrabSatellites1)

plot(allEffects(crabs.zero1))

