data("criminal", package = "logmult")
library(ca)

criminal.ca <- ca(criminal)
# just show the scree plot
summary(criminal.ca, rows=FALSE, columns=FALSE)
# show details
criminal.ca

# unadorned, basic CA plot
res <- plot(criminal.ca)
# add lines
lines(res$rows, col="blue")
lines(res$cols, col="red")

