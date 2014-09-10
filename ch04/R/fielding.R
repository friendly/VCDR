# from Martin Monkman
# https://gist.github.com/MonkmanMH/1011b176b1bb5668b560

require(Lahman)
require(vcd)
MasterFielding <- data.frame(merge(Master, Fielding, by="playerID"))
throwPOS <- with(MasterFielding, table(POS, throws))
throwPOS
mosaic(throwPOS, shade=TRUE)

# sort by percent left

pctl <- throwPOS[,1] /rowSums(throwPOS)
throwPOS <- throwPOS[order(pctl),]
mosaic(throwPOS, shade=TRUE)


