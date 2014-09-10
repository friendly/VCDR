row <- gl(4, 4, 16)
col <- gl(4, 1, 16)
diag4by4 <- Diag(row, col)
dmat <- matrix(Diag(row, col), 4, 4)
#matrix(as.numeric(diag4by4), 4, 4)

symm4by4 <- Symm(row, col)
smat <- matrix(symm4by4, 4, 4)
#matrix(as.numeric(symm4by4), 4, 4)

levelMat <- matrix(
  c(2, 3, 4, 4,
    3, 3, 4, 4,
    4, 4, 5, 5,
    4, 4, 5, 1), 4, 4)

topo4by4 <- Topo(row, col, spec=levelMat)
tmat <- matrix(topo4by4, 4, 4)

cros4by4 <- Crossings(row, col)
cmat <- matrix(cros4by4, 4, 4)
cmat



library(xtable)

dmat <- matrix(Diag(row, col), 4, 4)
print(xtable(dmat, quote=FALSE), floating=FALSE, include.rownames=FALSE, include.colnames=FALSE)

print(xtable(smat, quote=FALSE), floating=FALSE, include.rownames=FALSE, include.colnames=FALSE)
print(xtable(tmat, quote=FALSE), floating=FALSE, include.rownames=FALSE, include.colnames=FALSE)
