data(DaytonSurvey, package="vcdExtra")

Dayton.ACM <- aggregate(Freq ~ cigarette+alcohol+marijuana, data=DaytonSurvey, FUN=sum)
ftable(xtabs(Freq~cigarette+alcohol+marijuana, data=Dayton.ACM))

dayton.tab <- xtabs(Freq~cigarette+alcohol+marijuana, data=Dayton.ACM)

# fourfold displays
dayton.tab <- xtabs(Freq~cigarette+alcohol+marijuana, data=Dayton.ACM)
fourfold(dayton.tab)
fourfold(aperm(dayton.tab, c(1,3,2)))
fourfold(aperm(dayton.tab, c(2,3,1)))



library(MASS)
fitACM<-loglm(Freq ~ alcohol*cigarette*marijuana, data=Dayton.ACM, param=T,fit=T) # ACM
fitAC.AM.CM<-update(fitACM, .~. - alcohol:cigarette:marijuana)                      # AC, AM, CM
fitAM.CM<-update(fitAC.AM.CM, .~. - alcohol:cigarette)                              # AM, CM
fitAC.M<-update(fitAC.AM.CM, .~. - alcohol:marijuana - cigarette:marijuana)         # AC, M
fitA.C.M<-update(fitAC.M, .~. - alcohol:cigarette)                                  # A, C, M 

anova(fitA.C.M, fitAC.M, fitAM.CM, fitAC.AM.CM) 

LRstats(fitA.C.M, fitAC.M, fitAM.CM, fitAC.AM.CM) 

mosaic(fitAC.AM.CM)
