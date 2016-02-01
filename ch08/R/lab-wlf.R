data("Womenlf", package="car")
library(VGAM)

Womenlf$partic <- ordered( Womenlf$partic,
                     levels=c("not.work", "parttime", "fulltime"))
# try reverse order
#Womenlf$partic <- ordered( Womenlf$partic,
#                     levels=rev(c("not.work", "parttime", "fulltime")))
                     
Wlf.po <- vglm(partic ~ hincome + children, data = Womenlf, family
    = cumulative(parallel = TRUE)) 

Wlf.npo <- vglm(partic ~ hincome + children, data = Womenlf, family
    = cumulative(parallel = FALSE), control=vglm.control(maxit=100)) 

lrtest(Wlf.npo, Wlf.po)

coef(Wlf.po, matrix=TRUE)
coef(Wlf.npo, matrix=TRUE)

# manual test
tab <- cbind(
	Deviance = c(deviance(Wlf.npo), deviance(Wlf.po)),
	df = c(df.residual(Wlf.npo), df.residual(Wlf.po))
	)
tab <- rbind(tab, diff(tab))
rownames(tab) <- c("GenLogit", "PropOdds", "LR test")
tab <- cbind(tab, pvalue=1 - pchisq(tab[,1], tab[,2]))
tab

# try lrm
library(rms)
Wlf.po2 <- lrm(partic ~ hincome + children, data = Womenlf)
Wlf.po2

# plots

op <- par(mfrow=c(1,2))
plot.xmean.ordinaly(partic ~ hincome + children, data = Womenlf,
	lwd=2, pch=16, subn=FALSE)
par(op)


