# diagnostic plots for berkeley data
library(car)

# using glm()
berkeley <- as.data.frame(UCBAdmissions)
cellID <- paste(berkeley$Dept, substr(berkeley$Gender,1,1), '-', 
                substr(berkeley$Admit,1,3), sep="")
rownames(berkeley) <- cellID

berk.mod <- glm(Freq ~ Dept * (Gender+Admit), data=berkeley, family="poisson")
summary(berk.mod)

influencePlot(berk.mod, labels=cellID, id.n=3)

plot(berk.mod)

