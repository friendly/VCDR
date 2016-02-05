#' ---
#' title: "PreSex data, Exercise 6.10"
#' author: "Michael Friendly"
#' date: "05 Feb 2016"
#' ---


# stacking approach
presexS<- as.matrix(structable(PremaritalSex + ExtramaritalSex ~ Gender + Marital, PreSex), sep=":")
presexS

presexS.ca <- ca(presexS)
summary(presexS.ca)

# why don't these give the plotted points?
coords <- cacoord(presexS.ca)
coords

res <- plot(presexS.ca)

# join pairs of column points
lines(res$cols[1:2,], col="red")
lines(res$cols[3:4,], col="red")
lines(res$cols[c(1,3),], col="red")
lines(res$cols[c(2,4),], col="red")

# join pairs of row points -- can't easily show both
lines(res$rows[1:2,], col="blue")
lines(res$rows[3:4,], col="blue")
lines(res$rows[c(1,3),], col="blue")
lines(res$rows[c(2,4),], col="blue")

