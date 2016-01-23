# Exercise 6.8

dim <- c(3, 2, 2, 2)
factors <- expand.grid(Pet=c("dog","cat","bird"), 
                      Age=c("young","old"), 
                      Color=c("black", "white"), 
                      Sex=c("male", "female"))

means <-
with(factors, {
       20 + 
       ifelse(Pet=="dog", 10, 0) +
       ifelse((Pet=="dog" & Color=="black"), 10, -10) +
       ifelse((Age=="young" & Sex=="male"), 5, -5)                 
       })

                 
set.seed(1234)
tab <- array(rpois(prod(dim), means), dim=dim)
dimnames(tab) <- list(Pet=c("dog","cat","bird"), 
                      Age=c("young","old"), 
                      Color=c("black", "white"), 
                      Sex=c("male", "female"))

# stack 
as.matrix(ftable(Pet + Age ~ Color + Sex, tab))

library(ca)
pets.ca <- ca(as.matrix(ftable(Pet + Age ~ Color + Sex, tab)))
plot(pets.ca, lines=TRUE)

pets.mca <- mca(tab)
plot(pets.mca)



