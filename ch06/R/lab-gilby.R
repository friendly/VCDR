#' ---
#' title: "Gilby data, Exercise 6.6"
#' author: "Michael Friendly"
#' date: "31 Jan 2016"
#' ---
data("Gilby", package="vcdExtra")

gilby.ca <- ca(Gilby)
summary(gilby.ca, rows=FALSE, columns=FALSE)
plot(gilby.ca, lines=TRUE)

