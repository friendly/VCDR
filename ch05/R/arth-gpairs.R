library(gpairs)
data("Arthritis", package="vcd")
gpairs(Arthritis[,c(5,2,3,4)], 
       diag.pars=list(fontsize = 16), 
       mosaic.pars=list(shade=TRUE))

# do the same with a vcd::pairs plot, with age cut(,3)
art.tab <- xtabs( ~ Improved + Treatment + Sex + cut(Age,3), data=Arthritis)

pairs(art.tab, shade=TRUE, space=0.2)  # no shading appears
pairs(art.tab, shade=TRUE, gp_args=list(interpolate=1:4), space=0.2)

