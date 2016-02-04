#' ---
#' title: "quine data, Exercise 11.2"
#' author: "Michael Friendly"
#' date: "04 Feb 2016"
#' ---

# (a)
# examine sample sizes
quine.tab <- xtabs(~ Lrn + Age + Sex + Eth, data=quine)
ftable(Age + Sex ~ Lrn + Eth, data=quine.tab)


data("quine", package="MASS")
quine.mod1 <- glm(Days ~ ., data=quine, family=poisson)
summary(quine.mod1)
car::Anova(quine.mod1)

# Age should be treated as an ordered factor
quine$Age <- ordered(quine$Age)
quine.mod1 <- glm(Days ~ ., data=quine, family=poisson)
summary(quine.mod1)
car::Anova(quine.mod1)

library(effects)
plot(allEffects(quine.mod1), rows=1, cols=4, ci.style='bands')

# (b)
library(AER)
dispersiontest(quine.mod1)

# (c)
quine.mod1q <- glm(Days ~ ., data=quine, family=quasipoisson)
#summary(quine.mod1q)
coeftest(quine.mod1q)
car::Anova(quine.mod1q)

# further analyses: test for interactions
quine.mod2 <- glm(Days ~ .^2, data=quine, family=poisson)
quine.mod2 <- update(quine.mod1, .~.^2)

summary(quine.mod2)
car::Anova(quine.mod2)

quine.mod3 <- update(quine.mod1, . ~ . + Eth:Age)
plot(allEffects(quine.mod3))


quine.mod2q <- glm(Days ~ .^2, data=quine, family=quasipoisson)
summary(quine.mod2q)
car::Anova(quine.mod2q)



