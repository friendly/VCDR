
data("NMES1988", package="AER")
nmes2 <- NMES1988[, c(1:4, 6:8, 13, 15, 18)]

clog <- function(x) log(x+1)
nmes.mlm <- lm(clog(cbind(visits, nvisits, ovisits, novisits)) ~ ., data=nmes2)
resids <- residuals(nmes.mlm, type="deviance")

# (b) density plots of residuals
op <- par(mfrow=c(2,2), mar=c(5,4,2,1)+0.1)
plot(density(resids[,1]), main = "Residuals for visits")
rug(resids[,1])

plot(density(resids[,2]), main = "Residuals for nvisits")
rug(resids[,2])

plot(density(resids[,3]), main = "Residuals for ovisits")
rug(resids[,3])

plot(density(resids[,4]), main = "Residuals for novisits")
rug(resids[,4])
par(op)

# (c)
library(ggplot2)

ggplot(as.data.frame(resids), aes(x=visits, y=nvisits)) +
	geom_point(size=0.6) + ylim(c(-1, 3)) +
	stat_smooth(method="lm") +
	geom_density2d(size=1.5) + theme_bw()

# compare with HE plot in Fig 11.40
library(heplots)
heplot(nmes.mlm, variables=1:2, fill=c(TRUE, FALSE))



