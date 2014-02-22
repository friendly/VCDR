data(Arbuthnot, package="HistData")

# plot the sex ratios
with(Arbuthnot, plot(Year,Ratio, type='b', ylim=c(1, 1.20), ylab="Sex Ratio (M/F)"))
abline(h=1, col="red", lwd=2)
abline(h=mean(Arbuthnot$Ratio), col="blue")
text(x=1630, y=1, expression(H[0]), pos=3, col="red")
#  add loess smooth
Arb.smooth <- with(Arbuthnot, loess.smooth(Year,Ratio))
lines(Arb.smooth$x, Arb.smooth$y, col="blue", lwd=2)


# plot Pr(Male)
with(Arbuthnot, {
  prob = Males/(Males+Females)
	plot(Year, prob, type='b', ylim=c(0.5, 0.54), ylab="Pr (Male)")
  abline(h=0.5, col="red", lwd=2)
	abline(h=mean(prob), col="blue")
	text(x=1640, y=0.5, expression(H[0]: "Pr(Male)=0.5"), pos=3, col="red")
	Arb.smooth <- loess.smooth(Year,prob)
	lines(Arb.smooth$x, Arb.smooth$y, col="blue", lwd=2)
	}
	)

