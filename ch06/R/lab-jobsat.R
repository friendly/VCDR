data("JobSat", package="vcdExtra")
library(ca)
jobsat.ca <- ca(JobSat)
# just show the scree plot
summary(jobsat.ca, rows=FALSE, columns=FALSE)
# show details
jobsat.ca

# unadorned, basic CA plot
plot(jobsat.ca)

# plot with lines
res <- plot(jobsat.ca)
# add lines
lines(res$rows, col="blue")
lines(res$cols, col="red")


