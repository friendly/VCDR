data("RepVict", package="vcd")
victim.ca <- ca(RepVict)

# show only the scree plot
summary(victim.ca)

# relation to chisq
chisq.test(RepVict)
# chisq = N * sum(sv^2)
#
(chisq <- sum(RepVict) * sum(victim.ca$sv^2))


op <- par(cex=1.3, mar=c(4,4,1,1)+.1)
res <- plot(victim.ca, labels=c(2,0))
segments(res$rows[,1], res$rows[,2], res$cols[,1], res$cols[,2])
legend(-0.35, 0.45, c("First", "Second"), title="Occurrence",
col=c("blue", "red"), pch=16:17, bg="gray90")
par(op)


# try 3d plot
# NB: plot3d is not a method for ca objects

plot3d.ca(victim.ca)
