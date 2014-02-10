data("PreSex", package="vcd")
structable(Gender+PremaritalSex+ExtramaritalSex ~ MaritalStatus, PreSex)

#structable(MaritalStatus ~ Gender+PremaritalSex+ExtramaritalSex, PreSex)


## Mosaic display for Gender and Premarital Sexual Experience
## (Gender Pre)
mosaic(margin.table(PreSex, c(3,4)), 
                main = "Gender and Premarital Sex")

## (Gender Pre)(Extra)
mosaic(margin.table(PreSex, c(2,3,4)), 
       expected = ~Gender * PremaritalSex + ExtramaritalSex ,
	   main = "PreMaritalSex*Gender + ExtramaritalSex")

## (Gender Pre Extra)(Marital)
mosaic(PreSex,
       expected = ~Gender*PremaritalSex*ExtramaritalSex + MaritalStatus,
       main = "PreMarital*ExtraMarital + MaritalStatus")

## (GPE)(PEM)
mosaic(PreSex, 
       expected = ~ Gender * PremaritalSex * ExtramaritalSex
                    + MaritalStatus * PremaritalSex * ExtramaritalSex,
       main = "G*P*E + P*E*M")


presex <- aperm(PreSex, c(4,3,2,1))

## Problem: cant use marginals=2:4 here or subset with [2:4]
## because the latter converts back to a list.
mods <- seq_loglm(presex, type="joint")
res <- summarise(mods)
rownames(res) <- c("[G]", "[G][P]", "[GP][E]", "[GPE][M]")
res

mut <- loglm(~Gender + PremaritalSex + ExtramaritalSex + MaritalStatus, data=presex)



mosaic(mods, 2, main = TRUE)
mosaic(mods, 3, main = TRUE)
mosaic(mods, 4, main = TRUE)

## (GPE)(PEM)
mosaic(presex, 
       expected = ~ Gender * PremaritalSex * ExtramaritalSex
                    + MaritalStatus * PremaritalSex * ExtramaritalSex,
       main = "[GPE] + [PEM]")
