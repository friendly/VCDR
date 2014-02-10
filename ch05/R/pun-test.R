library(vcd)
library(MASS)
data("Punishment", package = "vcd")
str(Punishment)

pun <- xtabs(Freq ~ memory + attitude + age + education, data = Punishment)

mods.list <- apply(pun, c("age", "education"), function(x) loglm(~memory + attitude, data=x))
GSQ <- matrix( sapply(mods.list, function(x)x$lrt), 3, 3)
dimnames(GSQ) <- dimnames(mods.list)
GSQ
sum(GSQ)

# how do to this with the data frame?

mod.1 <- loglm(Freq ~ memory + attitude, subset=age=="15-24" & education=="elementary", data=Punishment)
mod.2 <- loglm(Freq ~ memory + attitude, subset=age=="25-39" & education=="elementary", data=Punishment)
mod.3 <- loglm(Freq ~ memory + attitude, subset=age=="40-"   & education=="elementary", data=Punishment)
mod.4 <- loglm(Freq ~ memory + attitude, subset=age=="15-24" & education=="secondary", data=Punishment)
mod.5 <- loglm(Freq ~ memory + attitude, subset=age=="25-39" & education=="secondary", data=Punishment)
mod.6 <- loglm(Freq ~ memory + attitude, subset=age=="40-"   & education=="secondary", data=Punishment)
mod.7 <- loglm(Freq ~ memory + attitude, subset=age=="15-24" & education=="high", data=Punishment)
mod.8 <- loglm(Freq ~ memory + attitude, subset=age=="25-39" & education=="high", data=Punishment)
mod.9 <- loglm(Freq ~ memory + attitude, subset=age=="40-"   & education=="high", data=Punishment)

mod.list <- list(mod.1, mod.2,mod.3, mod.4, mod.5, mod.6, mod.7, mod.8, mod.9)

GSQ <- matrix( sapply(mod.list, function(x)x$lrt), 3, 3)
dimnames(GSQ) <- list(age = levels(Punishment$age),
                      education = levels(Punishment$education)
                      )
GSQ
