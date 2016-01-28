#' ---
#' title: "Accident data, MCA analysis, Exercise 6.12"
#' author: "Michael Friendly"
#' date: "20 Apr 2015"
#' ---


library(ca)
data(Accident, package="vcdExtra")

accident.tab <- xtabs(Freq ~ age + mode + gender + result, data = Accident)
accident.mca <- mjca(accident.tab) 
summary(accident.mca)
plot(accident.mca)


res <- plot(accident.mca, labels=0, pch='.', cex.lab=1.2) #makes plot with no labels or points
coords <- data.frame(res$cols, accident.mca$factors)#to extract factor names & levels 
#str(accident.mca)
cols <- c("blue", "red", "brown", "black")
nlev <- accident.mca$levels.n

points(coords[,1:2], pch=rep(16:19, nlev), col=rep(cols, nlev), cex=1.2)
text(coords[,1:2], label=coords$level, col=rep(cols, nlev), pos=3, cex=1.2, xpd=TRUE)
#lines(Dim2 ~ Dim1, data=coords, subset=factor=="age", lty=1, lwd=2, col="blue")
#lines(Dim2 ~ Dim1, data=coords, subset=factor=="mode", lty=1, lwd=2, col="red")
lines(Dim2 ~ Dim1, data=coords, subset=factor=="gender", lty=1, lwd=2, col="brown")
lines(Dim2 ~ Dim1, data=coords, subset=factor=="result", lty=1, lwd=3, col="black")

legend("topright", legend=c("Age", "Mode", "Gender", "Result"),
	title="Factor", title.col="black",
	col=cols, text.col=cols, pch=16:19,
	bg="gray95", cex=1.2)

# or, using multilines -- doesn't work well

#res <- plot(accident.mca, labels=0, pch='.', cex.lab=1.2) #makes plot with no labels or points
#coords <- data.frame(res$cols, accident.mca$factors)#to extract factor names & levels 
##str(accident.mca)
#cols <- c("blue", "red", "brown", "black")
#nlev <- accident.mca$levels.n
#points(coords[,1:2], pch=rep(16:19, nlev), col=rep(cols, nlev), cex=1.2)
#text(coords[,1:2], label=coords$level, col=rep(cols, nlev), pos=3, cex=1.2, xpd=TRUE)
#multilines(coords[,1:2], group=coords$factor, col=rep(cols, nlev), lwd=c(2,2,2,3))
#

# using mcaplot

source("C:/Dropbox/R/functions/mcaplot.R")

mcaplot(accident.mca, pch=15:19, legend=TRUE)

#legend("topright", legend=c("Age", "Mode", "Gender", "Result"),
#	title="Factor", title.col="black",
#	col=cols, text.col=cols, pch=16:19,
#	bg=rgb(242,242,242, 100, max=255), cex=1.2)
