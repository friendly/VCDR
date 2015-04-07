library(vcdExtra)
library(gnm)
data("VisualAcuity", package="vcd")
women <- subset(VisualAcuity, gender=="female", select=-gender)

indep <- glm(Freq ~ right + left,  data = women, family=poisson)

labs <- c("High", "2", "3", "Low")
largs <- list(set_varnames = c(right="Right eye grade", left="Left eye grade"),
              set_labels=list(right=labs, left=labs))
mosaic(indep, ~right + left, residuals_type="rstandard", gp=shading_Friendly,
       labeling_args=largs,
       main="Vision data: Independence (women)"  )

#quasi <- glm(Freq ~ right + left + Diag(right, left),
#       data = women, family = poisson)
quasi <- update(indep, . ~ . + Diag(right, left))
mosaic(quasi, ~right + left, residuals_type="rstandard", gp=shading_Friendly,
       labeling_args=largs,
       main="Quasi-Independence (women)"  )

symm <- glm(Freq ~ Symm(right, left),
       data = women, family = poisson)
mosaic(symm, ~right + left, residuals_type="rstandard", gp=shading_Friendly,
       labeling_args=largs,
		main="Symmetry model (women)")

qsymm <- glm(Freq ~ right + left + Symm(right, left),
       data = women, family = poisson)
qsymm <- update(symm, . ~ right + left + .)

mosaic(qsymm, ~right + left, residuals_type="rstandard", gp=shading_Friendly,
       labeling_args=largs,
       main="Quasi-Symmetry (women)")

# model comparisons: for *nested* models
anova(indep, quasi, qsymm, test="Chisq")
# test of marginal homogeneity
anova(symm, qsymm, test="Chisq")

# model summaries, with AIC and BIC
models <- glmlist(indep, quasi, symm, qsymm)
vcdExtra::summarise(models)

# LxL & RC don't fit well
linlin <- gnm(Freq ~ right + left + as.numeric(right)*as.numeric(left), data=women, 
family=poisson) 
summarise(linlin)
RC <- gnm(Freq ~ right + left + Mult(right,left), data=women, family=poisson, verbose=FALSE)
summarise(RC)


# 3-way

vis.kway <-Kway(Freq ~ right + left + gender, data=VisualAcuity)
vcdExtra::summarise(vis.kway)


vis.indep <- glm(Freq ~ right + left + gender,  data = VisualAcuity, family=poisson)

vis.2way <- update(vis.indep, . ~ .^2)
summarise(vis.2way)
mosaic(vis.2way, ~ gender + right + left, condvars="gender",
  residuals_type="rstandard", gp=shading_Friendly,
       labeling_args=largs,
       main="All two-way")

# homogeneous quasi-independence and quasi-symmetry
vis.quasi <- update(vis.indep, . ~ . + Diag(right, left))
vis.qsymm <- update(vis.indep, . ~ . + Diag(right, left) + Symm(right, left))

mosaic(vis.qsymm, ~ gender + right + left, condvars="gender",
  residuals_type="rstandard", gp=shading_Friendly,
       labeling_args=largs,
       main="Homogeneous quasi-symmetry")

vis.models <- glmlist(vis.indep, vis.quasi, vis.qsymm)
summarise(vis.models)

vis.hetdiag <- update(vis.indep, . ~ . + gender*Diag(right, left) + Symm(right, left))
summarise(vis.hetdiag)

vis.hetqsymm <- update(vis.indep, . ~ . + gender*Diag(right, left) + gender*Symm(right, left))
summarise(vis.hetqsymm)

vis.hetmodels <- glmlist(vis.qsymm, vis.hetdiag, vis.hetqsymm)
summarise(vis.hetmodels)


mosaic(vis.hetdiag, ~ gender + right + left, condvars="gender",
  residuals_type="rstandard", gp=shading_Friendly,
       labeling_args=largs,
       main="Heterogeneous Diagonals")


mosaic(vis.hetqsymm, ~ gender + right + left, condvars="gender",
  residuals_type="rstandard", gp=shading_Friendly,
       labeling_args=largs,
       main="Heterogeneous quasi-qymmetry")
       

