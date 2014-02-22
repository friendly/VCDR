data("Bartlett", package="vcdExtra")
pairs(Bartlett, gp=shading_Friendly)



data("PreSex", package="vcd")
#pairs(PreSex, shade=TRUE)
pairs(PreSex, gp=shading_Friendly, gp_args=list(interpolate=1:4))
pairs(PreSex, shade=TRUE, gp_args=list(interpolate=1:4), space=0.25)

# how to control the fontsize of the variable label?

pairs(UCBAdmissions, shade = TRUE, space=0.25)

#pairs(UCBAdmissions, shade = TRUE, space=0.25,
#	lower_panel_args=list(alternate_labels = TRUE))

	
pairs(UCBAdmissions, lower_panel = pairs_mosaic(type = "total", shade=TRUE), shade=TRUE)
pairs(UCBAdmissions, lower_panel = pairs_mosaic(type = "total", shade=TRUE), shade=TRUE, space=0.2)

# now works, with vcd rev 748
pairs(UCBAdmissions, lower_panel = pairs_mosaic(type = "conditional", shade=TRUE), 
                     upper_panel = pairs_mosaic(type = "conditional", shade=TRUE),
                     space=0.2)

pairs(UCBAdmissions, lower_panel = pairs_mosaic(type = "conditional", gp=shading_Friendly, gp_args=list(interpolate=1:4)), 
                     upper_panel = pairs_mosaic(type = "conditional", gp=shading_Friendly, gp_args=list(interpolate=1:4)),
#                     shade=TRUE, gp_args=list(interpolate=1:4),
										 gp=shading_Friendly,
                     space=0.2)

pairs(UCBAdmissions, lower_panel = pairs_mosaic(type = "joint", shade=TRUE), 
                     upper_panel = pairs_mosaic(type = "total", shade=TRUE),
                     space=0.2)



data(HairEyeColor)
hec = structable(Eye ~ Sex + Hair, data = HairEyeColor)
pairs(hec, highlighting = 2, diag_panel_args = list(fill = grey.colors))
pairs(hec, highlighting = 2, diag_panel = pairs_diagonal_mosaic,
           diag_panel_args = list(fill = grey.colors, alternate_labels =TRUE))


library(gpairs)
data("Arthritis", package="vcd")
#gpairs(Arthritis[,-1], diag.pars=list(fontsize = 14), mosaic.pars=list(shade=TRUE))

gpairs(Arthritis[,c(5,2,3,4)], diag.pars=list(fontsize = 16), mosaic.pars=list(shade=TRUE))

# do the same with a vcd::pairs plot, with age cut(,3)
art.tab <- xtabs( ~ Improved + Treatment + Sex + cut(Age,3), data=Arthritis)

pairs(art.tab, shade=TRUE, space=0.2)
pairs(art.tab, shade=TRUE, gp_args=list(interpolate=1:4), space=0.2)

gpairs(Arthritis[,c(5,2,3,4)], 
   diag.pars=list(fontsize = 16), 
   mosaic.pars=list(shade=TRUE),
   gp_args=list(interpolate=1:4))
