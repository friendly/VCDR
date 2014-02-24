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

Z <- as.matrix(haireye.df[,-(1:3)])
F <- haireye.df$Freq

Burt <- t(Z) %*% diag(F) %*% Z

ca(haireye)

# simple CA of Burt matrix

rownames(Burt) <-  colnames(Burt) <- c(levels(haireye.df$Hair), levels(haireye.df$Eye))
ca(Burt)
plot(ca(Burt))

# simple CA of indicator matrix
ZF <- expand.dft(haireye.df)[,-(1:2)]
colnames(ZF) <- colnames(Burt)

# same result as simple CA of Burt matrix
Z.ca <- ca(ZF)
plot(Z.ca, what=c("none", "all"))



mjca(Burt)


HE <- expand.dft(haireye.df)
# same as analysis of Burt matrix
mjca(HE[,1:2], lambda="Burt")

mjca(HE[,1:2], lambda="indicator")

