#Number of men aged 15-19 charged with a criminal case for whom charges were dropped: Denmark, 1955-1958. 
#This two-way table is used by Goodman (1991) to illustrate a log-multiplicative row-column model with one dimension. 
#It was used before by Rasch (1966), Christiansen and Stene (1969), and Andersen (1986, 1990).


data("criminal", package="logmult")

library(MASS)
loglm(~Year + Age, data=criminal)

# note the difference
mosaic(criminal, shade=TRUE)
mosaic(criminal, gp=shading_Friendly)

library(ca)
crim.ca <- ca(criminal)
crim.ca

plot(crim.ca)

library(logmult)
crim.rc1 <- rc(criminal, se="jackknife", verbose=FALSE)
crim.rc2 <- rc(criminal, nd=2, se="jackknife", verbose=FALSE)

plot(crim.rc2, cex=1.5)




