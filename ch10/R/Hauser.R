#' ---
#' title: "Fit models for square tables to Hauser79 data"
#' author: "Michael Friendly"
#' date: "18 Apr 2015"
#' ---


# data from Hauser (1979)
# R.M. Hauser (1979), Some exploratory methods for modeling mobility tables and other cross-classified data. 
# In: K.F. Schuessler, Editor, Sociological Methodology, 1980, Jossey-Bass, San Francisco, pp. 413?458.
library(vcdExtra)
data("Hauser79", package="vcdExtra")

# display table
structable(~Father+Son, data=Hauser79)

#Examples from Powers & Xie, Table 4.15
# independence model
hauser.indep <- gnm(Freq ~ Father + Son, data=Hauser79, family=poisson)
mosaic(hauser.indep, ~Father+Son, main="Independence model", gp=shading_Friendly)

hauser.quasi <-  update(hauser.indep, ~ . + Diag(Father,Son))
mosaic(hauser.quasi, ~Father+Son, main="Quasi-independence model", gp=shading_Friendly)

mosaic(hauser.quasi, ~Father+Son, main="Quasi-independence model", 
       gp=shading_Friendly, residuals_type="rstandard")

hauser.qsymm <-  update(hauser.indep, ~ . + Diag(Father,Son) + Symm(Father,Son))
#mosaic(hauser.qsymm, ~Father+Son, main="Quasi-symmetry model", gp=shading_Friendly)

mosaic(hauser.qsymm, ~Father+Son, main="Quasi-symmetry model", 
       gp=shading_Friendly, residuals_type="rstandard")

#mosaic(hauser.qsymm, ~Father+Son, main="Quasi-symmetry model")

# Levels for Hauser 5-level model
levels <- matrix(c(
  2,  4,  5,  5,  5,
  3,  4,  5,  5,  5,
  5,  5,  5,  5,  5,
  5,  5,  5,  4,  4,
  5,  5,  5,  4,  1
  ), 5, 5, byrow=TRUE)

hauser.topo <- update(hauser.indep, ~ . + Topo(Father, Son, spec=levels))
LRstats(hauser.topo)

# coefficients
coef(hauser.topo)[pickCoef(hauser.topo, "Topo")]
as.vector((coef(hauser.topo)[pickCoef(hauser.topo, "Topo")]))
getContrasts(hauser.topo, pickCoef(hauser.topo, "Topo"))


mosaic(hauser.topo, ~Father+Son, main="Topological model", gp=shading_Friendly)
mosaic(hauser.topo, ~Father+Son, main="Topological model", 
       gp=shading_Friendly, residuals_type="rstandard")


vcdExtra::LRstats(glmlist(hauser.indep, hauser.quasi, hauser.qsymm, hauser.topo))

#### Models for ordinal variables

# numeric scores for row/column effects
Fscore <- as.numeric(Hauser79$Father)
Sscore <- as.numeric(Hauser79$Son)

# uniform association
hauser.UA <- update(hauser.indep, ~ . + Fscore*Sscore)
LRstats(hauser.UA)


# row effects model
hauser.roweff <- update(hauser.indep, ~ . + Father*Sscore)
LRstats(hauser.roweff)

hauser.RC <- update(hauser.indep, ~ . + Mult(Father, Son), verbose=FALSE)
mosaic(hauser.RC, ~Father+Son, main="RC model", gp=shading_Friendly)
LRstats(hauser.RC)

vcdExtra::LRstats(glmlist(hauser.indep, hauser.UA, hauser.roweff, hauser.RC))


# uniform association, omitting diagonals
#hauser.UAdiag <- update(hauser.indep, ~ . + Fscore*Sscore + Diag(Father,Son))
hauser.UAdiag <- update(hauser.UA, ~ . + Diag(Father,Son))
LRstats(hauser.UAdiag)
anova(hauser.UA, hauser.UAdiag, test="Chisq")

# coefficients
coef(hauser.UAdiag)[["Fscore:Sscore"]]
exp(coef(hauser.UAdiag)[["Fscore:Sscore"]])
 
mosaic(hauser.UAdiag, ~Father+Son, main="UA + Diag()", gp=shading_Friendly, residuals_type="rstandard")
 
hauser.CR <- update(hauser.indep, ~ . + Crossings(Father,Son))
LRstats(hauser.CR)

