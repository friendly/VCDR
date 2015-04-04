#' ---
#' title: "Testing extensions of rootograms to color by residuals"
#' author: "Michael Friendly"
#' date: "04 Apr 2015"
#' ---


#' Phil's suggestion, using ggplot2
library(vcd)
data(Federalist)
Fed_fit <- goodfit(Federalist, type = "poisson")

R <- Fed_fit$observed - Fed_fit$fitted
z <- R / sqrt(Fed_fit1$fitted) 
sR <- -1 * sign(R) * sqrt(abs(R))
plt <- data.frame(count=Fed_fit$count, sR, z, rootfit=sqrt(Fed_fit$fitted))

library(ggplot2)
# roughly equivalent to vcd rootogram
ggplot(plt, aes(count, sR)) + 
    geom_bar(stat='identity', position='identity') + 
    geom_line(aes(y=rootfit), colour='blue') + 
    geom_point(aes(y=rootfit), colour='blue', size=4) +
    xlab('Number of Occurrences') + 
    ylab('sqrt(Frequency)')

# versus this, which captures residual info. Notice that the highest residual 
# is the last count, despite its sqrt(O-E) size
ggplot(plt, aes(count, sR, fill = abs(z))) +
    geom_bar(stat='identity', position='identity') + 
    geom_line(aes(y=rootfit), colour='blue') + 
    geom_point(aes(y=rootfit), colour='blue', size=4) +
    xlab('Number of Occurrences') + 
    ylab('sqrt(Frequency)') + 
    scale_fill_gradient(low='white', high='red') + 
    theme_bw()


#' David's initial attempt with vcd::rootogram
	library(vcd)
	data(Federalist)
	Fed_fit <- goodfit(Federalist, type = "poisson")
	res <- with(Fed_fit, (observed - fitted) / sqrt(fitted))
	
	fill <- shading_hcl(observed = fed$observed, expected = fed$fitted, df = fed$df)(res)$fill
	rootogram(fed, type = "deviation", rect_gp = gpar(fill = fill), lines_gp = gpar(col = "red", lwd=2), pop = FALSE)
	shading <- shading_hcl(observed = fed$observed, expected = fed$fitted, df = fed$df)
	legend_resbased(x = unit(0.8, "npc"), y = 0.4, height = 0.4)(res, shading = shading, "")

#' Now implemented in vcd package

fed <- Fed_fit
rootogram(fed, shade = TRUE)
rootogram(fed, type = "deviation", shade = TRUE, lines_gp = gpar(col = "red", lwd=2))
rootogram(fed, type = "deviation", shade = TRUE, rect_gp = shading_Friendly)



