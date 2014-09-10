# demonstrate proportional odds model


xy <- expand.grid(x=seq(0, 100, 10), y=1:3)

intercept <- -c(1, 4, 6)
xy$logit <- intercept[xy$y] + .075 * xy$x
xy$prob <- 1/(1 + exp(-xy$logit))
labels <- c('Y>1', 'Y>2', 'Y>3') 
xy$lab <- factor(labels[xy$y])


library(lattice)
library(directlabels)

levels(xy$lab)

plt <- xyplot(prob ~ x, groups=lab, data=xy, type='b', 
	lwd=3, cex=1.2, pch=16, xlim=c(-5,115),
	ylab=list('Probability', cex=1.25), xlab=list("x", cex=1.25)
#	auto.key=list(title="Response", x=.05, y=.95, lines=TRUE, lwd=2, cex=1.2, pch=16)
	)

lab.pos <- list(last.points, dl.trans(x=x+.3, y=y+.1), cex=1.25)

folder <- "C:/Documents and Settings/friendly/My Documents/My Dropbox/Documents/VCDR/ch07/fig/"
pdf(file=paste0(folder, "podds1.pdf"), height=5, width=7)
direct.label(plt, lab.pos)
dev.off()



plt <- xyplot(logit ~ x, groups=lab, data=xy, type='b', 
	lwd=3, cex=1.2, pch=16, , xlim=c(-5,115),
	ylab=list('Log odds', cex=1.25), xlab=list("x", cex=1.25)
	)

pdf(file=paste0(folder, "podds2.pdf"), height=5, width=7)
direct.label(plt, lab.pos)
dev.off()

