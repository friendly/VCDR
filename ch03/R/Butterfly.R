# ch03: discrete distributions

data(Butterfly, package="vcd")

Butterfly
str(Butterfly)

# find weighted mean
butter.df <- as.data.frame(Butterfly, stringsAsFactors=FALSE)
butter.mean <- weighted.mean(as.numeric(butter.df[,1]), butter.df[,2])


# using the default graphics::plot.table method
plot(Butterfly, lwd=16, col="lightblue", 
     xlab="Number of individuals", ylab="Number of species", 
     lend="square", cex.lab=1.5)

abline(v=butter.mean)


# using lattice::barchart
barchart(Butterfly, horizontal=FALSE, xlab="Number of individuals")

bp <- barplot(Butterfly, xlab="Number of individuals", ylab="Number of species", cex.lab=1.5)

# find weighted mean
butter.df <- as.data.frame(Butterfly, stringsAsFactors=FALSE)
butter.mean <- weighted.mean(as.numeric(butter.df[,1]), butter.df[,2])

abline(v=bp[1]+ butter.mean)


# tables

library(xtable)

# long
xtable(Butterfly, digits=0)
# wide 
xtable(t(Butterfly), digits=0)

butter <- t( as.data.frame( addmargins( Butterfly ) ) )
rownames(butter) <- c( "Individuals ($k$)", "Species ($n_k$)" )

buttertab <- xtable( butter, digits = 0,
     caption = "Number of butterfly species $n_k$ for which $k$ individuals were collected",
     align = paste0("l|", paste(rep("r", ncol(butter)), collapse=""))
     )
print( buttertab, caption.placement = "top", include.colnames = FALSE, 
     hline.after = c( NULL, 0, nrow( saxtab ) ),
     sanitize.text.function = function(x) { x } )


