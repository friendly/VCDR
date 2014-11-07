# generalized logit model for TV data

library(vcdExtra)
data("TV", package="vcdExtra")
TV.df <- as.data.frame.table(TV)
levels(TV.df$Time) <- rep(c("8:00", "8:30",  "9:00", "9:30", "10:00", "10:30"), c(2, 2, 2, 2, 2, 1))



library(car)
library(nnet)
library(effects)

TV.multinom1 <- multinom(Network ~ Day + Time, weights=Freq, data=TV.df)
TV.multinom1
Anova(TV.multinom1)

TV.eff1 <- allEffects(TV.multinom1)
plot(TV.eff1)

plot(TV.eff1, "Day")


# use Time as numeric
nTime <- as.POSIXct(strptime(TV.df$Time, "%H:%M"))
library(lubridate)
TV.df$nTime <- hour(nTime) + minute(nTime)/60

library(splines)
TV.multinom1a <- multinom(Network ~ Day + ns(nTime, 4), weights=Freq, data=TV.df)
TV.multinom1a
Anova(TV.multinom1a)

TV.eff1a <- allEffects(TV.multinom1a)
plot(TV.eff1a)


TV.multinom2 <- multinom(Network ~ Day * Time, weights=Freq, data=TV.df)
TV.multinom2
Anova(TV.multinom2)

TV.eff2 <- allEffects(TV.multinom2)
plot(TV.eff2)





