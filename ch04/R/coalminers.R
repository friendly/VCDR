## Fourfold display, both margins equated
data("CoalMiners", package="vcd")
fourfold(CoalMiners, mfcol = c(2,4))

oddsratio(CoalMiners)
oddsratio(CoalMiners, log=FALSE)


## Log Odds Ratio Plot
lodds <- oddsratio(CoalMiners)
summary(lodds <- oddsratio(CoalMiners))

plot(lodds, lwd=2, cex=1.25, pch=16,
     xlab = "Age Group",
     main = "Breathlessness and Wheeze in Coal Miners")

age <- seq(25, 60, by = 5)
mod <- lm(lodds ~ poly(age,2))
lines(fitted(mod), col = "red", lwd=2)

# quadratic term NS
summary(mod)

## Fourfold display, strata equated
fourfold(CoalMiners, std = "ind.max", mfcol = c(2,4))

