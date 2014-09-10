library(vcdExtra)
data(SexualFun)
SexualFun                # show the table
CMHtest(SexualFun)       # CMH tests
chisq.test(SexualFun)    # general association
fisher.test(SexualFun)   # exact test
assocstats(SexualFun)    # association statistics
