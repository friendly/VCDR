#' ---
#' title: "Titanic data, Exercise 5.12"
#' author: "Michael Friendly"
#' date: "30 Jan 2016"
#' ---
data("Titanic")

# joint independence
form1 <- loglin2formula(joint(4, factors=names(dimnames(Titanic))))
form1

library(MASS)
mod1 <- loglm(formula=~Class:Sex:Age + Survived, data=Titanic)
mod1
mosaic(Titanic, expected=~Class:Sex:Age + Survived, shade=TRUE)

# "main effects" model: [CGA] [CS] [GS] [AS]
loglm(~Class:Sex:Age + (Class + Sex + Age) * Survived, data=Titanic)
mosaic(Titanic, expected=~Class:Sex:Age + (Class + Sex + Age) * Survived, shade=TRUE)
