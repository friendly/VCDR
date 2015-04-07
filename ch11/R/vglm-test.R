# test multivariate NB models using VGAM::vglm and MASS::glm.nb

data("NMES1988", package="AER")
nmes2 <- NMES1988[, c(1:4, 6:8, 13, 15, 18)]
str(nmes2)

nmes2_nbin   <- vglm(cbind(visits, nvisits, ovisits, novisits) ~ ., data = nmes2, 
	family = negbinomial)
summary(nmes2_nbin)

# coefficients for the predictors
coef(nmes2_nbin, matrix=TRUE)[,c(1,3,5,7)]

# compare with separate estimation: get the same coefficients & standard errors

nmes2_nbin1   <- vglm(visits ~ hospital+health+chronic+gender+school+insurance, data = nmes2, family = negbinomial)
nmes2_nbin2   <- vglm(nvisits ~ hospital+health+chronic+gender+school+insurance, data = nmes2, family = negbinomial)
nmes2_nbin3   <- vglm(ovisits ~ hospital+health+chronic+gender+school+insurance, data = nmes2, family = negbinomial)
nmes2_nbin4   <- vglm(novisits ~ hospital+health+chronic+gender+school+insurance, data = nmes2, family = negbinomial)

cbind(coef(nmes2_nbin1)[-2], coef(nmes2_nbin2)[-2],coef(nmes2_nbin3)[-2],coef(nmes2_nbin4)[-2])

# how to interpret the size parameters here.  Why are some negative?
coef(nmes2_nbin, matrix=TRUE)[1,c(2,4,6,8)]

# compare with using MASS::glm.nb

library(MASS)

nmes2.nbin1   <- glm.nb(visits  ~ hospital + health + chronic + gender + school + insurance, data = nmes2)
nmes2.nbin2   <- glm.nb(nvisits  ~ hospital + health + chronic + gender + school + insurance, data = nmes2)
nmes2.nbin3   <- glm.nb(ovisits  ~ hospital + health + chronic + gender + school + insurance, data = nmes2)
nmes2.nbin4   <- glm.nb(novisits  ~ hospital + health + chronic + gender + school + insurance, data = nmes2)

# collect coefficients
cbind(coef(nmes2.nbin1), coef(nmes2.nbin2), coef(nmes2.nbin3), coef(nmes2.nbin4))

c(nmes2.nbin1$theta, nmes2.nbin2$theta, nmes2.nbin3$theta, nmes2.nbin4$theta)
# same as exp(log(size)) values from vglm()
 exp(coef(nmes2_nbin, matrix=TRUE)[1,c(2,4,6,8)])