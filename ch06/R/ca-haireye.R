haireye <- margin.table(HairEyeColor, 1:2)

# now require ca_0.54, modified by me
library(ca)

(haireye.ca <- ca(haireye))

# this should be done inside ca(), and similarly for other returned results
#rownames(haireye.ca$rowcoord) <- haireye.ca$rownames
#colnames(haireye.ca$rowcoord) <- paste0('Dim', 1:ncol(haireye.ca$rowcoord))
#rownames(haireye.ca$colcoord) <- haireye.ca$colnames
#colnames(haireye.ca$colcoord) <- paste0('Dim', 1:ncol(haireye.ca$colcoord))

# standard coordinates Phi (Eqn 6.4) and Gamma (Eqn 6.5)
Phi <- haireye.ca$rowcoord
Gamma <- haireye.ca$colcoord

# demonstrate Eqn orthogonality of std coordinates
Dr <- diag(haireye.ca$rowmass)
zapsmall(t(Phi) %*% Dr %*% Phi) 
Dc <- diag(haireye.ca$colmass)
zapsmall(t(Gamma) %*% Dc %*% Gamma) 


# test returning x,y from plot.ca
#source("c:/R/functions/plot.ca.r")
res <- plot(ca(haireye))
lines(res$rows, col="blue")
lines(res$cols[order(res$cols[,1]),], col="red")


op <- par(cex=1.4, mar=c(5,4,2,1)+.1)
plot(haireye.ca)
title(xlab="Dimension 1 (89.4%)", ylab="Dimension 2 (9.5%)")
par(op)

op <- par(cex=1.4, mar=c(5,4,2,1)+.1)
res <- plot(haireye.ca, xlab="Dimension 1 (89.4%)", ylab="Dimension 2 (9.5%)")
par(op)



##########################################################
### try other packages

library(MASS)
hca <- corresp(haireye, nf=2)
#Error in corresp.default(haireye, nf = 2) : invalid table specification
#plot(hca)

hca <- corresp(as.matrix(haireye), nf=2)
#Error in corresp.default(as.matrix(haireye), nf = 2) : 
#  invalid table specification

# this works, but why should it be this hard? 
haireye.xtabs <- xtabs(Freq ~ Hair+Eye, data=as.data.frame(haireye))
corresp(haireye.xtabs, nf=2)
plot(corresp(haireye.xtabs, nf=2))

# this works too
haireye.mat <- apply(HairEyeColor, 1:2, sum)
corresp(haireye.mat, nf=2)

# change class: this works
class(haireye) <- c("table", "matrix")
corresp(haireye, nf=2)



library(FactoMineR)
hca2 <- CA(haireye) # plots automatically
plot(hca2, shadowtext=TRUE, autoLab="yes")

library(ade4)
hca3 <- dudi.coa(haireye, nf=2)
#Error in if (any(df < 0)) stop("negative entries in table") : 
#  missing value where TRUE/FALSE needed

# no plot method;  need to use s.label
s.label(hca3$co)
s.label(hca3$li)



