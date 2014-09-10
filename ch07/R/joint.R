# demo joint influence

x <- 1:6
y <- c(1, 2.8, 2.2, 4, 5.7, 5.3)
df0 <- data.frame(x, y, status=1)

#plot(y ~ x, data=df0, xlim=c(0,10), ylim=c(0,10))
#abline(lm(y ~ x, data=df0))

op <- par(mfrow=c(1,3), mar=c(4,4,2,1)+.1)

ex1 <- rbind(df0, data.frame(x=9, y=c(1,2), status=c(2,3)))
pch <- c(16, 15,17)[ex1$status]
col <- c("darkgray", "red", "blue")[ex1$status]
plot(y ~ x, data=ex1, xlim=c(0,10), ylim=c(0,10), pch=pch, col=col, cex=2)
abline(lm(y ~ x, data=ex1), lwd=4)       # all
abline(lm(y ~ x, data=ex1, subset=!status==2), col="blue", lty=2)  # delete point 1
abline(lm(y ~ x, data=ex1, subset=!status==3), col="red", lty=3)  # delete point 2
abline(lm(y ~ x, data=ex1, subset=status==1), col="purple", lwd=2)         # delete both
text(0, 9.8, "(a) enhanced influence", pos=4, cex=1.8)


ex2 <- rbind(df0, data.frame(x=9, y=c(10,5), status=c(2,3)))
pch <- c(16, 15,17)[ex2$status]
col <- c("darkgray", "red", "blue")[ex2$status]
plot(y ~ x, data=ex2, xlim=c(0,10), ylim=c(0,10), pch=pch, col=col, cex=2.5)
abline(lm(y ~ x, data=ex2), lwd=4)       # all
abline(lm(y ~ x, data=ex2, subset=!status==2), col="blue", lty=2)  # delete point 1
abline(lm(y ~ x, data=ex2, subset=!status==3), col="red", lty=3)  # delete point 2
abline(lm(y ~ x, data=ex2, subset=status==1), col="purple", lwd=2)         # delete both
text(0, 9.8, "(b) masking", pos=4, cex=1.8)

ex3 <- rbind(df0, data.frame(x=c(1,9), y=c(8,3), status=c(2,3)))
pch <- c(16, 15,17)[ex3$status]
col <- c("darkgray", "red", "blue")[ex3$status]
plot(y ~ x, data=ex3, xlim=c(0,10), ylim=c(0,10), pch=pch, col=col, cex=2.5)
abline(lm(y ~ x, data=ex3), lwd=4)       # all
abline(lm(y ~ x, data=ex3, subset=!status==2), col="blue", lty=2)  # delete point 1
abline(lm(y ~ x, data=ex3, subset=!status==3), col="red", lty=3)  # delete point 2
abline(lm(y ~ x, data=ex3, subset=status==1), col="purple", lwd=2)         # delete both
text(0, 9.8, "(c) swamping", pos=4, cex=1.8)

par(op)

dev.copy2pdf(file="joint.pdf")

