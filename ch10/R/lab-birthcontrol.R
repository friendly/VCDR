#' ---
#' title: "Birth control data, Exercises 10.2, 10.3"
#' author: "Michael Friendly"
#' date: "02 Feb 2016"
#' ---

# 10.2 (a) 
birthcontrol <- matrix(c(
 81, 68, 60, 38, 
 24, 26, 29, 14, 
 18, 41, 74, 42, 
 36, 57, 161, 157), 4, 4, byrow=TRUE)

dimnames(birthcontrol) <-
	list("presex" = c("WRONG", "Wrong", "wrong", "OK"),
	     "birthcontrol" = c("DISAGREE", "disagree", "agree", "AGREE"))
birthcontrol

# independence model, using loglm()
loglm(~presex + birthcontrol, data=birthcontrol)

# independence model, using glm()
birthcontrol.df <- as.data.frame(as.table(birthcontrol))
birth.indep <- glm(Freq ~ presex + birthcontrol,
                   data = birthcontrol.df, family = poisson)
summary(birth.indep)
anova(birth.indep)

# (b)
mosaic(birthcontrol, shade=TRUE)

# (c)
library(gnm)
linlin <- gnm(Freq ~ presex + birthcontrol + 
                     as.numeric(presex) * as.numeric(birthcontrol), 
              data=birthcontrol.df, family=poisson)
anova(birth.indep, linlin, test="Chisq")
LRstats(birth.indep, linlin)

# (d)
RC <- gnm(Freq ~ presex + birthcontrol + Mult(presex, birthcontrol), 
          data=birthcontrol.df, family=poisson, verbose=FALSE)
anova(linlin, RC, test="Chisq")

LRstats(birth.indep, linlin, RC)

# (e) plots and interpretation

# odds ratio interpretation
exp(coef(linlin)[10])

mosaic(linlin, gp_args=list(interpolate=1:4))

library(logmult)
rc1 <- rc(birthcontrol, verbose=FALSE, weighting="marginal", se="jackknife")

plot(rc1, pch=15)
title(xlab="RC category score")

# cex and xlab have no effect
plot(rc1, pch=15, cex=3, xlab = "RC category score")

