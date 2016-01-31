data("Accident", package = "vcdExtra")

# NB: age is an ordered factor, but should probably not be here

# Reorder mode, making Pedestrian the baseline level
levels(Accident$mode) <- c("Pedestrian", "Bicycle", "4-Wheeled", "Motorcycle" )
levels(Accident$mode)

acc.mod1 <- glm(result=="Died" ~ age + mode + gender, 
                data=Accident, weight=Freq, family=binomial)
summary(acc.mod1)

library(car)
Anova(acc.mod1)

acc.mod2 <- update(acc.mod1, . ~ .^2)
Anova(acc.mod2)
anova(acc.mod1, acc.mod2, test="Chisq")

acc.mod3 <- update(acc.mod1, . ~ .^3)
Anova(acc.mod3)
anova(acc.mod1, acc.mod2, acc.mod3, test="Chisq")
LRstats(acc.mod1, acc.mod2, acc.mod3)

library(effects)
plot(allEffects(acc.mod2))
plot(allEffects(acc.mod2), ci.style="bands", rows=1, cols=3)

plot(Effect(c("age", "gender"), acc.mod2), ci.style="bands")
plot(Effect(c("age", "mode"), acc.mod2), ci.style="bands")
plot(Effect(c("gender", "mode"), acc.mod2), ci.style="bands")

# Overall effect of mode
plot(Effect(c("mode"), acc.mod2), cistyle="bands")



