# modeling a multivariate count response

data("NMES1988", package="AER")
nmes2 <- NMES1988[, c(1:4, 6:8, 13, 15, 18)]
str(nmes2)

# exploratory plots

totals <- colSums(nmes2[,1:4])
tmat <- matrix(totals, 2, 2, 
	dimnames=list(practitioner=c("physician", "non-physician"), place=c("office", "hospital")))

library(vcd)
fourfold(tmat)

cfac <- function(x, breaks = NULL) {
  if(is.null(breaks)) breaks <- unique(quantile(x, 0:10/10))
  x <- cut(x, breaks, include.lowest = TRUE, right = FALSE)
  levels(x) <- paste(breaks[-length(breaks)], ifelse(diff(breaks) > 1,
    c(paste("-", breaks[-c(1, length(breaks))] - 1, sep = ""), "+"), ""), sep = "")
  return(x)
}
vars <- colnames(nmes2)[1:4]
nmes.long <- reshape(nmes2, 
  varying = vars, 
  v.names = "visit",
  timevar = "type", 
  times = vars, 
  direction = "long",
  new.row.names = 1:(4*4406))
head(nmes.long)

nmes.long <- nmes.long[order(nmes.long$id),]
nmes.long <- transform(nmes.long,
	practitioner = ifelse(type %in% c("visits", "ovisits"), "physician", "nonphysician"),
	place = ifelse(type %in% c("visits", "nvisits"), "office", "hospital"),
	chronicf = cfac(chronic)
	)
head(nmes.long)

xtabs(visit~practitioner + place, data=nmes.long)

xtabs(visit~practitioner + place+chronicf, data=nmes.long)
fourfold(xtabs(visit~practitioner + place + chronicf, data=nmes.long), mfrow=c(1,4))
fourfold(xtabs(visit~practitioner + place + health, data=nmes.long), mfrow=c(1,3))


# vector generalized additive model
library(VGAM)


nmes2_nbin   <- vglm(cbind(visits, nvisits, ovisits, novisits) ~ ., data = nmes2, 
	family = negbinomial)
summary(nmes2_nbin)

coef(nmes2_nbin, matrix=TRUE)[,c(1,3,5,7)]


# Constrained models

clist <- clist2 <- constraints(nmes2_nbin, type = "term")

clist2$hospital   <- cbind(rowSums(clist$hospital))
clist2$health     <- cbind(rowSums(clist$health))


nmes2_nbin2   <-
  vglm(cbind(visits, nvisits, ovisits, novisits) ~ .,
#      hospital + health + chronic + gender + school + insurance, 
       data = nmes2, 
       trace = TRUE,
       constraints = clist2,
       family = negbinomial(zero = NULL))


coef(nmes2_nbin2, matrix=TRUE)[,c(1,3,5,7)]


lrtest(nmes2_nbin, nmes2_nbin2)

# Is it possible to contrain the coefficients for diff responses to be equal or test this?
# Is there a hurdle version of this model, e.g., allowing for excess zeros?

# Test equality

# one term
lh <- paste("hospital:", 1:3, " = ", "hospital:", 2:4, sep="")
car::linearHypothesis(nmes2_nbin, lh)

# all terms
terms <- dimnames(nmes2_nbin@x)[[2]][-1]
#terms <- attr(terms(nmes2_nbin), "term.labels")
for (term in terms) {
	lh <- paste(term, ":", 1:3, " = ", term, ":", 2:4, sep="")
	print(car::linearHypothesis(nmes2_nbin, lh)	)
}




# transform to 2x2 response design, for two different sets of "main effects"
# each pair of which can be analysed as a bivariate response

nmes2x2 <- transform(nmes2,
	office   = visits + nvisits,
	hospital = ovisits + novisits,
	physcian = visits + nvisits,
	nphysician = nvisits + novisits)

nmes2x2_nbin   <- vglm(office, hospital) ~ hospital + health + chronic + gender + school + insurance, 
	data = nmes2x2, family = negbinomial)

nmes2x2_nbin   <- vglm(physician, nphysician) ~ hospital + health + chronic + gender + school + insurance, 
	data = nmes2x2, family = negbinomial)


# or, consider presence/absence as binomial.or
# need to do this as practitioner/place ???
nmes.binary <- transform(nmes2,
	visits = as.numeric(visits > 0),
	nvisits = as.numeric(nvisits > 0),
	ovisits = as.numeric(ovisits > 0),
	novisits = as.numeric(novisits > 0))

nmes_vglmbin <- vglm(cbind(visits, nvisits, ovisits, novisits) ~ health + chronic + gender + school + insurance,
	binom2.or(zero=3), data=nmes.binary)
#Error in temp2[near0.5] <- log(theta[near0.5]/(1 - theta[near0.5])) : 
#  NAs are not allowed in subscripted assignments
#>	
	

