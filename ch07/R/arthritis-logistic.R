library(vcdExtra)

data("Arthritis", package="vcd")
Arthritis$Better <- as.numeric(Arthritis$Improved > "None")

arth.logistic <- glm(Better ~ Age, data=Arthritis, family=binomial)


# main effects model
#arth.logistic2 <- glm(Better ~ Age + Sex + Treatment, data=Arthritis, family=binomial)


#summary(arth.logistic2)
## more compactly
#printCoefmat(summary(arth.logistic2)$coefficients)

library(lmtest)
coeftest(arth.logistic)


# center Age at 50
arth.logistic2 <- glm(Better ~ I(Age-50) + Sex + Treatment, data=Arthritis, family=binomial)
printCoefmat(summary(arth.logistic2)$coefficients)



# show odds ratios together with CI
exp(cbind(OddsRatio=coef(arth.logistic2), confint(arth.logistic2)))

# same, with coefficients
cbind(coef=coef(arth.logistic2), OddsRatio=exp(coef(arth.logistic2)), exp(confint(arth.logistic2)))



# test for interactions
arth.logistic3 <- update(arth.logistic2, . ~ .^2)
summary(arth.logistic3)

anova(arth.logistic3, test="Chisq")


anova(arth.logistic, arth.logistic2, arth.logistic3, test="Chisq")

summarise(glmlist(arth.logistic, arth.logistic2, arth.logistic3))

# add one interaction
arth.logistic4 <- update(arth.logistic2, . ~ . + Age:Sex)

# conditional plots with ggplot2

library(ggplot2)
# including sex as curves
gg <- ggplot(Arthritis, aes(Age, Better, color=Sex)) + 
  xlim(5, 95) + theme_bw() +
	geom_point(position = position_jitter(height = 0.02, width = 0)) +
	stat_smooth(method = "glm", family = binomial, alpha = 0.2, aes(fill=Sex), size=2.5, fullrange=TRUE)
gg
# separate panels by Treatment
gg + facet_wrap(~ Treatment)

# including treatment as curves
gg <- ggplot(Arthritis, aes(Age, Better, color=Treatment)) + 
  xlim(5, 95) + theme_bw() +
	geom_point(position = position_jitter(height = 0.02, width = 0)) +
	stat_smooth(method = "glm", family = binomial, alpha = 0.2, aes(fill=Treatment), size=2.5, fullrange=TRUE)
gg
gg + facet_wrap(~ Sex)

############################################################
# full-model plots with ggplot

arth.fit2 <- cbind(Arthritis,
                  predict(arth.logistic2, se.fit = TRUE))
arth.fit2$obs <- c(-4, 4 )[1+arth.fit2$Better]

gg2 <- ggplot( arth.fit2, aes(x=Age, y=fit, color=Treatment)) +               
  geom_line(size = 2) +
  geom_ribbon(aes(ymin = fit - 1.96 * se.fit,
                  ymax = fit + 1.96 * se.fit,
                  fill = Treatment), alpha = 0.2,
              color = "transparent") +
  labs(x = "Age", y = "Log odds (Better)") +
  geom_point(aes(y=obs), position=position_jitter(height=0.25, width=0))

gg2 + facet_wrap(~ Sex)

# plot on the probability scale

logit2p <- function(logit) 1/(1 + exp(-logit))
arth.fit2 <- within(arth.fit2, {
             prob  <- logit2p(fit)
             lower <- logit2p(fit - 1.96 * se.fit)
             upper <- logit2p(fit + 1.96 * se.fit)
             })

gg2 <- ggplot( arth.fit2, aes(x=Age, y=prob, color=Treatment)) +               
  geom_line(size = 2) +
  geom_ribbon(aes(ymin = lower,
                  ymax = upper,
                  fill = Treatment), alpha = 0.2,
              color = "transparent") +
  labs(x = "Age", y = "Probability (Better)") +
  geom_point(aes(y=Better), position=position_jitter(height=0.02, width=0)) + 
  facet_wrap(~ Sex)
gg2

# model with interaction

arth.fit4 <- cbind(Arthritis,
                  predict(arth.logistic4, se.fit = TRUE))
arth.fit4$obs <- c(-4, 4 )[1+arth.fit4$Better]

gg4 <- ggplot( arth.fit4, aes(x=Age, y=fit, color=Treatment)) +               
  geom_line(size = 2) +
  geom_ribbon(aes(ymin = fit - 1.96 * se.fit,
                  ymax = fit + 1.96 * se.fit,
                  fill = Treatment), alpha = 0.2,
              color = "transparent") +
  labs(x = "Age", y = "Log odds (Better)") + theme_bw() +
  geom_point(aes(y=obs), position=position_jitter(height=0.25, width=0))

gg4 + facet_wrap(~ Sex)

                 
#mod <- glm(survived ~ age*sex, family=binomial, data=Titanicp)
#modp <- cbind(Titanicp[, c("survived", "sex", "age")],
#              predict(mod, se.fit = TRUE))

p <- ggplot(modp, aes(x = age, y = fit, color = sex)) +
  geom_line(size = 2) +
  geom_ribbon(aes(ymin = fit - 1.96 * se.fit,
                  ymax = fit + 1.96 * se.fit,
                  fill = sex), alpha = 0.2,
              color = "transparent") +
  labs(x = "Age", y = "Estimated logit")
#p + geom_point(y=modp$obs, position=position_jitter(y=modp$obs, height=0.02, width=0))              
p + geom_point(aes(y=obs), position=position_jitter(height=0.25, width=0))


##########  effect plots

library(effects)
arth.eff2 <- allEffects(arth.logistic2)

# show fitted probabilities for Age
arth.eff2$Age

#plot(arth.eff2)
plot(arth.eff2, rows=1, cols=3)

# full model plot
#arth.full <- Effect(c("Age", "Sex", "Treatment"), arth.logistic2)
#plot(arth.full, grid=TRUE)
#plot(arth.full, multiline=TRUE, ci.style="bands", key.args=list(x=.05, y=.95), grid=TRUE)


arth.full <- Effect(c("Age", "Treatment", "Sex"), arth.logistic2)
#plot(arth.full, grid=TRUE)
# plot on logit scale
plot(arth.full, multiline=TRUE, ci.style="bands", 
  colors = c("red", "blue"), lwd=3,
  ticks=list(at=c(.05, .1,.25,.5,.75,.9, .95)),
	key.args=list(x=.52, y=.92), grid=TRUE)

#plot on prob scale
plot(arth.full, multiline=TRUE, ci.style="bands", 
  colors = c("red", "blue"), lwd=3, rescale.axis=FALSE,
	key.args=list(x=.52, y=.92), grid=TRUE)

arth.eff3 <- allEffects(arth.logistic3)
plot(arth.eff3)





