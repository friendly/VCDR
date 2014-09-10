art <- PhdPubs$articles

dput(art)

table(art)

(art.freq <- colSums(outer(art, 0:19, `==`)))

art.hist <- hist(art, breaks=0:19, plot=FALSE)
art.hist$breaks
art.hist$counts

# coerce to a factor, then use table()
art.fac <- factor(art, levels = 0:19)
art.tab <- table(art.fac)
barplot(art.tab, ylab="Frequency", xlab="Number of articles")

# plot on log scale, but start at 1 to avoid log(0)
barplot(art.tab+1, ylab="log(Frequency+1)", xlab="Number of articles", log="y")


# plot on log scale, directly
barplot(log(art.tab+1), ylab="log(Frequency+1)", xlab="Number of articles")

# vs Fox/Dunlap plot, using plot.table method 

art.tab0 <- table(art)
plot(art.tab0, ylab="Frequency", xlab="Number of articles")
points(as.numeric(names(art.tab0)), art.tab0, pch=16)





