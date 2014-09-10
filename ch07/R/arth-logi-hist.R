data(Arthritis, package="vcd")
Arthritis$Better <- as.numeric(Arthritis$Improved > "None")
arth.logistic <- glm(Better ~ Age, data=Arthritis, family=binomial)

#library(popbio)
source("C:/Documents and Settings/friendly/My Documents/My Dropbox/Documents/VCDR/functions/logi.hist.plot.R")

with(Arthritis,
  logi.hist.plot(Age, Better, type="hist", counts=TRUE,
    ylabel="Probability (Better)", 
    col.cur="blue", col.hist="lightblue", col.box="lightblue", xlab="Age")
  )

dev.copy2pdf(file="arth-logi-hist1.pdf")

with(Arthritis,
  logi.hist.plot(Age, Better, type="hist", counts=TRUE,
    ylabel="Probability (Better)", boxp=FALSE,
    col.hist="lightblue", xlab="Age")
  )

dev.copy2pdf(file="arth-logi-hist2.pdf")

