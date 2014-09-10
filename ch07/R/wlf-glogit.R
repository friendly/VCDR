# multinomial logistic regression

library(car)
data("Womenlf", package="car")

#participation <- ordered(partic, 
#    levels=c('not.work', 'parttime', 'fulltime'))
Womenlf$partic <- relevel(Womenlf$partic, ref="not.work")

library(nnet)
wlf.multinom <- multinom(partic ~ hincome + children, 
                         data=Womenlf, Hess=TRUE)
summary(wlf.multinom, Wald=TRUE)
Anova(wlf.multinom)

## p-values

stats <- summary(wlf.multinom, Wald=TRUE)
z <- stats$Wald.ratios
p <- 2 * (1 - pnorm(abs(z)))
zapsmall(p)


## test for interaction
wlf.multinom2 <- multinom(partic ~ hincome * children, 
                         data=Womenlf, Hess=TRUE)
Anova(wlf.multinom2)


######################################################
# plotting

# old code
#predictors <- expand.grid(hincome=1:50, children=c('absent', 'present'))
#p.fit <- predict(wlf.multinom, predictors, type='probs')
#
#attach(Womenlf)
#
#Hinc <- 1:max(hincome)
#plot(range(hincome), c(0,1), 
#    type='n', xlab="Husband's Income", ylab='Fitted Probability',
#    main="Children absent")
#lines(Hinc, p.fit[Hinc, 'not.work'], lty=1, lwd=3, col="black")
#lines(Hinc, p.fit[Hinc, 'parttime'], lty=2, lwd=3, col="blue")
#lines(Hinc, p.fit[Hinc, 'fulltime'], lty=3, lwd=3, col="red")
#
#legend(5, 0.97, lty=1:3, lwd=3, col=c("black", "blue", "red"),
#    legend=c('not working', 'part-time', 'full-time'))  
#
#plot(range(hincome), c(0,1), 
#    type='n', xlab="Husband's Income", ylab='Fitted Probability',
#    main="Children present")
#lines(Hinc, p.fit[46:90, 'not.work'], lty=1, lwd=3, col="black")
#lines(Hinc, p.fit[46:90, 'parttime'], lty=2, lwd=3, col="blue")
#lines(Hinc, p.fit[46:90, 'fulltime'], lty=3, lwd=3, col="red")


## a more general way to make the plot
#op <- par(mfrow=c(1,2))
#Hinc <- 1:max(hincome)
#for ( kids in c("absent", "present") ) {
#	data <- subset(data.frame(predictors, p.fit), children==kids)
#	plot( range(hincome), c(0,1), type="n",
#		xlab="Husband's Income", ylab='Fitted Probability',
#		main = paste("Children", kids))
#	lines(Hinc, data[, 'not.work'], lwd=3, col="black", lty=1)
#	lines(Hinc, data[, 'parttime'], lwd=3, col="blue",  lty=2)
#	lines(Hinc, data[, 'fulltime'], lwd=3, col="red",   lty=3)
#  if (kids=="absent") {
#  legend(5, 0.97, lty=1:3, lwd=3, col=c("black", "blue", "red"),
#    legend=c('not working', 'part-time', 'full-time'))
#    }
#}
#par(op)
#detach(Womenlf)

#############################################################
## without using attach

predictors <- expand.grid(hincome=1:50, children=c('absent', 'present'))
fit <- data.frame(predictors,
                  predict(wlf.multinom, predictors, type='probs')
)
some(fit, 5)


# or, using the data frame for a data-centric plot 
fit2 <- data.frame(Womenlf[,1:3],
                   predict(wlf.multinom, type='probs')
)
some(fit2, 5)

## base graphics plots 
op <- par(mfrow=c(1,2), mar=c(5,4,4,1)+.1)
Hinc <- 1:max(fit$hincome)
for ( kids in c("absent", "present") ) {
	data <- subset(fit, children==kids)
	plot( range(Hinc), c(0,1), type="n", cex.lab=1.25,
		xlab="Husband's Income", ylab='Fitted Probability',
		main = paste("Children", kids))
	lines(Hinc, data$not.work, lwd=3, col="black", lty=1)
	lines(Hinc, data$parttime, lwd=3, col="blue",  lty=2)
	lines(Hinc, data$fulltime, lwd=3, col="red",   lty=3)
  if (kids=="absent") {
  legend("topright", lty=1:3, lwd=3, col=c("black", "blue", "red"),
    legend=c('not working', 'part-time', 'full-time'))
    }
}
par(op)

## using ggplot2

library(reshape2)
plotdat <- melt(fit, 
                id.vars = c("hincome", "children"), 
                measure.vars=c("not.work", "parttime", "fulltime"), 
                variable.name = "Level",
                value.name = "Probability")
## view some  rows
some(plotdat)


ggplot(plotdat, aes(x = hincome, y = Probability, colour = Level)) + 
    geom_line(size=1.5) + theme_bw() + # geom_point(color="black") +
    facet_grid(~ children, # scales = "free", 
               labeller = function(x, y) sprintf("%s = %s", x, y)
               )


#library(directlabels)
#direct.label(gg)


#############################################

# effect plots

library(effects)

# re-order partic for a more natural display
Womenlf$partic <- ordered(Womenlf$partic, levels=c('not.work', 'parttime', 'fulltime'))
wlf.multinom <- update(wlf.multinom, . ~ .)


wlf.effects <- allEffects(wlf.multinom)
plot(wlf.effects)  # visualize all main effects
plot(wlf.effects, style='stacked')

plot(Effect(c("hincome", "children"), wlf.multinom))
# plot(Effect(c("hincome", "children"), wlf.multinom), style="stacked")
plot(Effect(c("hincome", "children"), wlf.multinom), style="stacked", key.args=list(x=.05, y=.9))






