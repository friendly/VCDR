# fit a binomial model for the sex ratio in Arbuthnot's data

data(Arbuthnot, package="HistData")

arbuth.mod <- glm(cbind(Males, Females) ~ Year + Plague + Mortality), 
	data=Arbuthnot, family=binomial)
summary(arbuth.mod)

library(effects)
arbuth.eff <- allEffects(arbuth.mod)
plot(arbuth.eff)

