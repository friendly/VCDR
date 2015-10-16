# better version of nasa0.pdf plot
# use CMYK for PDF graphs
grDevices::pdf.options(colormodel = "cmyk")


data("SpaceShuttle", package="vcd")


# flight 51C was recorded as 3 erosion incidents
SpaceShuttle <- within(SpaceShuttle,
	 Incidents <- ifelse(Damage <= 4, nFailures, nFailures+1) 
	)
SpaceShuttle <- SpaceShuttle[complete.cases(SpaceShuttle),]
# sort by temp
SpaceShuttle <- SpaceShuttle[order(SpaceShuttle$Temperature),]
#str(SpaceShuttle)

op <- par(mar=c(4,4,1,1)+.1)
with(SpaceShuttle, {
	included <- Incidents > 0
	plot(Incidents ~ Temperature, data=SpaceShuttle,
		ylim = c(0,3),
		ylab="Number of incidents",
		xlab="Temperature (F)",
		cex = 1.5,
		pch = 16,
		col = c("darkgray", "blue")[1+included],
		cex.lab = 1.3,
		yaxt="n"
		)
	axis(2, at=0:3, cex=2)

	qfit1 <- lm(Incidents ~ poly(Temperature, 2), data=SpaceShuttle, subset=Incidents>0)
	pred1 <- predict(qfit1, newdata=data.frame(Temperature=52:80))
	lines(52:80, pred1, col="blue", lwd=3)

	qfit2 <- lm(Incidents ~ poly(Temperature, 2), data=SpaceShuttle)
	pred2 <- predict(qfit2, newdata=data.frame(Temperature=52:80))
	lines(52:80, pred2, col="darkgray", lwd=2)

	text(Temperature[included], Incidents[included], FlightNumber[included],
		pos=c(1,3), col="blue", cex=1.2)
	text(Temperature[!included], Incidents[!included], FlightNumber[!included],
		pos=c(1,3), col="darkgray", xpd=TRUE)

	text(78, 2.5, "Zeros excluded", cex=1.2, col="blue", xpd=TRUE)
	text(78, 0.45, "Zeros included", cex=1.2, col="darkgray", xpd=TRUE)
	}
	)
dev.copy2pdf(file="nasa.pdf", height=6, width=6)

par(op)	



