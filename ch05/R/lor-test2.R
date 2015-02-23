library(vcd)

#' ## loddsratio:  problems with 0 cells 
data(Titanic)

#' which cells are zero?
structable(Titanic==0)

#' should print a Warning:   8 of 32 cells have zero frequency. Use the correct argument to deal with these.
sum(Titanic==0); prod(dim(Titanic))

# reverse Survived, so odds are for survival
# (don't know how to do this using ref=)
titan <- Titanic[,,,2:1]

titanic.lor2 <- loddsratio(~Survived + Sex | Class + Age, data=Titanic[,,,2:1])
as.data.frame(titanic.lor2)
titanic.lor2 <- loddsratio(~Survived + Sex | Class + Age, data=Titanic, ref=c(2,1))
as.data.frame(titanic.lor2)
titanic.lor2 <- loddsratio(~Survived + Sex | Class + Age, data=Titanic, ref=c(1,2))
as.data.frame(titanic.lor2)
titanic.lor2 <- loddsratio(~Survived + Sex | Class + Age, data=Titanic, ref=c(1,1))
as.data.frame(titanic.lor2)
 

#' using correct=TRUE adds 0.5 to all cells
titanic.lor2 <- loddsratio(~Survived + Sex | Class + Age, data=titan)
as.data.frame(titanic.lor2)

#' using correct=FALSE.  More than  1 zero -> NaN
titanic.lor2a <- loddsratio(~Survived + Sex | Class + Age, data=titan, correct=FALSE)
as.data.frame(titanic.lor2a)

#' using correct=0.01
titanic.lor2b <- loddsratio(~Survived + Sex | Class + Age, data=titan + 0.01)
as.data.frame(titanic.lor2b)

 
#' try adding only to structural zero cells
add <- array(0, dim=dim(Titanic), dimnames=dimnames(Titanic))
add["Crew",,"Child",] <- 0.5
titanic.lor2d <- loddsratio(~Survived + Sex | Class + Age, data=titan + add)
as.data.frame(titanic.lor2d)



#' ## linear models for log odds

titanic.lor.df <- as.data.frame(titanic.lor2)
titanic.lor.lm <- lm(LOR ~ Class + Age, data=titanic.lor.df, weights = 1/ASE^2)
anova(titanic.lor.lm)

# the correct approach here is to use GLS, with Sinv = solve(vcov()) as the weight matrix





