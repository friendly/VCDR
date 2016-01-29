
data("Accident", package = "vcdExtra")

library(MASS)
loglm(Freq ~ age + mode + gender + result, data = Accident)
	# or,
accident.tab <- xtabs(Freq ~ age + mode + gender + result, data = Accident)
loglm(~ age + mode + gender + result, data = accident.tab)

# for graphs, reorder mode
Accident$mode <- ordered(Accident$mode,
   levels=levels(Accident$mode)[c(4,2,3,1)])

library(vcd)
# this variable order is not too bad
mosaic(accident.tab, shade=TRUE)

mosaic(accident.tab, shade=TRUE, labeling_args=list(abbreviate_labs=c(mode=6)))

mosaic(accident.tab, shade=TRUE, rot_labels = c(20, 90, 00, 90))

#mosaic(aperm(accident.tab, c(4,3,2,1)), shade=TRUE, rot_labels = c(20, 90, 00, 90))


# treat result as response
loglm(Freq ~ age * mode * gender + result, data = Accident)

mosaic(accident.tab, expected = ~age * mode * gender + result,
       shade=TRUE, rot_labels = c(20, 90, 00, 90))

mosaic(accident.tab, expected = ~age * mode * gender + result,
       shade=TRUE, rot_labels = c(20, 90, 00, 90),
       gp_args=list(interpolate=c(1,2,4,8)))
