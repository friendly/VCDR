library(vcdExtra)

data(Arthritis)
Arthritis$Better <- as.numeric(Arthritis$Improved > "None")

arth.lm <- lm(Better ~ Age, data=Arthritis)
arth.logistic <- glm(Better ~ Age, data=Arthritis, family=binomial)
summary(arth.logistic)

## working with coefficients

coef(arth.logistic)
exp(coef(arth.logistic))
exp(10*coef(arth.logistic)[2])

# linear probability model
arth.lm <- lm(Better ~ Age, data=Arthritis)
arth.lm <- glm(Better ~ Age, data=Arthritis)
coef(arth.lm)



## tests
# residual deviance (vs. saturated model)
summarise(arth.logistic)

# vs. null model
arth.logistic.null <- glm(Better ~ 1, data=Arthritis, family=binomial)
anova(arth.logistic.null, arth.logistic, test="Chisq")

# Hosmer Lemeshow test
HLtest(arth.logistic)
plot(HLtest(arth.logistic))


## plots

plot(jitter(Better, .1) ~ Age, data=Arthritis, 
	xlim = c(15,85),	pch=16,
	ylab="Probability (Better)"
	)

xvalues <- seq(15, 85, 5)
pred.logistic <- predict(arth.logistic, 
                         newdata=data.frame(Age=xvalues),
                         type="response", se.fit=TRUE)

upper <- pred.logistic$fit + 1.96*pred.logistic$se.fit
lower <- pred.logistic$fit - 1.96*pred.logistic$se.fit

# NB: col could be given as: c(c(col2rgb("blue")/255), 0.2)
polygon(c(xvalues, rev(xvalues)),
        c(upper, rev(lower)), 
        col=rgb(0, 0, 1, .2), border=NA)
lines(xvalues, pred.logistic$fit, lwd=4 , col="blue")

abline(arth.lm, lwd=2)
        
lines(lowess(Arthritis$Age, Arthritis$Better, f=.9), col="red", lwd=2)

#######################################################################
# try the same with effects package

library(effects)
arth.eff <- Effect("Age", arth.logistic, xlevels=list(Age=seq(15, 85, 5)))
(arth.effplot <- plot(arth.eff, rescale.axis=FALSE, ylim=c(0,1)))


library(latticeExtra)
arth.effplot + 
    xyplot(Better ~ Age, data=Arthritis,
        panel=function(x, y){
            panel.xyplot(x, jitter(ifelse(y == 1, 0.975, 0.025), .1), pch=1.5)
            panel.lmline(x, y)
            panel.loess(x, y, family="gaussian", span=0.9)
        }
    )


############################################################
# use ggplot

library(ggplot2)

# OLS regression plot
set.seed(12345)
ggplot(Arthritis, aes(Age, Better)) + xlim(5, 95) + theme_bw() +
	geom_point(position = position_jitter(height = 0.03, width = 0), size=2.5) +
	stat_smooth(method = "lm", family = binomial, alpha = 0.1, fill="red", color="red", size=2.5, fullrange=TRUE)

folder <- "C:/Dropbox/Documents/VCDR/ch07/fig"
setwd(folder)
dev.copy2pdf(file="arthritis-ols.pdf", height=6, width=6)

# basic logistic regression plot
set.seed(12345)
gg <- ggplot(Arthritis, aes(Age, Better)) + xlim(5, 95) + theme_bw() +
	geom_point(position = position_jitter(height = 0.03, width = 0), size=2.5) +
	stat_smooth(method = "glm", family = binomial, alpha = 0.1, fill="blue", size=2.5, fullrange=TRUE)

# add a linear model smoother
gg <- gg + stat_smooth(method = "lm", se=FALSE, size=1.2, color="red", fullrange=TRUE) 
# add a non-parametric loess smoother
#gg + stat_smooth(method = "loess", span=0.9, formula = y ~ x, se=FALSE, size=1, color="red", fullrange=TRUE)
gg <- gg + stat_smooth(method = "loess", span=0.95, se=FALSE, colour="green3", size=1.2)
gg

dev.copy2pdf(file="arthritis-age.pdf", height=6, width=6)

