
# define a wrapper for MASS::lm.gls which lets it inherit from "lm"
# discussion on this at http://stackoverflow.com/questions/30734982/writing-a-wrapper-for-a-linear-modeling-function-masslm-gls

#lm_gls <- function(formula, data, W, subset, na.action, inverse = FALSE, 
#    method = "qr", model = FALSE, x = FALSE, y = FALSE, contrasts = NULL, 
#    ...) 
#{
#	result <- MASS::lm.gls(formula, data, W, subset, na.action, 
#		inverse = inverse,  method = method, model = model, x = x, y = y, contrasts = contrasts, 
#    ...) 
#  class(result) <- c(class(result), "lm")
#  result
#}

lm_gls <- function(...) 
{
  result <- MASS::lm.gls(...) 
  class(result) <- c(class(result), "lm")
  result
}	

#TESTME<- TRUE
#if(TESTME) {
library(vcd) # needs vcd_1.3-3+ 
data(Punishment, package="vcd")

pun.lor <- loddsratio(Freq ~ memory + attitude + age + education, data = Punishment)
pun.lor.df <- as.data.frame(pun.lor)

library(MASS)

pun.gls <- lm_gls(LOR ~ as.numeric(age) * as.numeric(education), data=pun.lor.df, W=vcov(pun.lor), inverse=TRUE, x=TRUE, y=TRUE)
names(pun.gls)

pun.gls

summary(pun.gls)

library(car)

vcov.lm.gls <- function(object, ...){
     class(object) <- "lm"
     vcov(object, ...)
 }

model.matrix.lm.gls <- function(object, ...){
     class(object) <- "lm"
     model.matrix(object, ...)
 }

Anova(pun.gls)

#}
