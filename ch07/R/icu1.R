library(vcdExtra)
data("ICU", package="vcdExtra")

# remove redundant variables (race, coma)
ICU <- ICU[,-c(4, 20)]
# fit full model

icu.full <- glm(died ~ ., data=ICU, family=binomial)
summary(icu.full)

# test global H0: \beta=0
LRtest <- function(model)
  c(LRchisq=(model$null.deviance - model$deviance),
	  df=(model$df.null - model$df.residual))

(LR <- LRtest(icu.full))
(pvalue=1-pchisq(LR[1],LR[2]))

# remove senseless predictors
icu.full1 <- update(icu.full, . ~ . - renal - fracture)
icu.full1
anova(icu.full1, icu.full, test="Chisq")

# backward selection using AIC
library(MASS)

icu.step1 <- stepAIC(icu.full1, trace = FALSE)
icu.step1$anova

# using BIC
icu.step2 <- stepAIC(icu.full, trace = FALSE, k=log(200))
icu.step2$anova

anova(icu.step1, icu.step2, test="Chisq")

# test non-linearity and interactions with age in icu.step2

icu.glm3 <- update(icu.step2, . ~ . -age + ns(age,3) + (cancer+admit+uncons)^2)
#anova(icu.mod3)
anova(icu.step2, icu.glm3, test="Chisq")

icu.glm4 <- update(icu.step2, . ~ . + age*(cancer+admit+uncons))
anova(icu.step2, icu.glm4, test="Chisq")

#
## simpler model (found from stepAIC)
#icu.mod1 <- glm(died ~ age + cancer + systolic + admit + ph + pco + uncons, data=ICU, family=binomial)
#summary(icu.mod1)
#
## even simpler model, from stepAIC using BIC
#icu.mod2 <- glm(died ~ age + cancer  + admit + uncons, data=ICU, family=binomial)
#summary(icu.mod2)
#
#anova(icu.mod2, icu.mod1, icu.full, test="Chisq")
#
## test interactions with age
#icu.mod3 <- update(icu.mod2, . ~ . + age*(cancer+admit+uncons))
#anova(icu.mod3)



###############################################
#
## try bestglm package -- takes forever
#
#library(bestglm)
#
#Xy <- ICU[,c(2:20, 1)]
#out <- bestglm(Xy, family=binomial)
#names(out)

################################################

library(rms)
dd <- datadist(ICU[,-1])
options(datadist="dd")
icu.lrm1 <- lrm(died ~ ., data=ICU)
icu.lrm1 <- update(icu.lrm1, . ~ . - renal - fracture)

# good initial model overview plot
sum.lrm1 <- summary(icu.lrm1)
#op <- par(mar=c(3,4,4,2) + 1)
plot(sum.lrm1, log=TRUE, main="Odds ratio for 'died'", cex=1.25,
 col = rgb(0.1, 0.1, 0.8, alpha = c(0.3, 0.5, 0.8)))


#par(op)


summary(icu.lrm1)
anova(icu.lrm1)
#plot(icu.lrm1)
plot(nomogram(icu.lrm1), cex.var=1.2)


# remove some unimportant variables

icu.lrm2 <- update(icu.lrm1,  ~ . -service -infect -cpr -hrtrate  -po2 -bic -creatin)
icu.lrm2

plot(nomogram(icu.lrm2), cex.var=1.2)

sum.lrm2 <- summary(icu.lrm2)
plot(sum.lrm2, log=TRUE)


#res <- fastbw(icu.lrm1)

# fastbw on the reduced model
res <- fastbw(icu.lrm2)

# check for non-linearity in age
icu.lrm3 <- lrm(died ~ rcs(age,3) + cancer  + admit + uncons, data=ICU)
anova(icu.lrm3)

sum.lrm3 <- summary(icu.lrm3)
plot(sum.lrm3, log=TRUE)


plot(nomogram(icu.lrm3), cex.var=1.2)
title(main="Nomogram for ICU deaths")

icu.lrm4 <- update(icu.lrm3, . ~ . + (cancer+admit)^2)
anova(icu.lrm4)

#######################################
# go back to simple additive model for a nomogram

icu.lrm2 <- lrm(died ~ age + cancer  + admit + uncons, data=ICU)

cd("C:/Documents and Settings/friendly/My Documents/My Dropbox/Documents/VCDR/ch07/fig")

plot(nomogram(icu.lrm2), cex.var=1.2, lplabel="Log odds death")

# mark an example; this highly depends on the size of the plot window

#coords <- locator(4)
#> coords
#$x
#[1] 0.5810185 0.2030526 0.8342014 0.9589844
#
#$y
#[1] 0.8113116 0.6555547 0.5018205 0.3460636

#> dput(coords)
coords <-
structure(list(x = c(0.58101851594698, 0.203052647357215, 0.834201394428162, 
0.958984384536745), y = c(0.811311608472659, 0.655554661914918, 
0.50182053284494, 0.346063586287199)), .Names = c("x", "y"))

points(coords, pch=15, col="red", cex=1.8)

# total points:
#tpoints <- locator(1)
tpoints <- list(x=0.796224, y=0.1923295)
points(tpoints, pch=16, col="red", cex=1.6)

logodds <- list(x=tpoints$x, y=0.05)
arrows(tpoints$x, tpoints$y, y1=0.05, length=0.15, angle=15, col="red", lwd=2)

dev.copy2pdf(file="icu-nomogram.pdf")


pred <- data.frame(age=60, cancer="No", admit="Emergency", uncons="Yes")

predict(icu.step2, newdata=pred)

#> predict(icu.step2, newdata=pred)
#       1 
#2.168451 
#> 
#> predict(icu.step2, newdata=pred, type="response")
#        1 
#0.8973804 
#> 



