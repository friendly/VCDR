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

