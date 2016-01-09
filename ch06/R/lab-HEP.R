data("HairEyePlace", package="vcdExtra")

HEP <- HairEyePlace
dimnames(HEP)[[3]] <- c("C", "A")
HEP.stacked <- as.matrix(ftable(Eye ~ Hair + Place, data=HairEyePlace))
HEP.stacked

library(ca)
HEP.ca <- ca(HEP.stacked)
summary(HEP.ca, rows=FALSE, columns=FALSE)

plot(HEP.ca)

# mjca requires a table, not an array
HEP.mca <- mjca(as.table(HairEyePlace))
summary(HEP.mca, columns=FALSE)

res <- plot(HEP.mca)
coords <- data.frame(res$cols, HEP.mca$factors)
nlev <- HEP.mca$levels.n
fact <- unique(as.character(coords$factors))



