# modeling a multivariate count response

data("NMES1988", package="AER")
nmes2 <- NMES1988[, c(1:4, 6:8, 13, 15, 18)]
str(nmes2)

# exploratory plots describing the associations among the responses
# in relation to explanatory variables

totals <- colSums(nmes2[,1:4])
tmat <- matrix(totals, 2, 2, 
	dimnames=list(practitioner=c("physician", "non-physician"), place=c("office", "hospital")))

library(vcdExtra)
fourfold(tmat)

#cutfac <- function(x, breaks = NULL) {
#  if(is.null(breaks)) breaks <- unique(quantile(x, 0:10/10))
#  x <- cut(x, breaks, include.lowest = TRUE, right = FALSE)
#  levels(x) <- paste(breaks[-length(breaks)], ifelse(diff(breaks) > 1,
#    c(paste("-", breaks[-c(1, length(breaks))] - 1, sep = ""), "+"), ""), sep = "")
#  return(x)
#}

vars <- colnames(nmes2)[1:4]
nmes.long <- reshape(nmes2, 
  varying = vars, 
  v.names = "visit",
  timevar = "type", 
  times = vars, 
  direction = "long",
  new.row.names = 1:(4*nrow(nmes2)))
head(nmes.long)

nmes.long <- nmes.long[order(nmes.long$id),]
nmes.long <- transform(nmes.long,
	practitioner = ifelse(type %in% c("visits", "ovisits"), "physician", "nonphysician"),
	place = ifelse(type %in% c("visits", "nvisits"), "office", "hospital"),
	hospf = cutfac(hospital, c(0:2, 8)),
	chronicf = cutfac(chronic)
	)
head(nmes.long)

# totals
xtabs(visit~practitioner + place, data=nmes.long)

xtabs(visit~practitioner + place+chronicf, data=nmes.long)

fourfold(xtabs(visit ~ practitioner + place + chronicf, data=nmes.long), mfrow=c(1,4))

fourfold(xtabs(visit ~ practitioner + place + health, data=nmes.long), mfrow=c(1,3))
# 
dev.copy2pdf(file="nmes4-fourfold1a.pdf")

loddsratio(xtabs(visit ~ practitioner + place + health, data=nmes.long))

#fourfold(xtabs(visit~practitioner + place + gender + insurance, data=nmes.long))

#fourfold(xtabs(visit~practitioner + place + hospf, data=nmes.long))

tab <- xtabs(visit ~ practitioner + place + gender + insurance + chronicf, data=nmes.long)
# rows are levels of chronic; cols are combos of gener * insurance
fourfold(tab, mfcol=c(4,4))

library(vcdExtra)
lodds <- loddsratio(tab)
lodds.df <- as.data.frame(lodds)

library(ggplot2)

ggplot(lodds.df, aes(x=chronicf, y=LOR, ymin=LOR-ASE, ymax=LOR+ASE, 
                     group=insurance, color=insurance)) + 
  geom_line(size=1.2) + geom_point(size=3) +
  geom_linerange(size=1.2) + 
  geom_errorbar(width=0.2) + 
  geom_hline(yintercept=0, linetype="longdash") +
  geom_hline(yintercept=mean(lodds.df$LOR), linetype="dotdash") +
  facet_grid(. ~ gender, labeller=label_both) +
  labs(x="Number of chronic conditions", 
       y="log odds ratio (physician|place)") +
  theme_bw() + theme(legend.position = c(0.1, 0.9))

# use plot(loddsratio()) ?
tab <- xtabs(visit ~ practitioner + place + chronicf + gender + insurance, data=nmes.long)
lodds <- loddsratio(tab)
plot(lodds, conf_level=0.68,
	xlab="Number of chronic conditions")

# do it with subsetting
tab <- xtabs(visit ~ practitioner + place + chronicf + gender + insurance, data=nmes.long)
lodds <- loddsratio(tab[,,,1,])
plot(lodds, conf_level=0.68, ylim=c(-1,3),
	xlab="Number of chronic conditions", 
	main="Odds ratios for practitioner and place, Gender: Female")
lodds <- loddsratio(tab[,,,2,])
plot(lodds, conf_level=0.68, , ylim=c(-1,3), whiskers=0.1,
	xlab="Number of chronic conditions", 
	main="Odds ratios for practitioner and place, Gender: Male"))


