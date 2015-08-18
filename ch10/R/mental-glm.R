## Mental health data
library(gnm)
library(vcdExtra)
data("Mental", package="vcdExtra")

# display the frequency table
(Mental.tab <- xtabs(Freq ~ mental+ses, data=Mental))
#local odds ratios
loddsratio(Mental.tab)
# compare with coef for Rscore:Cscore below
mean(loddsratio(Mental.tab)$coefficients)

M <- as.matrix(loddsratio(Mental.tab))
library(corrplot)
corrplot(M, method="square", is.corr=FALSE)
corrplot(M, method="square", is.corr=FALSE, tl.col="black", tl.srt=0, tl.offset=1)

dev.copy2pdf(file="mental-lorplot.pdf")

# fit independence model
# Residual deviance: 47.418 on 15 degrees of freedom
indep <- glm(Freq ~ mental+ses,
                family = poisson, data = Mental)
vcdExtra::LRstats(indep)

long.labels <- list(set_varnames = c(mental="Mental Health Status", ses="Parent SES"))
mosaic(indep,residuals_type="rstandard", labeling_args = long.labels, labeling=labeling_residuals,
       main="Mental health data: Independence")

long.labels <- list(set_varnames = c(mental="Mental Health Status", 
                                     ses="Parent SES"))
mosaic(indep, 
       gp=shading_Friendly,
       residuals_type="rstandard", 
       labeling_args = long.labels, 
       labeling=labeling_residuals, suppress=1,
       main="Mental health data: Independence")

# as a sieve diagram
#mosaic(indep, labeling_args = long.labels, panel=sieve, gp=shading_Friendly,
#       main="Mental health data: Independence")
 
# fit linear x linear (uniform) association.  Use integer scores for rows/cols 
Cscore <- as.numeric(Mental$ses)
Rscore <- as.numeric(Mental$mental)

# column effects model (ses)
coleff <- glm(Freq ~ mental + ses + Rscore:ses,
                family = poisson, data = Mental)
mosaic(coleff,residuals_type="rstandard", 
 labeling_args = long.labels, labeling=labeling_residuals, suppress=1, gp=shading_Friendly,
 legend=FALSE,
 main="Mental health data: Col effects (ses)")

# row effects model (mental)
roweff <- glm(Freq ~ mental + ses + mental:Cscore,
                family = poisson, data = Mental)
mosaic(roweff,residuals_type="rstandard", 
 labeling_args = long.labels, labeling=labeling_residuals, suppress=1, gp=shading_Friendly,
 legend=FALSE,
 main="Mental health data: Row effects (mental)")
               
linlin <- glm(Freq ~ mental + ses + Rscore:Cscore,
                family = poisson, data = Mental)

# compare models
#anova(indep, linlin, roweff, coleff)
#AIC(indep, roweff, coleff, linlin)

vcdExtra::LRstats(glmlist(indep, linlin, roweff, coleff))
anova(indep, linlin, roweff, test="Chisq")
anova(indep, linlin, coleff, test="Chisq")
             
mosaic(linlin,residuals_type="rstandard", 
 labeling_args = long.labels, labeling=labeling_residuals, suppress=1, gp=shading_Friendly,
 legend=FALSE,
 main="Mental health data: Linear x Linear")

# interpret linlin association parameter
coef(linlin)[["Rscore:Cscore"]]
exp(coef(linlin)[["Rscore:Cscore"]])


#######################################################

        