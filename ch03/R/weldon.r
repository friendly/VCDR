outdir <- "C:/Documents and Settings/friendly/My Documents/My Dropbox/Documents/VCDR/ch03/tab/"
options(xtable.caption.placement= "top")
options(xtable.table.placement= "htb")
options(sanitize.text.function= function(x) { x } )
options(xtable.include.colnames = FALSE)

data(WeldonDice, package="vcd")
#> WeldonDice
#n56
#   0    1    2    3    4    5    6    7    8    9   10 
# 185 1149 3265 5475 6114 5194 3067 1331  403  105   18 
#> 

dimnames(WeldonDice)$n56[11] <- "10+"

barplot(WeldonDice, xlab="Number of 5s and 6s", ylab="Frequency", col="lightblue", cex=1.5)

library(xtable)

# long
xtable(WeldonDice, digits=0)

dicetab <- xtable(t(addmargins(WeldonDice)), digits=0, 
	caption="Number of 5 or 6 in throws of 12 dice")

dicetab <- t( as.data.frame( addmargins( WeldonDice ) ) )
rownames( dicetab ) <- c( "Number of 5s or 6s ($k$)", "Frequency ($n_k$)" )
dicetab <- xtable( dicetab, digits = 0,
     caption = "Frequencies of 5s or 6s in throws of 12 dice",
     align = "l|rrrrrrrrrrrr" )
print( dicetab, caption.placement = "top", include.colnames = FALSE, 
     hline.after = c( NULL, 0, nrow( dicetab ) ),
     sanitize.text.function = function(x) { x } )

#################################################################


data(Federalist, package="vcd")
Federalist

fedtab <- t( as.data.frame( addmargins( Federalist ) ) )
rownames( fedtab ) <- c( "Occurrences of \\emph{may} ($k$)", "Blocks of text ($n_k$)" )
fedtab <- xtable( fedtab, digits = 0,
     caption = "Number of occurrences of the word \\emph{may} in texts written by James Madison\\label{tab:fedtab}",
     align = paste0("l|", paste(rep("r", ncol(fedtab)), collapse=""))
     )

print( fedtab, 
#     caption.placement = "top", 
#     include.colnames = FALSE, 
     hline.after = c( NULL, 0, nrow( fedtab ) ),
#     sanitize.text.function = function(x) { x },
     file = paste0(outdir, "fedtab.tex") )


barplot(Federalist, xlab="Occurrences of 'may'", ylab="Blocks of text", col="lightblue", cex=1.5)

