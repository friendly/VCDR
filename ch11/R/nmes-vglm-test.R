data("NMES1988", package="AER")
nmes2 <- NMES1988[, c(1:4, 6:8, 13, 15, 18)]
str(nmes2)

# vector generalized additive model
library(VGAM)
nmes2.nbin   <- vglm(cbind(visits, nvisits, ovisits, novisits) ~ ., data = nmes2, 
family = negbinomial)
summary(nmes2.nbin)
# one term
lh <- paste("hospital:", 1:3, " = ", "hospital:", 2:4, sep="")
lh

# John Fox's kludge:
library(car)

if (packageVersion("car") < "2.1.1") {
	df.residual.vglm <- function(object, ...) object@df.residual
	vcov.vglm <- function(object, ...) vcovvlm(object, ...)
	coef.vglm <- function(object, ...) coefvlm(object, ...)
}
linearHypothesis(nmes2.nbin, lh)

## John's extension to make Anova() work

Anova(nmes2.nbin)

linearHypothesis(nmes2.nbin, matchCoefs(nmes2.nbin, "hospital")) # check

# model with interaction

mod2 <- vglm(cbind(visits, nvisits, ovisits, novisits) ~ hospital*health, 
data=nmes2, family=negbinomial)

Anova(mod2)

linearHypothesis(mod2, matchCoefs(mod2, "hospital:health")) # check




