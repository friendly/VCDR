library(vcd)
Kappa(MSPatients[,,1])
Kappa(MSPatients[,,2])
confint(Kappa(MSPatients[,,1]))
confint(Kappa(MSPatients[,,2]))

agreementplot(t(MSPatients[,,1]), main = "Winnipeg Patients")
agreementplot(t(MSPatients[,,2]), main = "New Orleans Patients")
