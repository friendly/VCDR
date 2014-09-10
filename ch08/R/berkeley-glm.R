library(vcdExtra)
library(MASS)
data("UCBAdmissions")

structable(Dept ~ Admit+Gender,UCBAdmissions)

berk.loglm0 <- loglm(~ Admit + Dept + Gender, data=UCBAdmissions, param=TRUE, fitted=TRUE)
berk.loglm0

names(berk.loglm0)
# show parameters
coef(berk.loglm0)

# fitted frequencies
structable(Dept ~ Admit+Gender, fitted(berk.loglm0))

# residuals
structable(Dept ~ Admit+Gender, residuals(berk.loglm0))

## conditional independence in UCB admissions data
berk.loglm1 <- loglm(~ Dept * (Gender + Admit), data=UCBAdmissions)
berk.loglm1
#mosaic(berk.loglm1, gp=shading_Friendly)

coef(berk.loglm1)


## all two-way model
berk.loglm2 <-loglm(~(Admit+Dept+Gender)^2, data=UCBAdmissions)
berk.loglm2
mosaic(berk.loglm2, gp=shading_Friendly)

# compare models
anova(berk.loglm0, berk.loglm1, berk.loglm2, test="Chisq")


##################
# same, using glm() -- need to transform the data to a data.frame

berkeley <- as.data.frame(UCBAdmissions)
head(berkeley)

berk.glm1 <- glm(Freq ~ Dept * (Gender+Admit), data=berkeley, family="poisson")
summary(berk.glm1)
mosaic(berk.glm1, gp=shading_Friendly, labeling=labeling_residuals, formula=~Admit+Dept+Gender)

# test terms, using Type I tests
anova(berk.glm1, test="Chisq")
# type II tests
library(car)
Anova(berk.glm1, test="LR")



# the same, displaying studentized residuals note use of formula to reorder factors in the mosaic
mosaic(berk.glm1, shade=TRUE, formula=~Admit+Dept+Gender, 
       residuals_type="rstandard", labeling=labeling_residuals, 
       main="Model: [AdmitDept][GenderDept]")

## all two-way model
berk.glm2 <- glm(Freq ~ (Dept + Gender + Admit)^2, data=berkeley, family="poisson")
summary(berk.glm2)
mosaic.glm(berk.glm2, residuals_type="rstandard", labeling = labeling_residuals, shade=TRUE,
	formula=~Admit+Dept+Gender, main="Model: [DeptGender][DeptAdmit][AdmitGender]")
anova(berk.glm1, berk.glm2, test="Chisq")

# Add 1 df term for association of [GenderAdmit] only in Dept A
berkeley <- within(berkeley, dept1AG <- (Dept=='A')*(Gender=='Female')*(Admit=='Admitted'))
head(berkeley)

berk.glm3 <- glm(Freq ~ Dept * (Gender+Admit) + dept1AG, data=berkeley, family="poisson")

summarise(glmlist(berk.glm1, berk.glm2, berk.glm3))
anova(berk.glm1, berk.glm3, test="Chisq")

# interpret coefficient
coef(berk.glm3)[["dept1AG"]]
exp(coef(berk.glm3)[["dept1AG"]])


#summary(berk.glm3)
mosaic.glm(berk.glm3, residuals_type="rstandard", labeling = labeling_residuals, shade=TRUE,
	formula=~Admit+Dept+Gender, main="Model: [DeptGender][DeptAdmit] + DeptA*[GA]")




