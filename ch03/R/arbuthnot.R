data(Arbuthnot, package="HistData")


# plot Pr(Male)
op <- par(mar=c(4,4,1,1)+.1, cex.lab=1.25)
data(Arbuthnot, package = "HistData")
with(Arbuthnot, {
  prob = Males / (Males + Females)
  plot(x = Year, y = prob, type = "b", 
       ylim = c(0.5, 0.54), ylab = "Pr (Male)")
  abline(h = 0.5, col = "red", lwd = 2)
  abline(h = mean(prob), col = "blue")
  lines(loess.smooth(Year, prob), col = "blue", lwd = 2)
  text(x = 1640, y = 0.5, expression(H[0]: "Pr(Male)=0.5"), pos = 3, col = "red")
  })
par(op)

# using scatter.smooth()
op <- par(mar=c(4,4,1,1)+.1, cex.lab=1.25)
prob <- with(Arbuthnot, Males / (Males + Females))
scatter.smooth(x = Arbuthnot$Year, y = prob, type = "b", 
               lpars = list(col = "blue", lwd = 2),
               xlab = "Year", ylab = "Pr(Male)", ylim = c(0.5, 0.54))
abline(h = 0.5, col = "red", lwd = 2)
abline(h = mean(prob), col = "blue")
text(x = 1640, y = 0.5, expression(H[0]: "Pr(Male)=0.5"), pos = 3, col = "red")
par(op)



# plot the sex ratios
with(Arbuthnot, plot(Year,Ratio, type='b', ylim=c(1, 1.20), ylab="Sex Ratio (M/F)"))
abline(h=1, col="red", lwd=2)
abline(h=mean(Arbuthnot$Ratio), col="blue")
text(x=1630, y=1, expression(H[0]), pos=3, col="red")
#  add loess smooth
Arb.smooth <- with(Arbuthnot, loess.smooth(Year,Ratio))
lines(Arb.smooth$x, Arb.smooth$y, col="blue", lwd=2)

