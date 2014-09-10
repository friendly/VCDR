# Examples from John Fox's JSS paper

library(effects)    # for Arrests data
library(car)        # for Anova()
data(Arrests)
Arrests$year <- as.factor(Arrests$year)

arrests.mod <- glm(released ~ employed + citizen + checks
 + colour*year + colour*age,
 family=binomial, data=Arrests)

Anova(arrests.mod)

coef(arrests.mod)


plot(Effect("colour", arrests.mod), 
  lwd=3, ci.style="bands", main="",
  xlab = list("Skin color of arrestee", cex=1.25),
  ylab = list("Probability(released)", cex=1.25)
  )


# colour x year interaction
#plot(effect("colour:year", arrests.mod),
#      multiline=TRUE, ylab="Probability(released)")

plot(Effect(c("colour","year"), arrests.mod),
     lwd=3, multiline=TRUE, 
     xlab=list("Year", cex=1.25), 
     ylab=list("Probability(released)", cex=1.25),
     key.args=list(x=.7, y=.99, cex=1.2)
     )

# colour x age interaction
plot(Effect(c("colour","age"), arrests.mod),
     lwd=3, multiline=TRUE,
     xlab=list("Age", cex=1.25), 
     ylab=list("Probability(released)", cex=1.25),
     key.args=list(x=.05, y=.99, cex=1.2)
     )

# Plot 3-way effect (not in model)
plot(effect("colour:year:age", arrests.mod, xlevels=list(age=15:45)),
  multiline=TRUE, ylab="Probability(released)", rug=FALSE)


# all effects
arrests.effects <- allEffects(arrests.mod, xlevels=list(age=seq(15,45,5)))
plot(arrests.effects, ylab="Probability(released)", ci.style="bands", ask=FALSE)
 
     