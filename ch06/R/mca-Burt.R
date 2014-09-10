library(ca)
# mca - indicator matrix, Burt matrix
haireye <- margin.table(HairEyeColor, 1:2)

haireye.df <- as.data.frame(haireye)
dummy.hair <-  0+outer(haireye.df$Hair, levels(haireye.df$Hair), `==`)
colnames(dummy.hair)  <- paste0('h', 1:4)
dummy.eye <-  0+outer(haireye.df$Eye, levels(haireye.df$Eye), `==`)
colnames(dummy.eye)  <- paste0('e', 1:4)

haireye.df <- data.frame(haireye.df, dummy.hair, dummy.eye)
haireye.df

ca(haireye)



# simple CA of indicator matrix
Z <- expand.dft(haireye.df)[,-(1:2)]
vnames <- c(levels(haireye.df$Hair), levels(haireye.df$Eye))
colnames(Z) <- vnames

N <- t(as.matrix(Z[,1:4])) %*% as.matrix(Z[,5:8])


# same result as simple CA of Burt matrix
Z.ca <- ca(Z)
# basic plot
res <- plot(Z.ca, what=c("none", "all"))

# customized plot
res <- plot(Z.ca, what=c("none", "all"), labels=0, pch='.', xpd=TRUE)

# extract factor names and levels
coords <- data.frame(res$cols)
coords$factor <- rep(c("Hair", "Eye"), each=4)
coords$levels <- rownames(res$cols)
coords
# sort by Dim 1
coords <- coords[ order(coords[,"factor"], coords[,"Dim1"]), ]

cols <- c("blue", "red")
nlev <- c(4,4)
text(coords[,1:2], coords$levels, col=rep(cols, nlev), pos=2, cex=1.2)
points(coords[,1:2], pch=rep(16:17, nlev), col=rep(cols, nlev), cex=1.2)

lines(Dim2 ~ Dim1, data=coords, subset=factor=="Eye",  lty=1, lwd=2, col=cols[1])
lines(Dim2 ~ Dim1, data=coords, subset=factor=="Hair", lty=1, lwd=2, col=cols[2])

Burt <- t(as.matrix(Z)) %*% as.matrix(Z)
rownames(Burt) <-  colnames(Burt) <- vnames
Burt

# Burt matrix, frequency form
Z <- as.matrix(haireye.df[,-(1:3)])
F <- haireye.df$Freq
Burt <- t(Z) %*% diag(F) %*% Z
rownames(Burt) <-  colnames(Burt) <- vnames

# simple CA of Burt matrix

Burt.ca <- ca(Burt)
plot(Burt.ca)



mjca(Burt)


HE <- expand.dft(haireye.df)
# same as analysis of Burt matrix
mjca(HE[,1:2], lambda="Burt")

mjca(HE[,1:2], lambda="indicator")

