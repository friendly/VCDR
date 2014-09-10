library(car)    # for Anova()
data(UCBAdmissions)
UCB.df <- as.data.frame(UCBAdmissions)
berk.mod1 <- glm(Admit=="Admitted" ~ Dept, data=UCB.df, weights=UCB.df$Freq, family="binomial")
Anova(berk.mod1, test="Wald")
summary(berk.mod1)

berk.mod2 <- glm(Admit=="Admitted" ~ Dept+Gender, data=UCB.df, weights=UCB.df$Freq, family="binomial")
Anova(berk.mod2, test="Wald")
summary(berk.mod2)

library(effects)   ## load the effects package
berk.eff2 <- allEffects(berk.mod2)
# plot main  effects
plot(berk.eff2)
# plot 'interaction' -- produces a harmless warning
plot(effect('Dept:Gender', berk.mod2), multiline=TRUE)




