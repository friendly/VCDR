#library(vcdExtra)
library(ca)

data(Titanic)

# don't need to do this now, with ca 0.55+
#titanic.df <- expand.dft(as.data.frame(Titanic))
#titanic.mca <- mjca(titanic.df)

titanic.mca <- mjca(Titanic)

summary(titanic.mca)

# default plot
plot(titanic.mca)

# compare summaries with different methods
summary(mjca(Titanic, lambda="Burt"))
summary(mjca(Titanic, lambda="indicator"))
values <- titanic.mca$inertia.e
100*values


# plot, but don't use point labels or points
res <- plot(titanic.mca, labels=0, pch='.', cex.lab=1.2)

# extract factor names and levels
coords <- data.frame(res$cols)
faclevs <- strsplit(rownames(coords), ':')
coords$factor <- sapply(faclevs, function(x) x[1])
coords$levels <- sapply(faclevs, function(x) x[2])
coords

cols <- c("blue", "red", "brown", "black")
nlev <- c(4,2,2,2)
points(coords[,1:2], pch=rep(16:19, nlev), col=rep(cols, nlev), cex=1.2)
pos <- c(3,1,1,3)
text(coords[,1:2], coords$levels, col=rep(cols, nlev), pos=rep(pos,nlev), cex=1.1, xpd=TRUE)

coords <- coords[ order(coords[,"factor"], coords[,"Dim1"]), ]

lines(Dim2 ~ Dim1, data=coords, subset=factor=="Class", lty=1, lwd=2, col="blue")
lines(Dim2 ~ Dim1, data=coords, subset=factor=="Sex",  lty=1, lwd=2, col="red")
lines(Dim2 ~ Dim1, data=coords, subset=factor=="Age",  lty=1, lwd=2, col="brown")
lines(Dim2 ~ Dim1, data=coords, subset=factor=="Survived",  lty=1, lwd=2, col="black")

legend("topleft", legend=c("Class", "Sex", "Age", "Survived"), 
	title="Factor", title.col="black",
	col=cols, text.col=cols, pch=16:19, 
	bg="gray95", cex=1.2)

######################################################
# using new version 0.56 of ca package

op <- par(mar=c(5,4,1,1)+.1)
res <- plot(titanic.mca, labels=0, pch='.', cex.lab=1.2)

# extract factor names and levels
coords <- data.frame(res$cols, titanic.mca$factors)
#faclevs <- strsplit(rownames(coords), ':')
#coords$factor <- sapply(faclevs, function(x) x[1])
#coords$levels <- sapply(faclevs, function(x) x[2])
coords

cols <- c("blue", "red", "brown", "black")
nlev <- c(4,2,2,2)
points(coords[,1:2], pch=rep(16:19, nlev), col=rep(cols, nlev), cex=1.2)
pos <- c(3,1,1,3)
text(coords[,1:2], label=coords$level, col=rep(cols, nlev), pos=rep(pos,nlev), cex=1.1, xpd=TRUE)

coords <- coords[ order(coords[,"factor"], coords[,"Dim1"]), ]

lines(Dim2 ~ Dim1, data=coords, subset=factor=="Class", lty=1, lwd=2, col="blue")
lines(Dim2 ~ Dim1, data=coords, subset=factor=="Sex",  lty=1, lwd=2, col="red")
lines(Dim2 ~ Dim1, data=coords, subset=factor=="Age",  lty=1, lwd=2, col="brown")
lines(Dim2 ~ Dim1, data=coords, subset=factor=="Survived",  lty=1, lwd=2, col="black")

legend("topleft", legend=c("Class", "Sex", "Age", "Survived"), 
	title="Factor", title.col="black",
	col=cols, text.col=cols, pch=16:19, 
	bg="gray95", cex=1.2)
par(op)


# compare with MASS::mca

library(MASS)
titanic.mca2 <- mca(titanic.df)
# scores
titanic.mca2$cs
plot(titanic.mca2, rows=FALSE, col=rep(cols, nlev), cex=1.2)

