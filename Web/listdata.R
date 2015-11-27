dir<- "C:/Users/friendly/Dropbox/Documents/VCDR/Web"

dsets <- read.csv(paste0(dir,"/datasets.csv"), stringsAsFactors=FALSE)
str(dsets)


# by chapter
by_chap <- tapply(dsets$data, dsets$chapter, paste)
by_chap <- tapply(paste0(dsets$package,"::",dsets$data), dsets$chapter, paste)
by_chal <- lapply(by_chap, paste, collapse=', ')

for (i in 1:length(by_chal)) {
	ch <- by_chal[i]
	cat("Chapter", names(ch), ": ", unlist(ch), "\n")
}

# by package
by_pkg <- tapply(dsets$data, dsets$package, paste)



