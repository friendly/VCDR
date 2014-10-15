# Residual and diagnostic plots

data("PhdPubs", package="vcdExtra")

library(MASS)
phd.nbin  <- glm.nb(articles ~ ., data=PhdPubs)

op <- par(mfrow=c(2,2), mar=c(4,4,2,1)+.1, cex.lab=1.2)
plot(phd.nbin)
par(op)

library(car)
 
# residuals vs. fitted
residualPlot(phd.nbin, type="deviance", col.smooth="red", id.n=3)
residualPlot(phd.nbin, type="rstandard", col.smooth="red", id.n=3)

# grouped, to show structure
residualPlot(phd.nbin, type="rstandard", col.smooth="red", groups=PhdPubs$articles, key=FALSE)

# suppress that error:
try(
residualPlot(phd.nbin, type="rstandard", col.smooth="red", groups=PhdPubs$articles, key=FALSE),
silent=TRUE)

# better: don't need linear or smooth
residualPlot(phd.nbin, type="rstandard", groups=PhdPubs$articles, key=FALSE, linear=FALSE, smoother=NULL)



# against a predictor, showing quadratic fit
residualPlot(phd.nbin, "mentor", type="rstudent", quadratic=TRUE, col.smooth="red", col.quad="blue", id.n=3)
residualPlot(phd.nbin, "phdprestige", type="rstudent", quadratic=TRUE, col.smooth="red", col.quad="blue", id.n=3)

# all plots
residualPlots(phd.nbin, type="rstudent", quadratic=TRUE, col.smooth="red", col.quad="blue", id.n=3)



# ggplot2
library(ggplot2)
pred <- data.frame(fit = fitted(phd.nbin), resid = rstudent(phd.nbin), articles=PhdPubs$articles)


ggplot(pred, aes(x=fit, y=resid)) +
	geom_point(aes(color=factor(articles)), show_guide=FALSE) +
	geom_smooth(method="loess", fill="gray", size=1.5) +
	scale_x_log10(breaks=c(1,2,5,10)) +
	labs(x="Linear predictor", y="Rstudent residual") +
	theme_bw()

#ggplot(pred, aes(x=fit, y=resid, color=factor(articles))) +
#	geom_point(show_guide=FALSE)  +
#	scale_x_log10(breaks=c(1,2,5,10)) + 
#	labs(x="Linear predictor", y="Rstudent residual") +
#	theme_bw()
	
spreadLevelPlot(phd.nbin, main="")

influencePlot(phd.nbin)
outlierTest(phd.nbin)

# try to use code from plot() method to draw contours of Cook's distance -- doesn't work
hat <- hatvalues(phd.nbin)
cook.levels <- c(0.5, 1)
r.hat <- range(hat, na.rm = TRUE)
p <- length(coef(phd.nbin))
usr <- par("usr")
hh <- seq.int(min(r.hat[1], r.hat[2]/100), 
  usr[2], length.out = 101)
for (crit in cook.levels) {
  cl.h <- sqrt(crit * p * (1 - hh)/hh)
  lines(hh, cl.h, lty = 2, col = 2)
  lines(hh, -cl.h, lty = 2, col = 2)
  }
                


