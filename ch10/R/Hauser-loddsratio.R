#' ---
#' title: "Plot log odds ratios for Hauser79 data"
#' author: "Michael Friendly"
#' date: "18 Apr 2015"
#' ---


library(vcdExtra)
data("Hauser79", package="vcdExtra")

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

