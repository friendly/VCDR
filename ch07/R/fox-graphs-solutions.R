# Solutions to Graphics Exercises

# the first graph

eta <- seq(-10, 10, len=100)
p1 <- plogis(eta - 1)
p2 <- plogis(eta + 1)
p3 <- plogis(eta + 4.5)
plot(c(-10, 10), range(p1, p2, p3), type="n", axes=FALSE, frame=TRUE, xlab="x", ylab="Pr(y > j)")
axis(2)
abline(h=c(0,1), col="gray")
lines(eta, p1, lwd=2)
lines(eta, p2, lwd=2)
lines(eta, p3, lwd=2)
coords <- locator(2)  # coordinates for first arrow
arrows(coords$x[1], coords$y[1], coords$x[2], coords$y[2], code=1, length=0.125)
text(coords$x[2], coords$y[2], pos=3, "Pr(y > 1)")
coords <- locator(2)  # coordinates for second arrow 
arrows(coords$x[1], coords$y[1], coords$x[2], coords$y[2], code=1, length=0.125)
text(coords$x[2], coords$y[2], pos=3, "Pr(y > 2)")
coords <- locator(2)  # coordinates for third arrow
arrows(coords$x[1], coords$y[1], coords$x[2], coords$y[2], code=1, length=0.125)
text(coords$x[2], coords$y[2], pos=3, "Pr(y > 3)")


# The second graph:

par(mar = c(6, 6, 6, 6) + 0.1) 

plot(c(0, 1), c(0, 1), type="n", axes=FALSE, frame=TRUE, xlab="x", ylab="")
axis(1, at=c(.3, .7), labels=c(expression(x[1]), expression(x[2])))
axis(2, at=c(.1, .2, .6), labels=c(expression(alpha[1]), expression(alpha[2]), expression(alpha[3])), las=1)
text(-0.1, 1.05, expression(xi), xpd=TRUE)
abline(h=c(.1, .2, .6), lty=2)
text(rep(1.1, 5), c(1.05, 0.05, 0.15, 0.4, 0.8),  c("y", 1:4), xpd=TRUE)
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
polygon(x11, y11, col="gray")

sel2 <- y2 >= .6
y21 <- y2[sel2]
x21 <- x2[sel2]
y21 <- c(y21[1], y21)
x21 <- c(.7, x21)
polygon(x21, y21, col="gray")

abline(.35, .6, lwd=2)

coords <- locator(2) # for arrow and text, first area  

arrows(coords$x[1], coords$y[1], coords$x[2], coords$y[2], code=1, length=0.125)
text(coords$x[2], coords$y[2], pos=3, expression(Pr(y == 4 * "|" * x[1])))

coords <- locator(2) # for arrow and text, second area
arrows(coords$x[1], coords$y[1], coords$x[2], coords$y[2], code=1, length=0.125)
text(coords$x[2], coords$y[2], pos=1, expression(Pr(y == 4 * "|" * x[2])))

coords <- locator(2) # for arrow and text, regression line
arrows(coords$x[1], coords$y[1], coords$x[2], coords$y[2], code=1, length=0.125)
text(coords$x[2], coords$y[2], pos=1, expression(E(xi) == alpha + beta*x))
