# lab exercise: caith data

data(caith, package="MASS")
Caith <- as.matrix(caith)
dimnames(Caith)
names(dimnames(Caith)) <- c("Eye", "Hair")
loglm(~Hair+Eye,Caith)
residuals(loglm(~Hair+Eye,Caith))
mosaic(Caith, shade=TRUE)

