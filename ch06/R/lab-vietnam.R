data(Vietnam, package="vcdExtra")

vietnam.tab <- xtabs(Freq ~ sex + year + response, data=Vietnam)
vietnam.stacked <- as.matrix(structable(response ~ sex + year, vietnam.tab), sep=":")

library(ca)
vietnam.ca <- ca(vietnam.stacked)
summary(vietnam.ca, rows=FALSE, columns=FALSE)

plot(vietnam.ca, cex.lab=1.3, lines=c(FALSE, TRUE), lwd=2)

vietnam.mca <- mjca(vietnam.tab)
mcaplot(vietnam.mca)


