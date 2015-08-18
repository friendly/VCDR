data("PreSex", package="vcd")
structable(Gender+PremaritalSex+ExtramaritalSex ~ MaritalStatus, PreSex)

#structable(MaritalStatus ~ Gender+PremaritalSex+ExtramaritalSex, PreSex)


## Mosaic display for Gender and Premarital Sexual Experience
## (Gender Pre)
PreSex <- aperm(PreSex, 4:1)   # order variables G, P, E, M
mosaic(margin.table(PreSex, 1:2), shade=TRUE,
                main = "Gender and Premarital Sex")

## (Gender Pre)(Extra)
mosaic(margin.table(PreSex, 1:3), 
       expected = ~Gender * PremaritalSex + ExtramaritalSex ,
	     main = "Gender*Pre + ExtramaritalSex")

## (Gender Pre Extra)(Marital)
mosaic(PreSex,
       expected = ~Gender*PremaritalSex*ExtramaritalSex + MaritalStatus,
       main = "Gender*Pre*Extra + MaritalStatus")

## (GPE)(PEM)
mosaic(PreSex, 
       expected = ~ Gender * PremaritalSex * ExtramaritalSex
                  + MaritalStatus * PremaritalSex * ExtramaritalSex,
       main = "G*P*E + P*E*M")


## Problem: cant use marginals=2:4 here or subset with [2:4]
## because the latter converts back to a list.
mods <- seq_loglm(PreSex, type="joint")
res <- LRstats(mods)
rownames(res) <- c("[G]", "[G][P]", "[GP][E]", "[GPE][M]")
res

try this directly
library(MASS)
mods.GP   <- loglm(~Gender + PremaritalSex, data=margin.table(PreSex, 1:2))
mods.GPE  <- loglm(~Gender * PremaritalSex + ExtramaritalSex, margin.table(PreSex, 1:3))
mods.GPEM <- loglm(~Gender * PremaritalSex * ExtramaritalSex + MaritalStatus, data=PreSex)
mods.mut  <- loglm(~Gender + PremaritalSex + ExtramaritalSex + MaritalStatus, data=PreSex)

mods.list <- loglmlist("[G][P]"=mods.GP, "[GP][E]"=mods.GPE, 
                       "[GPE][M]"=mods.GPEM, "[G][P][E][M]"=mods.mut)
LRstats(mods.list)

GSQ <- sapply(mods.list[1:3], function(x)x$lrt)
dimnames(GSQ) <- dimnames(mods.list)
GSQ
sum(GSQ)


mosaic(mods, 2, main = TRUE)
mosaic(mods, 3, main = TRUE)
mosaic(mods, 4, main = TRUE)

## (GPE)(PEM)
mosaic(PreSex, 
       expected = ~ Gender * PremaritalSex * ExtramaritalSex
                    + MaritalStatus * PremaritalSex * ExtramaritalSex,
       main = "[GPE] + [PEM]")


oddsratio(margin.table(PreSex, 1:3), stratum=1, log=FALSE)