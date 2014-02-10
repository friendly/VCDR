outdir <- "C:/Documents and Settings/friendly/My Documents/My Dropbox/Documents/VCDR/ch03/tab/"
options(xtable.caption.placement= "top")
options(xtable.table.placement= "htb")
options(sanitize.text.function= function(x) { x } )
options(xtable.include.colnames = FALSE)


data(HorseKicks, package="vcd")
HorseKicks

## Chapter 2 examples, of using xtable:

xtable(HorseKicks)

tab <- as.data.frame(HorseKicks)
str(tab)
colnames(tab) <- c("nDeaths", "Freq")
print(xtable(tab), include.rownames=FALSE, include.colnames=TRUE)

# do it as a horizontal table, adding margins

horsetab <- t( as.data.frame( addmargins( HorseKicks ) ) )
rownames( horsetab ) <- c( "Number of deaths", "Frequency" )
horsetab <- xtable( horsetab, digits = 0,
     caption = "von Bortkiewicz's data on deaths by horse kicks",
     align = paste0("l|", paste(rep("r", ncol(horsetab)), collapse=""))
     )
print(horsetab)


## Chapter 3 table
horsetab <- t( as.data.frame( addmargins( HorseKicks ) ) )
rownames( horsetab ) <- c( "Number of deaths ($k$)", "Frequency ($n_k$)" )
horsetab <- xtable( horsetab, digits = 0,
     caption = "von Bortkiewicz's data on deaths by horse kicks\\label{tab:horsetab}",
     align = paste0("l|", paste(rep("r", ncol(horsetab)), collapse=""))
     )

print( horsetab, 
#     caption.placement = "top", 
#     include.colnames = FALSE, 
     hline.after = c( NULL, 0, nrow( horsetab ) ),
#     sanitize.text.function = function(x) { x },
     file = paste0(outdir, "horsetab.tex") )

#################################################################

# goodness-of-fit test
tab <- as.data.frame(HorseKicks, stringsAsFactors=FALSE)
colnames(tab) <- c("nDeaths", "Freq")
str(tab)
(lambda <- weighted.mean(as.numeric(tab$nDeaths), w=tab$Freq))

phat <- dpois(0:4, lambda=lambda)
exp <- sum(tab[,"Freq"]) * phat
chisq <- (tab$Freq - exp)^2 / exp

GOF <- data.frame(tab, phat, exp, chisq)
GOF

sum(chisq)  # chi-square value
pchisq(sum(chisq), df=nrow(tab)-2, lower.tail=FALSE)


