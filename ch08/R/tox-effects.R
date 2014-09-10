data("Toxaemia", package="vcdExtra")
#tox.tab <- xtabs(Freq~class + smoke + hyper + urea, Toxaemia)


# loglinear model
tox.mod1 <- glm(Freq ~ class*smoke + hyper*urea + class:hyper + hyper:urea, data=Toxaemia, family=poisson)

# logit models for hyper & urea

tox.hyper <- glm(hyper=='High' ~ class*smoke, weights=Freq, data=Toxaemia, family=binomial)
tox.urea <- glm(urea=='High' ~ class*smoke, weights=Freq, data=Toxaemia, family=binomial)

library(effects)

plot(allEffects(tox.hyper, confidence.level=0.68),
  ylab = "Probability (hypertension)",
  xlab = "Social class of mother",
  main = "Hypertension: class*smoke effect plot",
  colors = c("blue", "black", "red"), 
  lwd=3, 
  multiline=TRUE,
  key.args=list(x=0.05, y=0.2, cex=1.2)
  )

plot(allEffects(tox.urea, confidence.level=0.68),
  ylab = "Probability (Urea)",
  xlab = "Social class of mother",
  main = "Urea: class*smoke effect plot",
  colors = c("blue", "black", "red"), 
  lwd=3, 
  multiline=TRUE,
  key.args=list(x=0.7, y=0.2, cex=1.2)
  )

# main effects only
tox.hyper1 <- glm(hyper=='High' ~ class+smoke, weights=Freq, data=Toxaemia, family=binomial)
tox.urea1 <- glm(urea=='High' ~ class+smoke, weights=Freq, data=Toxaemia, family=binomial)

plot(Effect(c("class", "smoke"), tox.hyper1),
  ylab = "Probability (hypertension)",
  xlab = "Social class of mother",
  main = "Hypertension: class*smoke effect plot",
  colors = c("blue", "black", "red"), 
  lwd=3, 
  multiline=TRUE,
  key.args=list(x=0.05, y=0.15, cex=1.2)
  )

plot(Effect(c("class", "smoke"), tox.urea1),
  ylab = "Probability (Urea)",
  xlab = "Social class of mother",
  main = "Urea: class*smoke effect plot",
  colors = c("blue", "black", "red"), 
  lwd=3, 
  multiline=TRUE,
  key.args=list(x=0.75, y=0.15, cex=1.2)
  )
