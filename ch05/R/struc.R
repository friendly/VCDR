# \S 5.7
# originally from mosfit.sas, after Lauder & Theus, Fig 7

struc <- array(c(6, 10, 312, 44, 
                 37, 31, 192, 76),
 dim = c(2,2,2),
 dimnames = list(Age=c("Young", "Old"), 
                 Sex=c("F", "M"), 
                 Disease=c("No", "Yes"))
 )
struc <- as.table(struc)
structable(Sex+Age ~ Disease, struc)

mosaic(struc, shade=TRUE)
#mosaic(struc, gp=shading_Friendly)

# mutual independence
#mosaic(struc, type="expected")
mosaic(struc, type="expected", shade=TRUE, legend=FALSE)



mosaic3d(struc)
mosaic3d(struc, type="expected")

mutual <- loglm(~Age+Sex+Disease, data=struc, fitted=TRUE)
#pairs(as.table(fitted(mutual)), shade=TRUE)
fit <- as.table(fitted(mutual))
structable(Sex+Age ~ Disease, fit)

#pairs(fit, gp=shading_Friendly)
pairs(fit, gp=shading_Friendly, type="total")

mosaic3d(fit)
par3d(zoom=0.8)
# save userMatrix to reproduce the figure
#  dput(par3d()$userMatrix)
M <- 
structure(c(0.903479218482971, 0.105322740972042, -0.415490537881851, 
0, -0.428631067276001, 0.223846390843391, -0.875310361385345, 
0, 0.000815971114207059, 0.968916893005371, 0.247385174036026, 
0, 0, 0, 0, 1), .Dim = c(4L, 4L))

snapshot3d("struct-mos3d1.png")

# conditional independence
mosaic(struc, type="expected", expected= ~Age*Disease+Sex*Disease) 

pairs(struc, shade=TRUE)

# joint independence
mosaic(struc, type="expected", expected= ~Age*Sex+Disease) 

joint <- loglm(~Age*Sex+Disease, data=struc, fitted=TRUE)
fit <- as.table(fitted(joint))
structable(Sex+Age ~ Disease, fit)

#pairs(fit, shade=TRUE)
pairs(fit, gp=shading_Friendly)
#pairs(fit, gp=shading_Friendly, type="joint")

# conditional independence
mosaic(struc, type="expected", expected= ~Age*Disease+Sex*Disease) 

condit <- loglm(~Age*Disease+Sex*Disease, data=struc, fitted=TRUE)
pairs(as.table(fitted(condit)), gp=shading_Friendly)
pairs(as.table(fitted(condit)), gp=shading_Friendly, type="conditional")






  
