#' ---
#' title: "Birth control data, Exercises 10.2, 10.3"
#' author: "Michael Friendly"
#' date: "02 Feb 2016"
#' ---

library(MASS)
library(vcdExtra)

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

#################  Exercise 10.3 ##################

# (a)
loddsratio(birthcontrol, log=FALSE)

(LOR <- loddsratio(birthcontrol))

exp(mean(as.matrix(LOR)))

tile(LOR)

# or, as in Fig 10.2

library(corrplot)
corrplot(as.matrix(LOR), method="square", is.corr=FALSE,
	tl.col="black", tl.srt=0, tl.offset=1)
	
# (b) R, C and R + C

Rscore <- as.numeric(birthcontrol.df$presex)
Cscore <- as.numeric(birthcontrol.df$birthcontrol)

# row effects model (mental)
roweff <- glm(Freq ~ presex + birthcontrol + 
                     presex:Cscore,
                family = poisson, data = birthcontrol.df)

coleff <- glm(Freq ~ presex + birthcontrol +  
                     Rscore:birthcontrol,
                family = poisson, data = birthcontrol.df)

RplusC <- glm(Freq ~ presex + birthcontrol +  
                     Rscore:birthcontrol + presex:Cscore,
                family = poisson, data = birthcontrol.df)

LRstats(birth.indep, roweff, coleff, RplusC, linlin)
	
