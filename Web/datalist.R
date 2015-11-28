# Prepare a list of data sets used in the book
# Add links to their documentation

dir<- "C:/Users/friendly/Dropbox/Documents/VCDR/Web"
#dir<- "C:/Dropbox/Documents/VCDR/Web"

datalist <- read.csv(paste0(dir,"/datasets.csv"), stringsAsFactors=FALSE)
str(datalist)

datalist <- within(datalist,
	{link = paste0("http://www.inside-r.org/packages/cran/", package, "/docs/", data)})

str(datalist)


library(httr)
found <- sapply(datalist$link, url_success, config(followlocation = 0L), USE.NAMES = FALSE)

datalist$found <- found

datalist <- dsets
save(datalist, file="datalist.Rdata")



## by chapter
#by_chap <- tapply(datalist$data, datalist$chapter, paste)
#by_chap <- tapply(paste0(datalist$package,"::",datalist$data), datalist$chapter, paste)
#by_chal <- lapply(by_chap, paste, collapse=', ')
#
#for (i in 1:length(by_chal)) {
#	ch <- by_chal[i]
#	cat("Chapter", names(ch), ": ", unlist(ch), "\n")
#}

load(file="datalist.RData")

# list data sets by package
datalist$datalink <- with(datalist,
	{ifelse(found,
			paste0("[", data, "](", link, ")"),
			data)
	})
	
datalistp <- datalist[ order(datalist$package, datalist$data),]
# remove duplicates
datalistp <- datalistp[ !duplicated(datalistp$data),]

str(datalistp)
head(datalistp)


by_pkg <- tapply(datalistp$datalink, datalistp$package, paste)

for (i in 1:length(by_pkg)) {
	pkg <- by_pkg[i]
	cat(paste0("**",names(pkg), "**\n: "), paste(unlist(pkg), collapse=", "), "\n\n")
}



