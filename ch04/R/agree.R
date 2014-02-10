# Observer agreement

data("SexualFun", pkg="vcd")

data("MSPatients", pkg="vcd")


(kappa <- Kappa(SexualFun))
confint(kappa)

library(MASS)
fractions(kappa$Weights)

# agreement charts
agreementplot(SexualFun, weights=1)  # unweighted
agreementplot(SexualFun)             # 1-step weights

agr <-agreementplot(SexualFun)
unlist(agr)

op <- par(mar=c(4,3,4,1)+.1)
agreementplot(MSPatients[,,"Winnipeg"], main="Winnipeg patients")
agreementplot(MSPatients[,,"New Orleans"], main="New Orleans patients")
par(op)

# agreement measures

agr1 <- agreementplot(MSPatients[,,"Winnipeg"])
agr2 <- agreementplot(MSPatients[,,"New Orleans"])
rbind(Winnipeg=unlist(agr1), NewOrleans=unlist(agr2))[,1:2]



# produce these figs separately -- they are deformed in knitr [Fixed this above]

op <- par(mar=c(4,3,4,1)+.1)
pdf(file="MSagree1.pdf", height=6, width=6)
agreementplot(MSPatients[,,"Winnipeg"], main="Winnipeg patients")
dev.off()

pdf(file="MSagree2.pdf", height=6, width=6)
agreementplot(MSPatients[,,"New Orleans"], main="New Orleans patients")
dev.off()
par(op)
