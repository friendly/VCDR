library(Lahman)
library(plyr)

# Result of a player's last year on the BBWAA ballot
# Restrict to players voted by BBWAA:
HOFplayers <- subset(HallOfFame, votedBy == 'BBWAA' & category == 'Player')

# Function to calculate number of years as HOF candidate, last pct vote, etc.
# for a given player
HOFun <- function(d) {
    nyears <- nrow(d)
    fy <- d[nyears, ]
    lastPct <- with(fy, 100 * round(votes/ballots, 3))
    data.frame(playerID = fy$playerID, nyears, induct = fy$inducted,
               lastPct, lastYear = fy$yearID)
}

playerOutcomesHOF <- ddply(HOFplayers, .(playerID), HOFun)


############################################################
# How many voting years until election?
inducted <- subset(playerOutcomesHOF,induct == 'Y')

hof.tab <- table(inducted$nyears)

library(xtable)
xtable(t(hof.tab))


barplot(hof.tab, main="Number of voting years until election",
		ylab="Number of players", xlab="Years")

# What is the form of this distribution?
require('vcd')
goodfit(hof.tab)
plot(goodfit(inducted$nyears), xlab='Number of years',
	main="Poissonness plot of number of years voting until election")

Ord_plot(hof.tab, xlab='Number of years')


library(VGAM)
hof.dat <- data.frame(nyears=as.numeric(names(hof.tab)), Freq=as.numeric(hof.tab))
hof.tpois <- vglm(nyears ~ 1, pospoisson, data=hof.dat, weights=Freq)

hof.tpois <- vglm(Freq ~ nyears, pospoisson, data=hof.dat)
fitted(hof.tpois)

rootogram(hof.tab, fitted(hof.tpois))
plotvgam(hof.tpois, se=TRUE, residuals=TRUE)





