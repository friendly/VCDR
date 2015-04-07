# 20. Opinions about birth control and premarital sex data set of Table 10.3

dat <- 
'premarsex birthcontrol Freq  
1 4  38   
1 3  60   
1 2  68   
1 1  81
2 4  14    
2 3  29   
2 2  26   
2 1  24
3 4  42   
3 3  74   
3 2  41   
3 1  18
4 4 157   
4 3 161   
4 2  57  
4 1  36
'



birthControl <- read.table(text=dat, header=TRUE)

birthControl$premarsex <- ordered(birthControl$premarsex,
         levels=1:4, 
         labels <- c("WRONG", "Wrong", "wrong", "OK"))

birthControl$birthcontrol <- ordered(birthControl$birthcontrol, 
         levels=1:4, 
         labels <- c("DISAGREE", "disagree", "agree", "AGREE"))
   

bc.tab <- xtabs(Freq ~ premarsex + birthcontrol, data=birthControl)

library(xtable)

xtable(bc.tab, digits=0)


mosaic(xtabs(bc.tab, shade=TRUE)



