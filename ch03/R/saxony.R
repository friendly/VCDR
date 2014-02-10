data(Saxony, package="vcd")
barchart(Saxony, horizontal=FALSE, xlab="Number of males", ylab="Number of families", col="lightblue")

barplot(Saxony, xlab="Number of males", ylab="Number of families", col="lightblue")
 


library(xtable)

# long
xtable(Saxony, digits=0)

saxtab <- xtable(t(addmargins(Saxony)), digits=0, 
	caption="Number of male children in 6115 Saxony families of size 12")

print(saxtab)

# from Rainer.Schuermann@gmx.net on R-help

saxtab <- t( as.data.frame( addmargins( Saxony ) ) )
rownames( saxtab ) <- c( "Males ($k$)", "Families ($n_k$)" )
saxtab <- xtable( saxtab, digits = 0,
     caption = "Number of male children in 6115 Saxony families of size 12",
     align = "l|rrrrrrrrrrrrrr" )
print( saxtab, caption.placement = "top", include.colnames = FALSE, 
     hline.after = c( NULL, 0, nrow( saxtab ) ),
     sanitize.text.function = function(x) { x } )



