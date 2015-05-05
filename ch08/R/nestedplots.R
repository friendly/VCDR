## Alternative Figures for full model plots in Ch. 8
## preliminary code
## see: http://stackoverflow.com/questions/30061563/directlabels-avoid-clipping-like-xpd-true/30062593#30062593 for discussion

library(car)
library(reshape2)
library(ggplot2)
library(directlabels)
library(nnet)

## Sec. 8.2 (Nested Dichotomies)

# transform data

Womenlf <- within(Womenlf,{
  working <-  recode(partic, " 'not.work' = 'no'; else = 'yes' ")
  fulltime <- recode(partic,
    " 'fulltime' = 'yes'; 'parttime' = 'no'; 'not.work' = NA")})

mod.working <- glm(working ~ hincome + children, family = binomial,
                   data = Womenlf)
mod.fulltime <- glm(fulltime ~ hincome + children, family = binomial,
                    data = Womenlf)

predictors <- expand.grid(hincome = 1:50,
                          children = c("absent", "present"))
fit <- data.frame(predictors,
    p.working = predict(mod.working, predictors, type = "response"),
    p.fulltime = predict(mod.fulltime, predictors, type = "response"),
    l.working = predict(mod.working, predictors, type = "link"),
    l.fulltime = predict(mod.fulltime, predictors, type = "link")
)

fit <- within(fit, {
  `full-time` <- p.working * p.fulltime
  `part-time` <- p.working * (1 - p.fulltime)
  `not working` <- 1 - p.working
  })

# Figure 8.10
fit2 = melt(fit,
            measure.vars = c("full-time","part-time","not working"),
            variable.name = "Participation",
            value.name = "Probability")

gg <- ggplot(fit2,
             aes(x = hincome, y = Probability, colour = Participation)) + 
        facet_grid(~ children, labeller = function(x, y) sprintf("%s = %s", x, y)) + 
        geom_line(size = 2) + theme_bw() +
        scale_x_continuous(limits=c(-3,55))

direct.label(gg, list("top.bumptwice", dl.trans(y = y + 0.2)))

# Figure 8.11
fit3 = melt(fit,
            measure.vars = c("l.working","l.fulltime"),
            variable.name = "Participation",
            value.name = "LogOdds")
levels(fit3$Participation) <- c("working", "full-time")
gg <- ggplot(fit3,
             aes(x = hincome, y = LogOdds, colour = Participation)) + 
        facet_grid(~ children, labeller = function(x, y) sprintf("%s = %s", x, y)) + 
        geom_line(size = 2) + theme_bw() +
        scale_x_continuous(limits=c(-3,55))
        
direct.label(gg, list("top.bumptwice", dl.trans(y = y + 0.2)))


## Sec. 8.3 (Gen. Logit models)

# fit models
Womenlf$partic <- relevel(Womenlf$partic, ref = "not.work")
wlf.multinom <- multinom(partic ~ hincome + children,
                         data = Womenlf, Hess = TRUE)
predictors <- expand.grid(hincome = 1:50,
                          children = c("absent", "present"))
fit <- data.frame(predictors,
                  predict(wlf.multinom, predictors, type = "probs")
                  )

# Figure 8.12
fit2 = melt(fit,
            measure.vars = c("not.work","fulltime","parttime"),
            variable.name = "Participation",
            value.name = "Probability")
levels(fit2$Participation) <- c("not working", "full-time", "part-time")
gg <- ggplot(fit2,
             aes(x = hincome, y = Probability, colour = Participation)) + 
        facet_grid(~ children, labeller = function(x, y) sprintf("%s = %s", x, y)) + 
        geom_line(size = 2) + theme_bw() +
        scale_x_continuous(limits=c(-3,50))
        

direct.label(gg, list("top.bumptwice", dl.trans(y = y + 0.2)))
