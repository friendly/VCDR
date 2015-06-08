#' ---
#' title: "Test gls and anova methods for log odds ratio objects"
#' author: "Michael Friendly"
#' date: "04 Jun 2015"
#' ---



#install.packages("vcd", repos="http://R-Forge.R-project.org")
library(vcd) # needs vcd_1.3-3+ 
data(Punishment, package="vcd")

pun.lor <- loddsratio(Freq ~ memory + attitude + age + education, data = Punishment)
names(pun.lor)
plot(pun.lor)

pun.lor.df <- as.data.frame(pun.lor)
pun.lor.df

# use weighted ANOVA--- this doesn't take covariances into account
# NB:  in this example the ANOVA for LOR ~ age * education is the saturated model (n=1),
#    so we treat age and education as numeric.
#    Other alternatives would be polynomial or other models as long as there are residual df.

pun.mod <- lm(LOR ~ as.numeric(age) * as.numeric(education), data=pun.lor.df, weights=1/ASE^2)
anova(pun.mod)
library(car)
Anova(pun.mod)


# use MASS::lm.gls
library(MASS)

pun.gls <- lm.gls(LOR ~ as.numeric(age) * as.numeric(education), data=pun.lor.df, W=vcov(pun.lor), inverse=TRUE, x=TRUE, y=TRUE)
names(pun.gls)

# there are no print or summary methods for lm.gls objects, so define them
print.lm.gls <- function(object, ...) {
     class(object) <- "lm"
     print(object, ...)
}

summary.lm.gls <- function(object, ...) {
     class(object) <- "lm"
     summary(object, ...)
}

pun.gls
summary(pun.gls)


# But there is also no [aA]nova method for lm.gls objects
#anova(pun.gls)

library(car)
#vcov.lm.gls <- stats:::vcov.lm
#model.matrix.lm.gls <- model.matrix.lm

vcov.lm.gls <- function(object, ...){
     class(object) <- "lm"
     vcov(object, ...)
 }

model.matrix.lm.gls <- function(object, ...){
     class(object) <- "lm"
     model.matrix(object, ...)
 }

# this works; are the results correct?
Anova(pun.gls)




