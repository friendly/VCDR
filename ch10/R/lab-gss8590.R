#' ---
#' title: "gss8590 data, Exercise 10.4"
#' author: "Michael Friendly"
#' date: "03 Feb 2016"
#' ---


data("gss8590", package="logmult")
Women.tab <- margin.table(gss8590[,,c("White Women", "Black Women")], 1:2)
Women.tab[2,4] <- 49
colnames(Women.tab)[5] <- "Farm"

Women.tab

Women.df <- as.data.frame(as.table(Women.tab))

indep <- glm(Freq ~ Education + Occupation,
             data = Women.df, family = poisson)

library(logmult)
RC1 <- rc(Women.tab, verbose=FALSE, weighting="marginal", se="jackknife")
RC2 <- rc(Women.tab, verbose=FALSE, weighting="marginal", se="jackknife", nd=2)
LRstats(indep, RC1, RC2)

# (b)
plot(RC1, conf=0.68)
title(xlab="Category score")

plot(RC2, conf=0.68, cex=1.5)

# (c) ???

Rscore <- as.numeric(Women.df$Education)
Cscore <- as.numeric(Women.df$Occupation)

# this doesn't work
roweff2 <- gnm(Freq ~ Education + Occupation + Mult(Rscore, Occupation, 2), 
          data=Women.df, family=poisson, verbose=FALSE)
 
#anova(linlin, RC, test="Chisq")

