library(MASS)
p <- c(.05, .10, .25, .50, .75, .90, .95)

dfp <- data.frame(p, odds=as.character(fractions(p/(1-p))), logit=log(p/(1-p)))
dfp

