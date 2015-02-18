#install.packages("vcd", repos="http://R-Forge.R-project.org")
library(vcd) # needs vcd_1.3-3 
data(Punishment, package="vcd")

pun.lor <- loddsratio(Freq ~ memory + attitude + age + education, data = Punishment)
names(pun.lor)
plot(pun.lor)

pun.lor.df <- as.data.frame(pun.lor)
pun.lor.df

# use weighted ANOVA
pun.mod <- lm(LOR ~ as.numeric(age) * as.numeric(education), data=pun.lor.df, weights=1/ASE^2)
anova(pun.mod)
library(car)
Anova(pun.mod)


library(MASS)

pun.gls <- lm.gls(LOR ~ as.numeric(age) * as.numeric(education), data=pun.lor.df, W=vcov(pun.lor), inverse=TRUE, x=TRUE, y=TRUE)
names(pun.gls)

print.lm.gls <- function(object, ...) {
     class(object) <- "lm"
     print(object, ...)
}

summary.lm.gls <- function(object, ...) {
     class(object) <- "lm"
     summary(object, ...)
}

# no anova method for lm.gls objects
#anova(pun.gls)

library(car)
# this works; are the results correct?
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

Anova(pun.gls)




