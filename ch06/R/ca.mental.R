library(ca)
data("Mental", package="vcdExtra")
mental.tab <- xtabs(Freq ~ ses + mental, data=Mental)

mental.ca <- ca(mental.tab)
mental.ca
plot(mental.ca, xlab="Dimension 1", ylab="Dimension 2", lines=TRUE)


op <- par(cex=1.3, mar=c(5,4,1,1)+.1)
res <- plot(mental.ca, ylim=c(-.2, .2),
            xlab="Dimension 1 (93.9%)", ylab="Dimension 2 (0.5%)")
lines(res$rows, col="blue", lty=3)
lines(res$cols, col="red", lty=4)
par(op)

