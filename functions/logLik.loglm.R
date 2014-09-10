# logLik method for loglm objects, to allow use of AIC() and BIC()
# with MASS::loglm, giving comparable results to the use of these
# functions with glm(..., family=poisson) models.


logLik.loglm <- function(object, ...) {
  fr <- if(!is.null(object$frequencies)) unclass(object$frequencies) else {
    unclass(update(object, keep.frequencies = TRUE)$frequencies)
  }
  df <- prod(dim(fr)) - object$df
  structure(sum(dpois(fr, fr, log = TRUE))  - object$deviance/2,
    df = df, class = "logLik")
}

# allow for non-integer frequencies?

logLik.loglm <- function(object, ...) {
  fr <- if(!is.null(object$frequencies)) unclass(object$frequencies) else {
    unclass(update(object, keep.frequencies = TRUE)$frequencies)
  }
  df <- prod(dim(fr)) - object$df
  structure(sum((log(fr) - 1) * fr - lgamma(fr + 1))  - object$deviance/2,
    df = df, class = "logLik")
}




TESTME <- TRUE
if(TESTME) {
data(Titanic, package="datasets")  

library(MASS)
titanic.mod1 <- loglm(~ (Class * Age * Sex) + Survived, data=Titanic)
titanic.mod2 <- loglm(~ (Class * Age * Sex) + Survived*(Class + Age + Sex), data=Titanic)
titanic.mod3 <- loglm(~ (Class * Age * Sex) + Survived*(Class + Age * Sex), data=Titanic)

logLik(titanic.mod1)

AIC(titanic.mod1, titanic.mod2, titanic.mod3)
BIC(titanic.mod1, titanic.mod2, titanic.mod3)

Titanic <- Titanic + 0.5   # adjust for 0 cells
titanic.mod1 <- loglm(~ (Class * Age * Sex) + Survived, data=Titanic)
titanic.mod2 <- loglm(~ (Class * Age * Sex) + Survived*(Class + Age + Sex), data=Titanic)
titanic.mod3 <- loglm(~ (Class * Age * Sex) + Survived*(Class + Age * Sex), data=Titanic)

logLik(titanic.mod1)
AIC(titanic.mod1, titanic.mod2, titanic.mod3)

titanic <- as.data.frame(Titanic)
titanic.glm1 <- glm(Freq ~ (Class * Age * Sex) + Survived, data=titanic, family=poisson)
titanic.glm2 <- glm(Freq ~ (Class * Age * Sex) + Survived*(Class + Age + Sex), data=titanic, family=poisson)
titanic.glm3 <- glm(Freq ~ (Class * Age * Sex) + Survived*(Class + Age * Sex), data=titanic, family=poisson)

logLik(titanic.glm1)

AIC(titanic.glm1, titanic.glm2, titanic.glm3)
BIC(titanic.glm1, titanic.glm2, titanic.glm3)

titanic$Freq <- titanic$Freq + 0.5
titanic.glm1 <- glm(Freq ~ (Class * Age * Sex) + Survived, data=titanic, family=poisson)
logLik(titanic.glm1)


}
