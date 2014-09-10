# from John Fox

# The second graph:

height = 5
width = 10

windows(width=width, height=height)

pdf(file="latent.pdf", height=height, width=width)

op <- par(mar = c(4, 4, 2, 4) + 0.1) 
plot(c(0, 1), c(0, 1), type="n", axes=FALSE, frame=TRUE, xlab="x", ylab="", cex.lab=1.5)
axis(1, at=c(.3, .7), labels=c(expression(x[1]), expression(x[2])))
axis(2, at=c(.1, .2, .6), labels=c(expression(alpha[1]), expression(alpha[2]), expression(alpha[3])), las=1, cex=1.5)
text(-0.1, 1.05, expression(xi), xpd=TRUE, cex=1.5)
abline(h=c(.1, .2, .6), lty=2)
text(rep(1.1, 5), c(1.05, 0.05, 0.15, 0.4, 0.8),  c("Y", 1:4), xpd=TRUE, cex=1.5)
abline(v=c(.3, .7), lty=2)

x<- seq(-3, 3, len=100)
y <- dnorm(x)/2 # with suitable calibration, you could use dlogis()
y1 <- x/12 + .53
x1 <- y + .3
lines(x1, y1)
y2 <- x/12 + .77
x2 <- y + .7
lines(x2, y2)

sel1 <- y1 >= .6
y11 <- y1[sel1]
x11 <- x1[sel1]
y11 <- c(y11[1], y11)
x11 <- c(.3, x11)
polygon(x11, y11, col="lightpink")

sel2 <- y2 >= .6
y21 <- y2[sel2]
x21 <- x2[sel2]
y21 <- c(y21[1], y21)
x21 <- c(.7, x21)
polygon(x21, y21, col="lightpink")

abline(.35, .6, lwd=3, col="blue")

#coords <- locator(2) # for arrow and text, first area  
#arrows(coords$x[1], coords$y[1], coords$x[2], coords$y[2], code=1, length=0.125)
#text(coords$x[2], coords$y[2], pos=3, expression(Pr(y == 4 * "|" * x[1])))

text(.3, .65, expression(Pr(Y == 4 * "|" * x[1])), pos=2, col="red", cex=1.2)

#coords <- locator(2) # for arrow and text, second area
#arrows(coords$x[1], coords$y[1], coords$x[2], coords$y[2], code=1, length=0.125)
#text(coords$x[2], coords$y[2], pos=1, expression(Pr(y == 4 * "|" * x[2])))

text(.8, .65, expression(Pr(Y == 4 * "|" * x[2])), pos=4, col="red", cex=1.2)

#coords <- locator(2) # for arrow and text, regression line
#arrows(coords$x[1], coords$y[1], coords$x[2], coords$y[2], code=1, length=0.125)
#text(coords$x[2], coords$y[2], pos=1, expression(E(xi) == alpha + beta*x))

angle <- atan(.6) * (180/pi) * (height/width)
text(.1, .42, pos=3, expression(E(xi) == alpha + beta*x), srt=angle, col="blue", cex=1.5) 

par(op)

dev.off()
