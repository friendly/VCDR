#' ---
#' title: "Housing data - Exercise 8.2"
#' author: "Michael Friendly"
#' date: "31 Jan 2016"
#' ---

library(MASS)
data("housing", package="MASS")
str(housing)

# proportional odds model 
PO.mod <- polr(Sat ~ Infl + Type + Cont, data=housing, weights=Freq)
car::Anova(PO.mod)

# Test the proportional odds assumption
library(VGAM)
# PO model
PO.vglm <- vglm(Sat ~ Infl + Type + Cont, data=housing, 
                family=cumulative(parallel=TRUE), weights=Freq)
# NPO model
NPO.vglm <- vglm(Sat ~ Infl + Type + Cont, data=housing, 
                 family=cumulative(parallel=FALSE), weights=Freq)
# See if PO assumption holds
lrtest(PO.vglm, NPO.vglm)

# (b)
house.step<- stepAIC(PO.mod, scope = ~.^2, direction = "forward")
house.step$anova
Anova(house.step)


# new model object with chosen interactions
PO.mod2 <- polr(formula = Sat ~ Infl + Type + Cont + Infl:Type + Type:Cont, 
                data = housing, Hess=TRUE, weights=Freq)
          
# test to see if the proportional odds assumption still holds here
# PO model
PO.vglm <- vglm(Sat~Infl+Type+Cont +Infl:Type + Type:Cont, data=housing,
                family=cumulative(parallel=TRUE), weights=Freq)
# NPO model
NPO.vglm <- vglm(Sat~Infl+Type+Cont+Infl:Type+Type:Cont, data=housing,
                 family=cumulative(parallel=FALSE), weights=Freq)
# See if PO model is okay
lrtest(PO.vglm,NPO.vglm)

# plotting

fit.step <- cbind(housing, predict(house.step, type="probs"))
head(fit.step)
library(reshape2)
plotdat <- melt(fit.step, 
                id.vars = c("Sat", "Infl", "Type", "Cont"),
                measure.vars = c("Low", "Medium", "High"),
                variable.name = "Satisfaction",
                value.name = "Probability")

library(ggplot2)
ggplot(plotdat, aes(x = as.integer(Cont), y = Probability, color = Satisfaction)) +
  facet_grid(Infl ~ Type, labeller=label_both) + 
  geom_point(size=2.5, shape=15) + 
  geom_line(size=1.5) +
  xlab("Contact") +
  ggtitle("Fitted Probabilities from PO Interaction Model for Satisfaction") +
  scale_x_discrete(breaks=1:2, labels=c("Low","High")) +
  theme_bw() 

# effect plots
library(effects) 

# main effect of Type and Infl
plot(Effect("Infl", PO.mod2), main="Main Effect of Influence", layout=c(3,1))
plot(Effect("Type", PO.mod2), main="Main Effect of Dwelling Type", layout=c(3,1))

plot(Effect("Cont", PO.mod2), main="Main Effect of Contact", layout=c(3,1))

plot(Effect(c("Infl","Type"), PO.mod2), style="stacked")
plot(Effect(c("Cont","Type"), PO.mod2), style="stacked")

