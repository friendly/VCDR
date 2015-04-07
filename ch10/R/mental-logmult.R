## Mental health data
#library(gnm)
library(vcdExtra)
data("Mental", package="vcdExtra")

##  Goodman Row-Column association model fits well (deviance 3.57, df 8)
#Mental$mental <- C(Mental$mental, treatment)
#Mental$ses <- C(Mental$ses, treatment)

library(logmult)  # requires new version, logmult_0.6.1

RC1 <- gnm(Freq ~ mental + ses + Mult(mental, ses),
                family = poisson, data = Mental, verbose=FALSE)

Mental.tab <- xtabs(Freq ~ mental + ses, data=Mental)
rc1 <- rc(Mental.tab, verbose=FALSE, weighting="marginal", se="jackknife" )
rc1
src1 <- summary(rc1)

# NB: this conflicts with vcd::assoc, and doesn't give standard errors
#params <- logmult:::assoc(rc1)
params <- rc1$assoc
stderr <- se(rc1)

# plot the 1D solution
scores <- data.frame(
  factor = c(rep("mental", 4), rep("ses", 6)),
	estimate = rbind(
		t(t(params$row[, , 1])),
		t(t(params$col[, , 1]))
		),
	stderr = rbind(
		t(t(stderr$row[, , 1])),
		t(t(stderr$col[, , 1]))
		)
	)
scores$lower <- scores[,2]-scores[,3]
scores$upper <- scores[,2]+scores[,3]
		
scores
		
with(scores, {
  dotchart(estimate, groups=factor, labels=rownames(scores), 
           cex=1.2, pch=16, xlab="RC1 Score",
           xlim=c(min(lower), max(upper)))
  arrows(lower, c(8+(1:4), 1:6), upper, c(8+(1:4), 1:6), 
         col="red", angle=90, length=.05, code=3, lwd=2) 
  })

# use plot.rc method for a similar dotchart, w/o error bars
plot(rc1)

rc2 <- rc(Mental.tab, verbose=FALSE, nd=2, weighting="marginal", se="jackknife")
rc2

#unlockBinding("plot.assoc", as.environment("package:logmult"))
#source("c:/R/functions/plot.assoc.R")
#assign("plot.assoc", plot.assoc, "package:logmult")

pdf(file="mental-logmult-rc2.pdf", h=6, w=6)

op <- par(mar=c(4,4,1,1)+.1)
coords  <- plot(rc2, conf.ellipses=0.68, cex=1.5, rev.axes=c(TRUE, FALSE))
scores <- rbind(coords$row, coords$col)
lines(scores[1:4,], col="blue", lwd=2)
lines(scores[-(1:4),], col="red", lwd=2)

# using rc2$assoc directly
#params <- rc2$assoc
#row <- params$row[,,1]
#col <- params$col[,,1]
#gamma <- params$phi
#scores <- rbind(row, col)
#scores <- sweep(scores, 2, sqrt(abs(gamma)), "*")
#scores[,1] <- -scores[,1]  # reverse axis 1
#lines(scores[1:4,], col="blue", lwd=2)
#lines(scores[-(1:4),], col="red", lwd=2)
par(op)

dev.off()

# polar plot
coords <- plot(rc2, conf.ellipses=0.68, cex=1.5, coords="polar", rev.axes=c(TRUE, FALSE))
scores <- rbind(coords$row, coords$col)
lines(scores[1:4,], col="blue", lwd=2)
lines(scores[-(1:4),], col="red", lwd=2)


# try uniform weighting
rc2 <- rc(Mental.tab, verbose=FALSE, nd=2, weighting="uniform", se="jackknife")
coords <- plot(rc2, conf.ellipses=0.68, cex=1.5, rev.axes=c(TRUE, FALSE))
# using scores from plot()
scores <- rbind(coords$row, coords$col)
lines(scores[1:4,], col="blue", lwd=2)
lines(scores[-(1:4),], col="red", lwd=2)


#params <- logmult::assoc(rc2)
params <- rc2$assoc
row <- params$row[,,1]
col <- params$col[,,1]
gamma <- params$phi
scores <- rbind(row, col)
scores <- sweep(scores, 2, sqrt(abs(gamma)), "*")
scores[,1] <- -scores[,1]  # reverse axis 1
lines(scores[1:4,], col="blue", lwd=2)
lines(scores[-(1:4),], col="red", lwd=2)

# try no weighting
rc2 <- rc(Mental.tab, verbose=FALSE, nd=2, weighting="none", se="jackknife")
coords <- plot(rc2, conf.ellipses=0.68, cex=1.5, rev.axes=c(TRUE, FALSE))
# using scores from plot()
scores <- rbind(coords$row, coords$col)
lines(scores[1:4,], col="blue", lwd=2)
lines(scores[-(1:4),], col="red", lwd=2)
