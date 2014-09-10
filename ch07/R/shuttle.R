data("SpaceShuttle", package="vcd")

# handle missing: delete from data frame
# SpaceShuttle <- subset(SpaceShuttle, !is.na(nFailures))
# or else, use subset=!is.na(nFailures) in call to glm
# or na.action = na.exclude
# when na.exclude is used the residuals and predictions are padded to the correct length 
# by inserting NAs for cases omitted by na.exclude.

shuttle.mod <- glm(cbind(nFailures, 6 - nFailures) ~ Temperature,
          data = SpaceShuttle,
          family = binomial)

## using subset
#shuttle.mod <- glm(cbind(nFailures, 6 - nFailures) ~ Temperature,
#          data = SpaceShuttle, subset=!is.na(nFailures),
#          family = binomial)

# using na.exclude
shuttle.mod <- glm(cbind(nFailures, 6 - nFailures) ~ Temperature,
          data = SpaceShuttle, na.action=na.exclude,
          family = binomial)


# alternative, using proportion and weights

SpaceShuttle$trials <- 6
shuttle.modw <- glm(nFailures/trials ~ Temperature, weight = trials,
          data = SpaceShuttle, na.action=na.exclude,
          family = binomial)

all.equal(coef(shuttle.mod), coef(shuttle.modw))

# testing, vs. null model
anova(shuttle.mod, test="Chisq")



# plotting

plot(nFailures/6 ~ Temperature, data = SpaceShuttle,
     xlim = c(30, 81), ylim = c(0,1),
#     main = "NASA Space Shuttle O-Ring Failures",
     ylab = "Estimated failure probability",
     xlab = "Temperature (degrees F)",
     pch = 19, col = "blue", cex=1.2)

pred <- predict(shuttle.mod, data.frame(Temperature = 30 : 81), se=TRUE)

logit2p <- function(logit) 1/(1 + exp(-logit))
predicted <- data.frame(
    Temperature = 30 : 81,
		prob = logit2p(pred$fit),
		lower = logit2p(pred$fit - 2*pred$se),
		upper = logit2p(pred$fit + 2*pred$se)
		)

## using type="response"; doesn't work
#pred <- predict(shuttle.mod, data.frame(Temperature = 30 : 81), type="response", se=TRUE)
#
#predicted <- data.frame(
#    Temperature = 30 : 81,
#		prob = pred$fit,
#		lower = pred$fit - 2*pred$se,
#		upper = pred$fit + 2*pred$se
#		)



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

library(ggplot2)
pdf(file="nasa-temp-ggplot.pdf", height=6, width=6)
ggplot(SpaceShuttle, aes(x = Temperature, y = nFailures / trials)) +
		xlim(30, 81) + theme_bw() +
		xlab("Temperature (F)") +
		ylab("O-Ring Failure Probability") +
    geom_point(position=position_jitter(width=0, height=0.01), aes(size = 2)) + theme(legend.position="none") +    
    geom_smooth(method = "glm", family = binomial, fill="blue", 
                 aes(weight = trials), fullrange = TRUE, alpha=0.2, size=2)
dev.off()
