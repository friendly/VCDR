
library(vcdExtra)
library(ca)

haireye <- margin.table(HairEyeColor, 1:2)

haireye.df <- expand.dft(as.data.frame(haireye))

haireye.mca <- mjca(haireye.df, ps=':')
summary(haireye.mca)

# plot, but don't use point labels or points
res <- plot(haireye.mca, labels=0, pch='.')

# extract factor names and levels
coords <- data.frame(res$cols)
faclevs <- strsplit(rownames(coords), ':')
coords$factor <- sapply(faclevs, function(x) x[1])
coords$levels <- sapply(faclevs, function(x) x[2])
coords

points(coords[,1:2], pch=rep(16:17, each=4), col=rep(c("blue", "red"), each=4), cex=1.2)

# simplify point labels, for display purposes
#rownames(coords) <- gsub("Hair|Eye", "", rownames(coords))
text(coords[,1:2], coords$levels, col=rep(c("blue", "red"), each=4), pos=3)

# sort by Dim1 within factors; ideally, we should leave the factor unsorted

coords <- coords[ order(coords[,"factor"], coords[,"Dim1"]), ]

lines(Dim2 ~ Dim1, data=coords, subset=factor=="Hair", lty=1, col="blue", lwd=2)
lines(Dim2 ~ Dim1, data=coords, subset=factor=="Eye",  lty=4, col="red", lwd=2)

#coords[1:4,] <- coords[order(coords[1:4,1]),] 
#coords[5:8,] <- coords[4+order(coords[5:8,1]),]
#
#lines(coords[1:4,], lty=1, col="blue")
#lines(coords[5:8,], lty=4, col="red")

# 3-way table
HEC.df <- expand.dft(as.data.frame(HairEyeColor))
HEC.mca <- mjca(HEC.df, ps=':' )
summary(HEC.mca)

res <- plot(HEC.mca, labels=0, pch='.')
coords <- data.frame(res$cols)
faclevs <- strsplit(rownames(coords), ':')
coords$factor <- sapply(faclevs, function(x) x[1])
coords$levels <- sapply(faclevs, function(x) x[2])
coords

cols <- c("blue", "red", "brown")
nlev <- c(4,4,2)
points(coords[,1:2], pch=rep(16:18, c(4,4,2)), col=rep(cols, c(4,4,2)), cex=1.2)
text(coords[,1:2], coords$levels, col=rep(cols, c(4,4,2)), pos=3)

coords <- coords[ order(coords[,"factor"], coords[,"Dim1"]), ]
lines(Dim2 ~ Dim1, data=coords, subset=factor=="Hair", lty=1, col="blue")
lines(Dim2 ~ Dim1, data=coords, subset=factor=="Eye",  lty=4, col="red")
lines(Dim2 ~ Dim1, data=coords, subset=factor=="Sex",  lty=2, col="brown")