#hauser.CRdiag <- update(hauser.indep, ~ . + Crossings(Father,Son) + Diag(Father,Son))
hauser.CRdiag <- update(hauser.CR, ~ . + Diag(Father,Son))
LRstats(hauser.CRdiag)

# coefficients
nu <- coef(hauser.CRdiag)[pickCoef(hauser.CRdiag, "Crossings")]
names(nu) <- gsub("Crossings(Father, Son)C", "nu", names(nu), fixed=TRUE)
nu

mosaic(hauser.CRdiag, ~Father+Son, main="Crossings() + Diag()", gp=shading_Friendly, residuals_type="rstandard")
 


################################

# compare model fit statistics
modlist <- glmlist(hauser.indep, hauser.roweff, hauser.UA, hauser.UAdiag, 
                   hauser.quasi, hauser.qsymm,  hauser.topo, 
                   hauser.RC, hauser.CR, hauser.CRdiag)
vcdExtra::LRstats(modlist, sortby="AIC")

sumry <- LRstats(glmlist(hauser.indep, hauser.roweff, hauser.UA, hauser.UAdiag, hauser.quasi, hauser.qsymm,  
       hauser.topo, hauser.RC, hauser.CR, hauser.CRdiag))
sumry[order(sumry$BIC, decreasing=TRUE),]
sumry[order(sumry$Df, decreasing=TRUE),]


sumry <- LRstats(modlist)
mods <- substring(rownames(sumry),8)

#with(sumry,
#	{plot(Df, AIC, cex=1.3, pch=19, xlab='Degrees of freedom', ylab='AIC')
#	text(Df, AIC, mods, adj=c(0.5,-.5), col='red', xpd=TRUE)
#	})
#
## similar plot for Chisq/Df
#with(sumry,
#	{ChisqDf <- `LR Chisq`/Df
#	plot(Df, ChisqDf, cex=1.3, pch=19, xlab='Degrees of freedom', ylab='Chisq / df')
#	text(Df, ChisqDf, mods, adj=c(0.5,-.5), col='red', xpd=TRUE)
#	})


# plot on log scale

with(sumry, {
	plot(Df, AIC, cex=1.3, pch=19, 
	xlab='Degrees of freedom', ylab='AIC (log scale)', 
	log="y", cex.lab=1.2)
	pos <- 3 # ifelse(mods=="UAdiag", 1, 3)
	text(Df, AIC, mods, pos=pos, col='red', xpd=TRUE, , cex=1.2)
	})

# plot on log scale-- doesn't work for negative values
with(sumry, {
	plot(Df, BIC+55, cex=1.3, pch=19, 
	xlab='Degrees of freedom', ylab='BIC (log scale)', 
	log="y", cex.lab=1.2)
	pos <- ifelse(mods=="UAdiag", 1, 3)
	text(Df, BIC+55, mods, pos=pos, col='red', xpd=TRUE, , cex=1.2)
	})

with(sumry, {
	ChisqDf <- `LR Chisq`/Df
	plot(Df, ChisqDf, cex=1.3, pch=19, xlab='Degrees of freedom', ylab='Chisq / df (log scale)', log="y")
	text(Df, ChisqDf, mods, pos=3, col='red', xpd=TRUE, cex=1.2)
	})

##########################################

hauser.tab <- xtabs(Freq ~ Father+Son, data=Hauser79)
(lor.hauser <- loddsratio(hauser.tab))

# odds ratio plot -- corrected
matplot(as.matrix(lor.hauser), type='b', lwd=2,
  ylab='Local log odds ratio', 
	xlab="Fathers's status comparisons", 
	xaxt='n', cex.lab=1.2,
	xlim=c(1,4.5), ylim=c(-.5,3)
	)
abline(h=0, col='gray')
abline(h=mean(lor.hauser$coefficients))
axis(side=1, at=1:4, labels=rownames(lor.hauser))
text(4, as.matrix(lor.hauser)[4,], colnames(lor.hauser), pos=4, col=1:4, xpd=TRUE, cex=1.2)
text(4, 3, "Son's status", cex=1.2)

# much simpler with plot.loddsratio; but why is Father/Son reversed wrt the matplot version?
#plot(t(lor.hauser), confidence=FALSE, legend_pos="topleft", xlab="Son's status comparisons")

plot(lor.hauser, confidence=FALSE, legend_pos="topleft", xlab="Father's status comparisons")
m <- mean(lor.hauser$coefficients)
grid.lines(x=unit(c(0,1), "npc"),
           y=unit(c(m,m), "native"))