# anova of odds ratios
lodds.mod <- lm(LOR ~ (gender + insurance + chronicf)^2, weights=1/ASE^2, data=lodds.df)
anova(lodds.mod)
summary(lods.mod)



# vector generalized additive model
library(VGAM)


nmes2.nbin   <- vglm(cbind(visits, nvisits, ovisits, novisits) ~ ., data = nmes2, 
	family = negbinomial)
summary(nmes2.nbin)

# coefficients for visits
coef(nmes2.nbin, matrix=TRUE)[,c(1,2)]
# theta for visits
exp(coef(nmes2.nbin, matrix=TRUE)[1,2])

coef(nmes2.nbin, matrix=TRUE)[,c(1,3,5,7)]

# compare with separate estimation: get the same coefficients & standard errors
#hospital+health+chronic+gender+school+insurance
nmes2_nbin1   <- vglm(visits ~ hospital+health+chronic+gender+school+insurance, data = nmes2, family = negbinomial)
nmes2_nbin2   <- vglm(nvisits ~ hospital+health+chronic+gender+school+insurance, data = nmes2, family = negbinomial)
nmes2_nbin3   <- vglm(ovisits ~ hospital+health+chronic+gender+school+insurance, data = nmes2, family = negbinomial)
nmes2_nbin4   <- vglm(novisits ~ hospital+health+chronic+gender+school+insurance, data = nmes2, family = negbinomial)

cbind(coef(nmes2_nbin1)[-2], coef(nmes2_nbin2)[-2],coef(nmes2_nbin3)[-2],coef(nmes2_nbin4)[-2])


# Constrained models

clist <- constraints(nmes2.nbin, type = "term")
clist$hospital[c(1,3,5,7),]

clist2 <- clist
clist2$hospital  <- cbind(rowSums(clist$hospital))
#clist2$health    <- cbind(rowSums(clist$health))
clist2$chronic  <- cbind(rowSums(clist$chronic))
#clist2$school   <- cbind(rowSums(clist$school))
# show constraints

clist2$hospital[c(1,3,5,7), 1, drop=FALSE]


nmes2.nbin2   <-
  vglm(cbind(visits, nvisits, ovisits, novisits) ~ .,
#      hospital + health + chronic + gender + school + insurance, 
       data = nmes2, 
       constraints = clist2,
       family = negbinomial(zero = NULL))


coef(nmes2.nbin2, matrix=TRUE)[,c(1,3,5,7)]


lrtest(nmes2.nbin, nmes2.nbin2)

# Is it possible to contrain the coefficients for diff responses to be equal or test this?
# Is there a hurdle version of this model, e.g., allowing for excess zeros?

# Test equality

# one term
lh <- paste("hospital:", 1:3, " = ", "hospital:", 2:4, sep="")
lh
car::linearHypothesis(nmes2.nbin, lh)

# all terms
terms <- dimnames(nmes2.nbin@x)[[2]][-1]
#terms <- attr(terms(nmes2.nbin), "term.labels")
for (term in terms) {
	lh <- paste(term, ":", 1:3, " = ", term, ":", 2:4, sep="")
	print(car::linearHypothesis(nmes2.nbin, lh)	)
}




# transform to 2x2 response design, for two different sets of "main effects"
# each pair of which can be analysed as a bivariate response

nmes2x2 <- transform(nmes2,
	off   = visits + nvisits,
	hosp = ovisits + novisits,
	phys = visits + nvisits,
	nphys = nvisits + novisits)

plot(jitter(off+1) ~ jitter(hosp+1), data=nmes2x2, log="xy")

plot(jitter(phys+1) ~ jitter(nphys+1), data=nmes2x2, log="xy")


nmes2x2_nbin1   <- vglm(cbind(off, hosp) ~ hospital + health + chronic + gender + school + insurance, 
	data = nmes2x2, family = negbinomial)
coef(nmes2x2_nbin1, matrix=TRUE)[,c(1,3)]


nmes2x2_nbin2   <- vglm(cbind(phys, nphys) ~ hospital + health + chronic + gender + school + insurance, 
	data = nmes2x2, family = negbinomial)
coef(nmes2x2_nbin2, matrix=TRUE)[,c(1,3)]


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
	

