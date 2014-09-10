# Polytomous Data: nested dichotomies

library(car)   # for data and Anova()
data("Womenlf", package="car")
some(Womenlf)

# create dichotomies
Womenlf <- within(Womenlf,{
  working <- recode(partic, " 'not.work' = 'no'; else = 'yes' ")
  fulltime <- recode (partic, 
    " 'fulltime' = 'yes'; 'parttime' = 'no'; 'not.work' = NA")})
some(Womenlf)

with(Womenlf, table(partic, working))
with(Womenlf, table(partic, fulltime, useNA="ifany"))

## TODO: change mod.* to wlf.* to make consistent with data.object naming


# fit models for each dichotomy
#Womenlf <- within(Womenlf, contrasts(children)<- 'contr.treatment')
mod.working <- glm(working ~ hincome + children, family=binomial, data=Womenlf)
summary(mod.working)
Anova(mod.working)  

mod.fulltime <- glm(fulltime ~ hincome + children, family=binomial, data=Womenlf)
summary(mod.fulltime)
Anova(mod.fulltime)

cbind(working=coef(mod.working), fulltime=coef(mod.fulltime))

# testing H0: beta=0 in combined model

LRtest <- function(model)
	c(LRchisq=(model$null.deviance - model$deviance),
	  df=(model$df.null - model$df.residual))

LRtest(mod.working)

tab <- rbind(working=LRtest(mod.working),
             fulltime=LRtest(mod.fulltime))
tab <- rbind(tab, All = colSums(tab))
tab <- cbind(tab, pvalue = 1- pchisq(tab[,1], tab[,2]))
tab



####################################################
# plotting


#attach(Womenlf)
## get fitted values for both sub-models
#predictors <- expand.grid(hincome=1:45, children=c('absent', 'present'))
#p.work <- predict(mod.working, predictors, type='response')
#p.fulltime <- predict(mod.fulltime, predictors, type='response')
#
## calculate unconditional probs for the three response categories
#p.full <- p.work * p.fulltime
#p.part <- p.work * (1 - p.fulltime)
#p.not <- 1 - p.work
#
### NB: the plot looks best if the plot window is made wider than tall
#op <- par(mfrow=c(1,2))
## children absent panel
#plot(c(1,45), c(0,1), 
#    type='n', xlab="Husband's Income", ylab='Fitted Probability',
#    main="Children absent")
#lines(1:45, p.not[1:45], lty=1, lwd=3, col="black")
#lines(1:45, p.part[1:45], lty=2, lwd=3, col="blue")
#lines(1:45, p.full[1:45], lty=3, lwd=3, col="red")
#
#legend(5, 0.97, lty=1:3, lwd=3, col=c("black", "blue", "red"),
#    legend=c('not working', 'part-time', 'full-time'))  
#
## children present panel
#plot(c(1,45), c(0,1), 
#    type='n', xlab="Husband's Income", ylab='Fitted Probability',
#    main="Children present")
#lines(1:45, p.not[46:90], lty=1, lwd=3, col="black")
#lines(1:45, p.part[46:90], lty=2, lwd=3, col="blue")
#lines(1:45, p.full[46:90], lty=3, lwd=3, col="red")
#par(op)
#detach(Womenlf)

#############################################################
# without attach
predictors <- expand.grid(hincome=1:50, children=c('absent', 'present'))
fit <- data.frame(predictors,
    p.working = predict(mod.working, predictors, type='response'),
    p.fulltime = predict(mod.fulltime, predictors, type='response'),
    l.working = predict(mod.working, predictors, type='link'),
    l.fulltime = predict(mod.fulltime, predictors, type='link')
)
some(fit, 5)


fit <- within(fit, {
	full <- p.working * p.fulltime
	part <- p.working * (1 - p.fulltime)
	not  <- 1 - p.working
})

		

# a more general way to make the plot
op <- par(mfrow=c(1,2), mar=c(5,4,4,1)+.1)
Hinc <- 1:max(fit$hincome)
for ( kids in c("absent", "present") ) {
	data <- subset(fit, children==kids)
	plot( range(Hinc), c(0,1), type="n",
		xlab="Husband's Income", ylab='Fitted Probability',
		main = paste("Children", kids))
	lines(Hinc, data$not,  lwd=3, col="black", lty=1)
	lines(Hinc, data$part, lwd=3, col="blue",  lty=2)
	lines(Hinc, data$full, lwd=3, col="red",   lty=3)
  if (kids=="absent") {
  legend("topright", lty=1:3, lwd=3, col=c("black", "blue", "red"),
    legend=c('not working', 'part-time', 'full-time'))
    }
}
par(op)


# logit plot
op <- par(mfrow=c(1,2), mar=c(5,4,1,1)+.1)
for ( kids in c("absent", "present") ) {
	data <- subset(fit, children==kids)
	plot( range(Hinc), c(-4,5), type="n",
		xlab="Husband's Income", ylab='Fitted log odds'
#		main = paste("Children", kids)
		)
	lines(Hinc, data$l.working,  lwd=3, col="black", lty=1)
	lines(Hinc, data$l.fulltime, lwd=3, col="blue",  lty=2)
	text(25,4.5, paste("Children", kids), cex=1.4)
  if (kids=="absent") {
  legend("bottomleft", lty=1:3, lwd=3, col=c("black", "blue"),
    legend=c('working', 'full-time'))
    }
}
par(op)

  
## test proportional odds assumption: exercise

data("Womenlf", package="car")
Womenlf$partic <- ordered(levels=c("not.work", "parttime", "fulltime"))

library(VGAM)
women.po <- vglm(partic ~ hincome + children, data=Womenlf,
	family = cumulative(parallel=TRUE))

women.npo <- vglm(partic ~ hincome + children, data=Womenlf,
	family = cumulative(parallel=FALSE))

