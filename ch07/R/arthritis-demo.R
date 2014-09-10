library(vcdExtra)

data(Arthritis)


Arthritis$Better <- as.numeric(Arthritis$Improved > "None")

arth.lm <- lm(Better ~ Age, data=Arthritis)
arth.logistic <- glm(Better ~ Age, data=Arthritis, family=binomial)

plot(jitter(Better, .1) ~ Age, data=Arthritis, cex=1.25, pch=16,
	xlim = c(15,85),
	col=c("pink","lightblue")[1+Better],
	ylab="Probability (Better)"
	)

abline(arth.lm, lwd=2)

pred.logistic <- predict(arth.logistic, newdata=data.frame(Age=seq(15, 85, 5)),
	type="response", se.fit=TRUE)


lines(lowess(Arthritis$Better, Arthritis$Age), col="blue", lwd=2)


# annotations don't work here
library(effects)
arth.eff <- Effect("Age", arth.logistic, xlevels=list(Age=seq(15, 85, 5)))
plot(arth.eff, rescale.axis=FALSE, ylim=c(0,1))

points(Arthritis$Age, jitter(Arthritis$Better, .1), pch=1.5)
abline(arth.lm)
lines(lowess(Arthritis$Better, $Arthritis$Age), , col="blue", lwd=2)

# use ggplot

library(ggplot2)
# basic logistic regression plot
gg <- ggplot(Arthritis, aes(Age, Better)) + xlim(5, 95) + theme_bw() +
	geom_point(position = position_jitter(height = 0.02, width = 0)) +
	stat_smooth(method = "glm", family = binomial, alpha = 0.1, fill="blue", size=2.5, fullrange=TRUE)

# add a linear model smoother
gg <- gg + stat_smooth(method = "lm", se=FALSE, size=1.2, color="black", fullrange=TRUE) 
# add a non-parametric loess smoother
#gg + stat_smooth(method = "loess", span=0.9, formula = y ~ x, se=FALSE, size=1, color="red", fullrange=TRUE)
gg <- gg + stat_smooth(method = "loess", span=0.95, se=FALSE, colour="red", size=1.2)
gg

folder <- "C:/Documents and Settings/friendly/My Documents/My Dropbox/Documents/VCDR/ch07/fig"
setwd(folder)
dev.copy2pdf(file="arthritis-age.pdf", height=6, width=6)

