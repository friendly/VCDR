data("Arthritis", package = "vcd")

art <- xtabs(~ Treatment + Improved, data = Arthritis, subset = Sex == "Female")
names(dimnames(art))[2] <- "Improvement"

#myseed <- 1071
#nrep <- 2000
#set.seed(myseed)
#art_max <- coindep_test(art, n = nrep)
#set.seed(myseed)
#art_chisq <- coindep_test(art, n = nrep, indepfun = function(x) sum(x^2))

mosaic(art, gp=shading_Friendly, margin = c(right = 1))
set.seed(1243)
mosaic(art, gp=shading_max, margin = c(right = 1))

# label residuals in cells in plot above

mosaic(art, gp=shading_Friendly, margin = c(right = 1), 
	labeling=labeling_residuals, suppress=0, digits=2)

# residuals
residuals(loglm(~Improvement + Treatment, data=art), type="pearson")


# do the same, for the details, with n=1000
set.seed(1243)
art_max <- coindep_test(art)
art_max
# quantiles for shading levels
art_max$qdist(c(0.90, 0.99))

#mosaic(art, gp=shading_max, margin = c(right = 1), levels=c(0.95, 0.99))

