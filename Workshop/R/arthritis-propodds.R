library(vcd)
library(car)         # for Anova()
library(MASS)

arth.polr <- polr(Improved ~ Sex + Treatment + Age, data=Arthritis, Hess=TRUE)
summary(arth.polr)
Anova(arth.polr)      # Type II tests

#newdat <- cbind(newdat, predict(m, newdat, type = "probs"))

### Plotting response probabilities

arth.fitp <- cbind(Arthritis,
                  arth.polr$fitted.values)

head(arth.fitp)

library(reshape2)
plotdat <- melt(arth.fitp, id.vars = c("Sex", "Treatment", "Age"), 
                measure.vars=c("None", "Some", "Marked"), 
                variable.name = "Level",
                value.name = "Probability")
## view first few rows
head(plotdat)

library(ggplot2)

ggplot(plotdat, aes(x = Age, y = Probability, colour = Level)) + 
    geom_line(size=2) + theme_bw() +
    facet_grid(Sex ~ Treatment, # scales = "free", 
#               labeller = function(x, y) sprintf("%s = %d", x, y)
               )

# testing proportional odds assumption
# -- LR test -- compare the deviance of the PO model to the generalized logit model

library(VGAM)

arth.po <- vglm(Improved ~ Sex + Treatment + Age, data=Arthritis,
	family = cumulative(parallel=TRUE))
arth.po

arth.npo <- vglm(Improved ~ Sex + Treatment + Age, data=Arthritis,
	family = cumulative(parallel=FALSE))
arth.npo 

tab <- cbind(
	Deviance = c(deviance(arth.po), deviance(arth.npo)),
	df = c(df.residual(arth.po), df.residual(arth.npo))
	)
tab <- rbind(tab, -diff(tab))
tab

rownames(tab) <- c("PropOdds", "GenLogit", "LR test")
tab
tab <- cbind(tab, pchisq(tab[,1], tab[,2])
tab

 


#############################################################
# effect plots


library(effects)
arth.effects <- allEffects(arth.polr, xlevels=list(age=seq(15,45,5)) )
plot(arth.effects)  # visualize all main effects

plot(arth.effects)

plot(Effect("Sex", arth.polr)) # multiline has no effect

summary(Effect("Sex", arth.polr))


# plot terms not in model
plot(Effect("Sex:Age", arth.polr))
plot(Effect("Treatment:Age", arth.polr))


