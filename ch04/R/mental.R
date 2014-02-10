data(Mental, package="vcdExtra")
mental.tab <- xtabs(Freq ~ ses+mental, data=Mental)

library(xtable)
options(xtable.caption.placement= "top")
options(xtable.table.placement= "htb")

xtable(mental.tab, digits=0,
	caption="Mental impariment and parents SES")

# \S 4.2
Mental.tab <- xtabs(Freq ~ ses+mental, data=Mental)

chisq.test(Mental.tab)
assocstats(Mental.tab)

CMHtest(Mental.tab)
# more simply
CMHtest(Freq~ ses + mental, data=Mental)

