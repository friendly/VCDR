
# \S 4.2
Berkeley <- margin.table(UCBAdmissions, 2:1)
library(gmodels)
CrossTable(Berkeley, prop.chisq=FALSE, prop.c=FALSE, format="SPSS")

oddsratio(Berkeley, log=FALSE)
summary(oddsratio(Berkeley))


# \S 4.4

fourfold(Berkeley, std="ind.max")   # unstandardized
fourfold(Berkeley, margin=1) # equating gender
fourfold(Berkeley, margin=2) # equating admit
fourfold(Berkeley)  # standardized: both

# 2 x 2 x k tables

## UC Berkeley Student Admissions
mantelhaen.test(UCBAdmissions)

oddsratio(UCBAdmissions, log=FALSE)
lor <- oddsratio(UCBAdmissions)  # capture log odds ratios
summary(lor)

# Woolf test of homogeneity of odds ratios
woolf_test(UCBAdmissions) 

# fourfold display
col <- c("#99CCFF", "#6699CC", "#F9AFAF", "#6666A0", "#FF0000", "#000080")
UCB <- aperm(UCBAdmissions, c(2, 1, 3)
fourfold(UCB,mfrow=c(2,3), color=col)
