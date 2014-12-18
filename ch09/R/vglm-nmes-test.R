
data("NMES1988", package="AER")
nmes2 <- NMES1988[, c(1:4, 6:8, 13, 15, 18)]
str(nmes2)

# vector generalized additive model
library(VGAM)

nmes2.nbin   <- vglm(cbind(visits, nvisits, ovisits, novisits) ~ ., data = nmes2, 
	family = negbinomial)
#summary(nmes2.nbin)

# Constrained models

clist <- constraints(nmes2.nbin, type = "term")
clist$hospital[c(1,3,5,7),]

clist2 <- clist
clist2$hospital  <- cbind(rowSums(clist$hospital))
clist2$chronic  <- cbind(rowSums(clist$chronic))
# show constraints

clist2$hospital[c(1,3,5,7), 1, drop=FALSE]

nmes2.nbin2   <-
  vglm(cbind(visits, nvisits, ovisits, novisits) ~ .,
#      hospital + health + chronic + gender + school + insurance, 
       data = nmes2, 
       constraints = clist2,
       family = negbinomial(zero = NULL))

lrtest(nmes2.nbin, nmes2.nbin2)
# Test equality

library(car)
# one term
lh <- paste("hospital:", 1:3, " = ", "hospital:", 2:4, sep="")
lh
car::linearHypothesis(nmes2.nbin, lh)
