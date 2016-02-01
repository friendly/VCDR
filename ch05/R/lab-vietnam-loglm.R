#' ---
#' title: "Vietnam data, Exercise 5.10"
#' author: "Michael Friendly"
#' date: "01 Feb 2016"
#' ---

data(Vietnam, package="vcdExtra")


library(MASS)
library(vcdExtra)
viet.mod <- loglm(Freq ~ sex * year + response, data=Vietnam)
mosaic(viet.mod)

# alternatively,
vietnam.tab <- xtabs(Freq ~ sex + year + response, data=Vietnam)
mosaic(vietnam.tab, expected = ~ sex * year + response)


# (b) conditional plots
mosaic(~ response + year | sex, data=vietnam.tab, shade=TRUE)

cotabplot(~ response + year | sex, data=vietnam.tab, shade=TRUE, legend=FALSE)

cotabplot(~ response + year | sex, data=vietnam.tab, 
				  gp=shading_Friendly, gp_args=list(interpolate=1:4), legend=FALSE)

# (c) partial relations

mods.list <-
	apply(vietnam.tab, "sex",
	      function(x) loglm(~ response + year, data=x))
mods.list


