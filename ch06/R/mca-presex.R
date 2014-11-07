library(vcdExtra)
data("PreSex", package="vcd")
PreSex <- aperm(PreSex, 4:1)   # order variables G, P, E, M

library(ca)
# abbreviate level names?
#dimnames(PreSex) <-
#list(Gender = c("Women", "Men"), 
#     Pre = c("Yes", "No"), 
#     Extra = c("Yes", "No"), 
#     Marital = c("Divorced", "Married")) 

presex.df <- expand.dft(as.data.frame(PreSex))

#presex.mca <- mjca(presex.df, ps=':')
#summary(presex.mca)
## why is this nearly 1-D?
#plot(presex.mca)

#presex.mca <- mjca(presex.df, ps=':', lambda="indicator")
presex.mca <- mjca(presex.df, ps=':', lambda="Burt")
summary(presex.mca)
plot(presex.mca)

# plot, but don't use point labels or points
res <- plot(presex.mca, labels=0, pch='.', cex.lab=1.2)

# extract factor names and levels
coords <- data.frame(res$cols)
faclevs <- strsplit(rownames(coords), ':')
coords$factor <- sapply(faclevs, function(x) x[1])
coords$levels <- sapply(faclevs, function(x) x[2])
coords

cols <- c("blue", "red", "brown", "black")
nlev <- c(2,2,2,2)
points(coords[,1:2], pch=rep(16:19, nlev), col=rep(cols, nlev), cex=1.2)
text(coords[,1:2], coords$levels, col=rep(cols, nlev), pos=3, cex=1.2, xpd=TRUE)

lines(Dim2 ~ Dim1, data=coords, subset=factor=="Gender", lty=1, lwd=2, col="blue")
lines(Dim2 ~ Dim1, data=coords, subset=factor=="PremaritalSex",  lty=1, lwd=2, col="red")
lines(Dim2 ~ Dim1, data=coords, subset=factor=="ExtramaritalSex",  lty=1, lwd=2, col="brown")
lines(Dim2 ~ Dim1, data=coords, subset=factor=="MaritalStatus",  lty=1, lwd=3, col="black")

legend("bottomright", legend=c("Gender", "PreSex", "ExtraSex", "Marital"), 
	title="Factor", title.col="black",
	col=cols, text.col=cols, pch=16:19, 
	bg="gray95", cex=1.2)

# same, now using factors returned by mjca v. 0.56

res <- plot(presex.mca, labels=0, pch='.', cex.lab=1.2)
coords <- data.frame(res$cols, presex.mca$factors)
cols <- c("blue", "red", "brown", "black")
nlev <- presex.mca$levels.n
points(coords[,1:2], pch=rep(16:19, nlev), col=rep(cols, nlev), cex=1.2)
text(coords[,1:2], labels=coords$level, col=rep(cols, nlev), pos=3, cex=1.2, xpd=TRUE)
lines(Dim2 ~ Dim1, data=coords, subset=factor=="Gender", lty=1, lwd=2, col="blue")
lines(Dim2 ~ Dim1, data=coords, subset=factor=="PremaritalSex",  lty=1, lwd=2, col="red")
lines(Dim2 ~ Dim1, data=coords, subset=factor=="ExtramaritalSex",  lty=1, lwd=2, col="brown")
lines(Dim2 ~ Dim1, data=coords, subset=factor=="MaritalStatus",  lty=1, lwd=3, col="black")

legend("bottomright", legend=c("Gender", "PreSex", "ExtraSex", "Marital"), 
	title="Factor", title.col="black",
	col=cols, text.col=cols, pch=16:19, 
	bg="gray95", cex=1.2)

# compare with mosaic matrix

pairs(PreSex, gp=shading_Friendly)
