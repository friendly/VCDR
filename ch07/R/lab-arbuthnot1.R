# fit a binomial model for the sex ratio in Arbuthnot's data

data(Arbuthnot, package="HistData")
arbuth.mod <- glm(cbind(Males, Females) ~ Year + Plague + Mortality, 
	data=Arbuthnot, family=binomial)
summary(arbuth.mod)
LRstats(arbuth.mod)

arbuth.mod0 <- glm(cbind(Males, Females) ~ 1, 
	data=Arbuthnot, family=binomial)
LRstats(arbuth.mod0, arbuth.mod)

library(effects)
arbuth.eff <- allEffects(arbuth.mod)
plot(arbuth.eff, ylab="Males/Females")

# try using log(Plague), log(Mortality)
arbuth.mod1 <- glm(cbind(Males, Females) ~ Year + log(Plague+1) + log(Mortality), 
	data=Arbuthnot, family=binomial)
summary(arbuth.mod1)
LRstats(arbuth.mod1)

arbuth.eff1 <- allEffects(arbuth.mod1)
plot(arbuth.eff1, ylab="Males/Females")

