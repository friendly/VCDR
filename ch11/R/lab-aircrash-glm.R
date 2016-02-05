#' ---
#' title: "AirCrash data, Exercise 11.3"
#' author: "Michael Friendly"
#' date: "04 Feb 2016"
#' ---

data(AirCrash, package="vcdExtra")

library(car)
library(effects)
library(vcdExtra)
# (a) exploratory plots

# reorder Phase temporarlly
AirCrash$Phase <- factor(AirCrash$Phase,
		levels=c("standing", "take-off", "en route", "landing", "unknown"))
levels(AirCrash$Phase)


with(AirCrash, {
     plot(jitter(Fatalities+1) ~ Year, log="y",
          ylab = "log(Fatalities + 1)", cex.lab=1.25)
     lines(lowess(Year, Fatalities+1), col="blue", lwd=2)
		})

plot(Fatalities ~ cutfac(Year), data=AirCrash, log="y",
     ylab = "log(Fatalities)", xlab="Year (deciles)")

library(ggplot2)
ggplot(AirCrash, aes(Phase)) + geom_bar(aes(weight=Fatalities)) + ylab("Fatalities")
ggplot(AirCrash, aes(Cause)) + geom_bar(aes(weight=Fatalities)) + ylab("Fatalities")

ggplot (AirCrash, aes (Year)) + geom_bar() + 
	facet_grid (Cause ~.) + 
	theme ( legend.position= "none" ) + ylab ( "Cause" )


# (b)
crash.mod1 <- glm(Fatalities ~ Phase + Cause + Year, 
                 data=AirCrash, family=poisson)

Anova(crash.mod1)

plot(allEffects(crash.mod1), rows=1, cols=3)

# (c)
library(splines)
crash.mod2 <- glm(Fatalities ~ Phase + Cause + ns(Year,3), 
                 data=AirCrash, family=poisson)
Anova(crash.mod2)
anova(crash.mod1, crash.mod2, test="Chisq")

plot(allEffects(crash.mod2))

plot(Effect("Year", crash.mod2))


# (d)
#add1(crash.mod2, scope= ~(Phase + Cause + ns(Year,3))^2, test="Chisq")
add1(crash.mod2, scope= ~.^2, test="Chisq")

library(MASS)
crash.modAIC <- stepAIC(crash.mod2, scope=list(upper = ~.^2 ))

#plot(allEffects(crash.modAIC))

plot(allEffects(crash.modAIC)[[1]], multiline=TRUE)
# Phase:Cause
plot(allEffects(crash.modAIC)[[2]], multiline=TRUE)


# refit the stepAIC final model
crash.modAIC <- update(crash.mod2, .~. + Phase:Cause + Phase:ns(Year, 3) + Cause:ns(Year, 3))
Anova(crash.modAIC)

plot(Effect(c("Phase", "Cause"), crash.modAIC), 
     multiline=TRUE, lwd=3, key.args=list(x=0.5, y=0.2))


