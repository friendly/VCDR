# Analysis of demand for medical care, NMES1988

data("NMES1988", package="AER")
nmes <- NMES1988[, c(1, 6:8, 13, 15, 18)]
str(nmes)

# visualize frequency distribution
plot(table(nmes$visits), xlab="Physician office visits", ylab="Frequency")
plot(log(table(nmes$visits)), xlab="Physician office visits", ylab="log(Frequency)")

with(nmes,  c(mean=mean(visits), var=var(visits), ratio=var(visits)/mean(visits)))

clog <- function(x) log(x + 1)

cutfac <- function(x, breaks = NULL, q=10) {
  if(is.null(breaks)) breaks <- unique(quantile(x, 0:q/q))
  x <- cut(x, breaks, include.lowest = TRUE, right = FALSE)
  levels(x) <- paste(breaks[-length(breaks)], ifelse(diff(breaks) > 1,
    c(paste("-", breaks[-c(1, length(breaks))] - 1, sep = ""), "+"), ""), sep = "")
  return(x)
}


# exploratory plots
# ------------------
#plot(clog(visits) ~ health, data = nmes, varwidth = TRUE,
#  ylab = "Physician office visits (in clogs)", xlab = "Self-perceived health status", main = "health")
#plot(clog(visits) ~ cfac(chronic), data = nmes,
#  ylab = "Physician office visits (in clogs)", xlab = "Number of chronic conditions", main = "chronic")
#plot(clog(visits) ~ insurance, data = nmes, varwidth = TRUE,
#  ylab = "Physician office visits (in clogs)", xlab = "Covered by private insurance", main = "insurance")
#plot(clog(visits) ~ cfac(hospital, c(0:2, 8)), data = nmes,
#  ylab = "Physician office visits (in clogs)", xlab = "Number of hospital stays", main = "hospital")
#plot(clog(visits) ~ gender, data = nmes, varwidth = TRUE,
#  ylab = "Physician office visits (in clogs)", xlab = "Gender", main = "gender")

op <-par(mfrow=c(1, 3), cex.lab=1.4)
plot(log(visits+1) ~ cutfac(chronic), data = nmes,
  ylab = "Physician office visits (log scale)", xlab = "Number of chronic conditions", main = "chronic")
plot(log(visits+1) ~ health, data = nmes, varwidth = TRUE,
  ylab = "Physician office visits (log scale)", xlab = "Self-perceived health status", main = "health")
plot(log(visits+1) ~ cutfac(hospital, c(0:2, 8)), data = nmes,
  ylab = "Physician office visits (log scale)", xlab = "Number of hospital stays", main = "hospital")
par(op)

plot(log(visits+1) ~ insurance, data = nmes, varwidth = TRUE,
  ylab = "Physician office visits (log scale)", xlab = "Private insurance", main = "insurance")
plot(log(visits+1) ~ gender, data = nmes, varwidth = TRUE,
  ylab = "Physician office visits (log scale)", xlab = "Gender", main = "insurance")

plot(log(visits+1) ~ cutfac(school), data = nmes, varwidth = TRUE,
  ylab = "Physician office visits (log scale)", xlab = "Years of education", main = "school")

spineplot(cutfac(visits, c(0:2, 4, 6, 10, 100)) ~ school, data = nmes, breaks = 9,
  ylab = "Physician office visits", xlab = "Number of years of education", main = "school")

library(ggplot2)
ggplot(nmes, aes(x=school, y=visits+1)) +
	geom_jitter(alpha=0.25) +
	stat_smooth(method="loess", color="red", fill="red", size=1.5, alpha=0.3) +
	labs(x="Number of years of education", y="log(Physician office visits+1)") +
	scale_y_log10(breaks=c(1,2,5,10,20,50,100)) + theme_bw()

	
	
	
	