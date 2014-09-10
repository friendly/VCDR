data("Suicide", package="vcd")
library(ca)


# interactive coding of sex and age.group
Suicide <- within(Suicide, {
	age_sex <- paste(age.group, toupper(substr(sex,1,1)))
	})

# using 8 level method2

suicide.tab <- xtabs(Freq ~ age_sex + method2, data=Suicide)
suicide.ca <- ca(suicide.tab)
summary(suicide.ca)


# try with plot.ca()
op <- par(cex=1.3, mar=c(4,4,1,1)+.1, lwd=2)
plot(suicide.ca, map="colgreen", arrows=c(FALSE, TRUE))
par(op)


library(UBbipl)

folder <- "C:/Users/friendly/Dropbox/Documents/VCDR/ch06/fig/"
pdf(file = paste0(folder, "cabipl-suicide.pdf"), height=6, width=6)

cabipl(as.matrix(suicide.tab), 
		axis.col = gray(.4),
		ax.name.size=1, 
    ca.variant = "PearsonResA", 
    markers = FALSE, 
    row.points.size = 1.5,
    row.points.col = rep(c("red", "blue"), 4),
    plot.col.points = FALSE, 
    marker.col = "black", marker.size=0.8, 
    offset = c(2, 2, 0.5, 0.5), 
    offset.m = rep(-0.2, 14),
    output=NULL 
    )

dev.off()
