library(vcdExtra)
library(ca)

data(Titanic)

titanic.df <- expand.dft(as.data.frame(Titanic))

titanic.mca <- mjca(titanic.df, ps=':')
summary(titanic.mca)

plot(titanic.mca)

# plot, but don't use point labels or points
res <- plot(titanic.mca, labels=0, pch='.', xpd=TRUE)

# extract factor names and levels
coords <- data.frame(res$cols)
faclevs <- strsplit(rownames(coords), ':')
coords$factor <- sapply(faclevs, function(x) x[1])
coords$levels <- sapply(faclevs, function(x) x[2])
coords

cols <- c("blue", "red", "brown", "black")
nlev <- c(4,2,2,2)
points(coords[,1:2], pch=rep(16:19, nlev), col=rep(cols, nlev), cex=1.2)
text(coords[,1:2], coords$levels, col=rep(cols, nlev), pos=3)

coords <- coords[ order(coords[,"factor"], coords[,"Dim1"]), ]

lines(Dim2 ~ Dim1, data=coords, subset=factor=="Class", lty=1, lwd=2, col="blue")
lines(Dim2 ~ Dim1, data=coords, subset=factor=="Sex",  lty=1, lwd=2, col="red")
lines(Dim2 ~ Dim1, data=coords, subset=factor=="Age",  lty=1, lwd=2, col="brown")
lines(Dim2 ~ Dim1, data=coords, subset=factor=="Survived",  lty=1, lwd=2, col="black")
