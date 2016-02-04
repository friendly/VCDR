#' ---
#' title: "Elephants data, Exercise 11.1"
#' author: "Michael Friendly"
#' date: "04 Feb 2016"
#' ---


library(Sleuth2)
data("case2201", package="Sleuth2")
elephants <- case2201
str(elephants)

set.seed(1234567)
op <- par(mar=c(4,4,1,1)+.1)
with(elephants, {
	plot(jitter(Matings) ~ Age)
	lines(lowess(Age, Matings), lwd=2, col="red")}
	)


op <- par(mar=c(4,4,1,1)+.1)
with(elephants, {
	plot(jitter(Matings+1) ~ Age, log="y", ylab="log(Matings+1)")
	lines(lowess(Age, Matings+1), lwd=2, col="red")}
	)

library(ggplot2)
ggplot(elephants, aes(x=Age, y=Matings+1)) + geom_jitter() +
	geom_smooth(method="loess", color="red", size=2, fill="red", alpha=0.2) +
	geom_smooth(method="lm", color="blue", size=2, fill="blue", alpha=0.2) +
	scale_y_log10(breaks=c(1,2,5,10, 20)) + theme_bw()

# (c)
	

elephants.mod0 <- glm(Matings ~ 1, data=elephants, family=poisson)
elephants.mod1 <- glm(Matings ~ I(Age-27), data=elephants, family=poisson)
summary(elephants.mod1)
# coefficients
coef(elephants.mod1)
exp(coef(elephants.mod1))

library(effects)
plot(allEffects(elephants.mod1))

plot(Effect("Age", elephants.mod1, xlevels=list(Age=seq(25,50,5))))

anova(elephants.mod0, elephants.mod1, test="Chisq")

summary(elephants.mod2)

library(MASS)
elephants.mod3 <- glm.nb(Matings ~ I(Age-27), data=elephants)

LRstats(elephants.mod0, elephants.mod1, elephants.mod2)
anova(elephants.mod0, elephants.mod1, elephants.mod2, test="Chisq")
 
library(countreg)
rootogram(elephants.mod0)
rootogram(elephants.mod1)
rootogram(elephants.mod2)

library(effects)
plot(allEffects(elephants.mod1))

# (e)

require(AER, quietly=TRUE)
dispersiontest(elephants.mod1)

elephants.mod2 <- glm(Matings ~ I(Age-27), data=elephants, family=quasipoisson)
library(MASS)
elephants.mod3 <- glm.nb(Matings ~ I(Age-27), data=elephants)

LRstats(elephants.mod1, elephants.mod3)





elephants.mod1q <- glm(Matings ~ poly(Age,2), data=elephants, family=poisson)
anova(elephants.mod1, elephants.mod1q, test="Chisq")
plot(allEffects(elephants.mod1q))

