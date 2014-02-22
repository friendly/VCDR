library(vcdExtra)
library(MASS)
data("Employment", package = "vcd")
str(Employment)

# baseline model [A][BC]
mosaic(Employment, shade=TRUE, 
       expected = ~ EmploymentStatus + EmploymentLength*LayoffCause, 
       main = "EmploymentStatus + Length * Cause")

loglm(~ EmploymentStatus + EmploymentLength*LayoffCause, data=Employment)

# conditional independence [AC][BC] = A \perp B | C

loglm(~ EmploymentStatus*LayoffCause + EmploymentLength*LayoffCause, data=Employment)

mosaic(Employment, shade=TRUE, gp_args=list(interpolate=1:4),
       expected = ~ EmploymentStatus*LayoffCause + EmploymentLength*LayoffCause, 
       main = "EmploymentStatus * Cause + Length * Cause")


# separate models for each layoff cause

mosaic(~ EmploymentStatus + EmploymentLength | LayoffCause, data = Employment, 
	shade=TRUE, gp_args=list(interpolate=1:4),
	main = "EmploymentStatus + Length | Cause")

mods.list <- apply(Employment, "LayoffCause", function(x) loglm(~EmploymentStatus + EmploymentLength, data=x))
GSQ <- sapply(mods.list, function(x)x$lrt)
dimnames(GSQ) <- dimnames(mods.list)
GSQ
sum(GSQ)

XSQ <- sapply(mods.list, function(x)x$pearson)
dimnames(XSQ) <- dimnames(mods.list)
XSQ
sum(XSQ)

# try using loglmlist -- doesn't work
#class(mods.list) <- c("list", "loglmlist")
#summarise(mods.list)


# examples from the ?Employment page

## Employment Status
mosaic(Employment, shade=TRUE,
       expected = ~ LayoffCause * EmploymentLength + EmploymentStatus,
       main = "Layoff*EmployLength + EmployStatus")

mosaic(Employment,  shade=TRUE,
       expected = ~ LayoffCause * EmploymentLength + LayoffCause * EmploymentStatus,
       main = "Layoff*EmployLength + Layoff*EmployStatus")

## Stratified view

grid.newpage()
pushViewport(viewport(layout = grid.layout(ncol = 2)))
pushViewport(viewport(layout.pos.col = 1))

## Closure
mosaic(Employment[,,1], shade=TRUE, gp_args=list(interpolate=1:4),
       margin = c(right = 1),
       main = "Layoff: Closure", newpage = FALSE)

popViewport(1)
pushViewport(viewport(layout.pos.col = 2))

## Replaced
mosaic(Employment[,,2], shade=TRUE, gp_args=list(interpolate=1:4),
       margin = c(right = 1),
       main = "Layoff: Replaced", newpage = FALSE)
popViewport(2)

