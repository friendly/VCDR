library(Sleuth2)
data("case2201", package="Sleuth2")
elephants <- case2201
str(elephants)


plot(jitter(Matings) ~ Age, data=elephants)
with(elephants,
	lines(lowess(Age, Matings), lwd=2, col="red")
	)

plot(jitter(Matings+1) ~ Age, data=elephants, log="y",
	ylab="log(Matings+1)")
with(elephants,
	lines(lowess(Age, Matings+1), lwd=2, col="red")
	)

library(ggplot2)
ggplot(elephants, aes(x=Age, y=Matings+1)) + geom_jitter() +
	geom_smooth(method="loess", color="red", size=2, fill="red", alpha=0.2) +
	geom_smooth(method="lm", color="blue", size=2, fill="blue", alpha=0.2) +
	scale_y_log10(breaks=c(1,2,5,10, 20))



	
elephants.mod0 <- glm(Matings ~ 1, data=elephants, family=poisson)
elephants.mod1 <- glm(Matings ~ Age, data=elephants, family=poisson)
elephants.mod2 <- glm(Matings ~ Age, data=elephants, family=quasipoisson)
summary(elephants.mod2)

library(MASS)
elephants.mod3 <- glm.nb(Matings ~ Age, data=elephants)

LRstats(elephants.mod0, elephants.mod1, elephants.mod2)
anova(elephants.mod0, elephants.mod1, elephants.mod2, test="Chisq")
 
library(countreg)
rootogram(elephants.mod0)
rootogram(elephants.mod1)
rootogram(elephants.mod2)

library(effects)
plot(allEffects(elephants.mod1))

elephants.mod1q <- glm(Matings ~ poly(Age,2), data=elephants, family=poisson)
plot(allEffects(elephants.mod1q))

