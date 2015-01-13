data(PreSex, package="vcd")
library(vcd)

# [GM] [PE]
stacked <- as.matrix(structable(Gender + Marital ~ Pre + Extra, data=PreSex), sep=":")
names(dimnames(stacked)) <- c("Pre:Extra", "Gender:Marital")
str(stacked)

library(ca)
stacked.ca <- ca(stacked)
summary(stacked.ca)
res <- plot(stacked.ca)
res

#lines(res$cols[1:2,1], res$cols[1:2,2], col="red")
#lines(res$cols[3:4,1], res$cols[3:4,2], col="red")

polygon(res$cols[c(1,2,4,3),1], res$cols[c(1,2,4,3),2], border="red")
#polygon(res$rows[c(1,2,4,3),1], res$rows[c(1,2,4,3),2], border="blue")

