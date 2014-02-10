# Examples of distplot

data("HorseKicks", package="vcd")
dp <- distplot(HorseKicks, type = "poisson", 
	xlab="Number of deaths", main="Poissonness plot: HorseKicks data")
print(dp, digits=4)

#> dp
#  Counts Freq  Metameter  CI.center  CI.width   CI.lower   CI.upper
#1      0  109 -0.6069695 -0.6131352 0.1304761 -0.7436113 -0.4826592
#2      1   65 -1.1239301 -1.1342913 0.2069296 -1.3412208 -0.9273617
#3      2   22 -1.5141277 -1.5450557 0.4169456 -1.9620012 -1.1281101
#4      3    3 -2.4079456 -2.6606896 1.3176305 -3.9783202 -1.3430591
#5      4    1 -2.1202635 -3.1202635 2.6886511 -5.8089146 -0.4316125


# leveled version
distplot(HorseKicks, type = "poisson", lambda = 0.61, 
	xlab="Number of deaths", main="Leveled Poissonness plot")


data("Federalist", package="vcd")
distplot(Federalist, type = "poisson", xlab="Occurrences of 'may'")
distplot(Federalist, type = "nbinomial", xlab="Occurrences of 'may'")


distplot(Federalist, type = "nbinomial", size = 1)

data("Saxony", package="vcd")
Ord_plot(Saxony)
distplot(Saxony, type = "binomial", size = 12, 
	xlab="Number of males")


data("WomenQueue", package="vcd")
distplot(WomenQueue, type = "binomial", size = 12)


