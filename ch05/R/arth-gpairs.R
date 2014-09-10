library(gpairs)
data("Arthritis", package="vcd")
gpairs(Arthritis[,c(5,2,3,4)], 
       diag.pars=list(fontsize = 16), 
       mosaic.pars=list(shade=TRUE))   # no effect, because residuals are all < 2

# test extension of gpairs, allowing gp and gp_args to be passed

gpairs(Arthritis[,c(5,2,3,4)], 
       diag.pars=list(fontsize = 16), 
       mosaic.pars=list(gp=shading_Friendly))

gpairs(Arthritis[,c(5,2,3,4)], 
       diag.pars=list(fontsize = 16), 
       mosaic.pars=list(gp = gpar(fill = "yellow")))

gpairs(Arthritis[,c(5,2,3,4)], 
       diag.pars=list(fontsize = 20), 
       mosaic.pars=list(gp=shading_Friendly, gp_args=list(interpolate=1:4)))


# do the same with a vcd::pairs plot, with age cut(,3)
art.tab <- xtabs( ~ Improved + Treatment + Sex + cut(Age,3), data=Arthritis)

pairs(art.tab, shade=TRUE, space=0.2)  # no shading appears
pairs(art.tab, shade=TRUE, gp_args=list(interpolate=1:4), space=0.2)

