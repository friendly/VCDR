data("NMES1988", package="AER")
nmes2 <- NMES1988[, c(1:4, 6:8, 13, 15, 18)]

clog <- function(x) log(x+1)

nmes.mlm <- lm(clog(cbind(visits, nvisits, ovisits, novisits)) ~ ., data=nmes2)

library(car)
Anova(nmes.mlm)

library(heplots)

heplot(nmes.mlm)
pairs(nmes.mlm)


library(ggplot2)

ggplot(nmes2, aes(x=clog(visits), y=clog(nvisits))) + 
	geom_point(size=0.75, position=position_jitter(h=.2, w=.2)) + geom_density2d(size=1.25) + 
	stat_smooth(method="gam", formula=y ~ s(x, bs = "cs"))
	
resids <- residuals(nmes.mlm, type="deviance")
str(resids)

ggplot(data.frame(resids), aes(x=visits, y=nvisits)) + 
	geom_point(size=0.75, position=position_jitter(h=.2, w=.2)) +
	geom_density2d(size=1.2, color="red") + 
#	stat_density2d(aes(fill = ..level..), geom="polygon") +
#	stat_smooth(method="gam", formula=y ~ s(x, bs = "cs")) +
	stat_smooth(method="loess", size=1.2) + 
	labs(x="residual(Physician office visits)", y="residual(Non-physician office visits)") +
	theme_bw()


