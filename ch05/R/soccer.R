data("UKSoccer", package="vcd")
names(dimnames(UKSoccer)) <- paste(names(dimnames(UKSoccer)), "Goals")


chisq.test(UKSoccer)

CMHtest(UKSoccer)

mosaic(UKSoccer, shade=TRUE)
set.seed(1234)
mosaic(UKSoccer, gp=shading_max, labeling=labeling_residuals, digits=2)

BL1995 <- xtabs(~ HomeGoals + AwayGoals, data=Bundesliga,
	subset = Year == 1995)
mosaic(BL1995, shade=TRUE, gp=shading_max)


# Bundesliga, all years with 306 games
BL <- xtabs(~ HomeGoals + AwayGoals, data=Bundesliga,
	subset = Year > 1964)

# keep just 0:6 goals
BL <- BL[1:7, 1:7]
BL

mosaic(BL, shade=TRUE, gp=shading_max)
