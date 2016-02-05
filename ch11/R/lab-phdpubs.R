#' ---
#' title: "PhdPubs data, Exercise 11.7"
#' author: "Michael Friendly"
#' date: "05 Feb 2016"
#' ---


data("PhdPubs", package="vcdExtra")

library(MASS)
phd.nbin  <- glm.nb(articles ~ ., data=PhdPubs)
