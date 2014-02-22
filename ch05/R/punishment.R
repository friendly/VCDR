library(vcdExtra)
library(MASS)
data("Punishment", package = "vcd")
str(Punishment)

pun <- xtabs(Freq ~ memory + attitude + age + education, data = Punishment)
dimnames(pun) <- list(
  Memory = c("yes", "no"), 
  Attitude = c("no", "moderate"),
  Age = c("15-24", "25-39", "40+"), 
  Education = c("Elementary", "Secondary", "High"))

myseed <- 1071

#set.seed(myseed)
#pun_cotab <- cotab_coindep(pun, condvars = 3:4, type = "assoc", n = nrep,
#  varnames = FALSE, margins = c(2, 1, 1, 2), test = "maxchisq", interpolate = 1:2)
set.seed(myseed)
pun_cotab <- cotab_coindep(pun, condvars = 3:4, type = "mosaic", 
  varnames = FALSE, margins = c(2, 1, 1, 2), test = "maxchisq", interpolate = 1:2)

cotabplot(~ Memory + Attitude | Age + Education, data = pun, panel = pun_cotab)

pun_cotab2 <- cotab_coindep(pun, condvars = 3:4, type = "mosaic", 
  varnames = FALSE, margins = c(2, 1, 1, 2), test = "sumchisq", interpolate = 1:2)
cotabplot(~ Memory + Attitude | Age + Education, data = pun, panel = pun_cotab2)

mosaic(~ Memory + Attitude | Age + Education, data = pun, shade=TRUE, gp_args=list(interpolate=1:4))

# show nobs for each combination of Age & Educ
apply(pun, c("Age", "Education"), function(x) sum(x))

# models: show that GSQ is decomposed 

library(MASS)
#mod.cond <- loglm(~ Memory + Attitude | Age + Education, data = pun)  # not valid syntax
mod.cond <- loglm(~ Memory*Age*Education + Attitude*Age*Education, data = pun)  # [ACD][BCD] = A \perp B | C,D

mod.cond

mods.list <- apply(pun, c("Age", "Education"), function(x) loglm(~Memory + Attitude, data=x))
GSQ <- matrix( sapply(mods.list, function(x)x$lrt), 3, 3)
dimnames(GSQ) <- dimnames(mods.list)
GSQ
addmargins(GSQ)
sum(GSQ)

XSQ <- matrix( sapply(mods.list, function(x)x$pearson), 3, 3)
dimnames(XSQ) <- dimnames(mods.list)
addmargins(XSQ)
sum(XSQ)

# compare with permutation test, Pearson chisq
coindep_test(pun, margin=c("Age", "Education"), indepfun = function(x) sum(x^2), aggfun=sum)





#mod.1 <- loglm(~ Memory + Attitude, subset=Age=="15-24" & Education=="Elementary", data=pun)
#mod.2 <- loglm(~ Memory + Attitude, subset=Age=="25-39" & Education=="Elementary", data=pun)
#mod.3 <- loglm(~ Memory + Attitude, subset=Age=="40+"   & Education=="Elementary", data=pun)
#mod.4 <- loglm(~ Memory + Attitude, subset=Age=="15-24" & Education=="Secondary", data=pun)
#mod.5 <- loglm(~ Memory + Attitude, subset=Age=="25-39" & Education=="Secondary", data=pun)
#mod.6 <- loglm(~ Memory + Attitude, subset=Age=="40+"   & Education=="Secondary", data=pun)
#mod.7 <- loglm(~ Memory + Attitude, subset=Age=="15-24" & Education=="High", data=pun)
#mod.8 <- loglm(~ Memory + Attitude, subset=Age=="25-39" & Education=="High", data=pun)
#mod.9 <- loglm(~ Memory + Attitude, subset=Age=="40+"   & Education=="High", data=pun)

mod.1 <- loglm(Freq ~ memory + attitude, subset=age=="15-24" & education=="elementary", data=Punishment)
mod.2 <- loglm(Freq ~ memory + attitude, subset=age=="25-39" & education=="elementary", data=Punishment)
mod.3 <- loglm(Freq ~ memory + attitude, subset=age=="40-"   & education=="elementary", data=Punishment)
mod.4 <- loglm(Freq ~ memory + attitude, subset=age=="15-24" & education=="secondary", data=Punishment)
mod.5 <- loglm(Freq ~ memory + attitude, subset=age=="25-39" & education=="secondary", data=Punishment)
mod.6 <- loglm(Freq ~ memory + attitude, subset=age=="40-"   & education=="secondary", data=Punishment)
mod.7 <- loglm(Freq ~ memory + attitude, subset=age=="15-24" & education=="high", data=Punishment)
mod.8 <- loglm(Freq ~ memory + attitude, subset=age=="25-39" & education=="high", data=Punishment)
mod.9 <- loglm(Freq ~ memory + attitude, subset=age=="40-"   & education=="high", data=Punishment)

mod.list <- loglmlist(mod.1, mod.2,mod.3, mod.4, mod.5, mod.6, mod.7, mod.8, mod.9)
summarise(mod.list)



GSQ <- matrix( sapply(mod.list, function(x)x$lrt), 3, 3)
dimnames(GSQ) <- list(age = levels(Punishment$age),
                      education = levels(Punishment$education)
                      )
GSQ

sum(sapply(mod.list, function(x)x$lrt))

# using by()

mods <- with(Punishment,
             by(Punishment, list(age, education),
                function(x) loglm(Freq ~ memory + attitude, data=x)
             ))
                



