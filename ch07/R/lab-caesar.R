data("Caesar", package="vcdExtra")
#display table;  note that there are quite a few 0 cells
structable(Caesar)
library((MASS)
library(effects)
library(car)

data("Caesar", package="vcdExtra")
structable(Infection ~ Risk + Planned + Antibiotics, Caesar)
Caesar2 <- vcdExtra::collapse.table(Caesar, Infection=c("Yes", "Yes", "No"))
structable(Infection ~ Risk + Planned + Antibiotics, Caesar2)


Caesar.df <- as.data.frame(Caesar)
Caesar.df$Infect <- as.numeric(Caesar.df$Infection %in% c("Type 1", "Type 2"))

Caesar.df$Infection <- factor(Caesar.df$Infection, levels=c("None", "Type 1", "Type 2"))
Caesar.df$Risk <- factor(Caesar.df$Risk, levels=c("No", "Yes"))
Caesar.df$Antibiotics <- factor(Caesar.df$Antibiotics, levels=c("No", "Yes"))
Caesar.df$Planned <- factor(Caesar.df$Planned, levels=c("No", "Yes"))

str(Caesar.df)

# Logistic regression : None vs (Type 1, Type 2)
caesar.glm <- glm(Infect ~ Risk + Antibiotics + Planned, weights = Freq, data=Caesar.df, family=binomial)

caesar.glm
Anova(caesar.glm)
plot(allEffects(caesar.glm))

plot(Effect(c("Risk", "Antibiotics", "Planned"), caesar.glm))


caesar.glm2 <- update(caesar.glm, . ~ .^2)
Anova(caesar.glm2)
anova(caesar.glm, caesar.glm2, test="Chisq")
plot(allEffects(caesar.glm2))

caesar.glm3 <- update(caesar.glm, . ~ . + Risk:Planned)
Anova(caesar.glm3)
plot(allEffects(caesar.glm3), ci.style="none")


anova(caesar.glm, caesar.glm3, caesar.glm2, test="Chisq")


# Proportional odds model

# assume infection types are ordered
Caesar.df$Infection <- ordered(Caesar.df$Infection, levels=c("None", "Type 1", "Type 2"))

caesar.po <- polr(Infection ~ Risk + Antibiotics + Planned, weights = Freq, data=Caesar.df, Hess=TRUE)
caesar.po
Anova(caesar.po)


plot(allEffects(caesar.po), style="stacked")

col <- colors=rev(sequential_hcl(3))
plot(Effect(c("Risk", "Antibiotics"), caesar.po), colors=col)

plot(Effect(c("Risk", "Antibiotics", "Planned"), caesar.po), style="stacked", colors=col)

# multinomial model

library(nnet)
caesar.multi <- multinom(Infection ~ Risk + Antibiotics + Planned, weights = Freq, data=Caesar.df, Hess=TRUE)
caesar.multi
Anova(caesar.multi)

plot(Effect(c("Risk", "Antibiotics", "Planned"), caesar.multi))
plot(Effect(c("Risk", "Antibiotics", "Planned"), caesar.multi), style="stacked", key.args=list(columns=3))









