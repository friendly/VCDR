data("HorseKicks", package = "vcd")
HorseKicks

library(xtable)
xtable(HorseKicks)

tab <- as.data.frame(HorseKicks)
colnames(tab) <- c("nDeaths", "Freq")
print(xtable(tab), include.rownames = FALSE, 
      include.colnames = TRUE)

horsetab <- t(as.data.frame(addmargins(HorseKicks)))
rownames(horsetab) <- c( "Number of deaths", "Frequency" )
horsetab <- xtable(horsetab, digits = 0,
     caption = "von Bortkiewicz's data on deaths by horse kicks",
     align = paste0("l|", paste(rep("r", ncol(horsetab)), 
                                collapse = ""))
     )
print(horsetab, include.colnames = FALSE, caption.placement="top")
