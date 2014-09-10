data("SpaceShuttle", package="vcd")
logit2p <- function(logit) 1/(1 + exp(-logit))

plot(nFailures/6 ~ Temperature, data = SpaceShuttle,
     xlim = c(30, 81), ylim = c(0,1),
     main = "NASA Space Shuttle O-Ring Failures",
     ylab = "Estimated failure probability",
     xlab = "Temperature (degrees F)",
     pch = 19, col = "blue", cex=1.2)

fm <- glm(cbind(nFailures, 6 - nFailures) ~ Temperature,
          data = SpaceShuttle,
          family = binomial)
pred <- predict(fm, data.frame(Temperature = 30 : 81), se=TRUE)

predicted <- data.frame(
    Temperature = 30 : 81,
		prob = logit2p(pred$fit),
		lower = logit2p(pred$fit - 2*pred$se),
		upper = logit2p(pred$fit + 2*pred$se)
		)

with(predicted, {
	polygon(c(Temperature, rev(Temperature)),
	        c(lower, rev(upper)), col="lightpink", border=NA)
	lines(Temperature, prob, lwd=3)
	}
	)
# points are obscured by prediction band; add them back
with(SpaceShuttle,
	points(Temperature, nFailures/6, col="blue", pch=19, cex=1.25)
	)
	

abline(v = 31, lty = 3)


lines(30 : 81,
      predict(fm, data.frame(Temperature = 30 : 81), type = "response"),
      lwd = 3)

#lines(predicted$Temperature, predicted$lower, col="red", lty=2, lwd=2)
#lines(predicted$Temperature, predicted$upper, col="red", lty=2, lwd=2)

#################################################################
# From R-help, "ONKELINX, Thierry" <Thierry.ONKELINX@inbo.be>	
	
data("SpaceShuttle", package="vcd")
SpaceShuttle$trials <- 6

fm <- glm(cbind(nFailures, 6 - nFailures) ~ Temperature, data = SpaceShuttle, family = binomial)
fm2 <- glm(nFailures/trials ~ Temperature, data = SpaceShuttle, family = binomial, weight = trials)
all.equal(coef(fm), coef(fm2))

library(ggplot2)
#ggplot(SpaceShuttle, aes(x = Temperature, y = nFailures / trials)) + 
#	xlim(30, 81) +
#	geom_point() + 
#	geom_smooth(method = "glm", family = binomial, aes(weight = trials), fullrange=TRUE) 
	
ggplot(SpaceShuttle, aes(x = Temperature, y = nFailures / trials)) +
		xlim(30, 81) + theme_bw() +
     geom_point(aes(colour="blue", size = 2)) +  theme(legend.position="none") +    
     geom_smooth(method = "glm", family = binomial,  
                 aes(weight = trials), fullrange = TRUE, alpha=0.3, size=2)
 
##########################################################################

# another way, calculating the confidence band and using stat="identity"

pred <- predict(fm, data.frame(Temperature = 30 : 81), se=TRUE)

predicted <- data.frame(
    Temperature = 30 : 81,
		prob = logit2p(pred$fit),
		lower = logit2p(pred$fit - 2*pred$se),
		upper = logit2p(pred$fit + 2*pred$se)
		)

ggplot(SpaceShuttle, aes(x = Temperature, y = nFailures / trials)) +
  geom_point(aes(colour="blue", size = 2)) +  theme(legend.position="none") +    
  geom_smooth(aes(y=prob, ymin = lower, ymax = upper), data=predicted, stat="identity")


#####################################################################
model <- lm(mpg ~ wt + factor(cyl), data=mtcars)
grid <- with(mtcars, expand.grid(
  wt = seq(min(wt), max(wt), length = 20),
  cyl = levels(factor(cyl))
))

grid$mpg <- stats::predict(model, newdata=grid)

qplot(wt, mpg, data=mtcars, colour=factor(cyl)) + geom_line(data=grid)

# or with standard errors

err <- stats::predict(model, newdata=grid, se = TRUE)
grid$ucl <- err$fit + 1.96 * err$se.fit
grid$lcl <- err$fit - 1.96 * err$se.fit

qplot(wt, mpg, data=mtcars, colour=factor(cyl)) +
  geom_smooth(aes(ymin = lcl, ymax = ucl), data=grid, stat="identity")

