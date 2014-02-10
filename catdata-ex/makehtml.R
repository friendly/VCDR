# run kintr::stitch on VCD files
# goal: run knitr::stitch on all files in a directory list, producing HTML output
#     via apply or even a loop.

# Test case: all .R files in:
# http://euclid.psych.yorku.ca/datavis.ca/courses/VCD/R/

# copied here for testing
vcddir <- "c:/sasuser/catdata/R/VCDcourse/"

files <- list.files(vcddir, pattern="*\\.R$")
# remove install* files
files <- files[-grep("^install", files)]
files

setwd(vcddir)

# my template
template <- paste0(vcddir, "myknitr-template.Rhtml")
# I don't want to see these in my output:
suppressPackageStartupMessages(TRUE)

library(knitr)

# function to stitch one file
stitch1 <- function(file, indir=vcddir) {
	.knitr.title <- paste("Output from", file)
	.knitr.author <- "Michael Friendly" 
	script <- paste0(indir, file)
	knitr::stitch(script, template=template) 
}


stitch1(files[10])
opts_knit$set(upload.fun = image_uri) 

# do for all
w <- 17:21  # 1:length(files)
for (i in w) {
	suppressPackageStartupMessages(TRUE)
	f <- files[i]
	stitch1(f)
}


### Problems

#  If I run this twice or more on a file I get:
#In addition: Warning message:
#In knitr::stitch(script, template = template) :
#  berk-4fold.Rhtml already exists
## How to unlink the generated Rhtml file in my script?
#  NB: This doesn't happen in RStudio


## In my myknitr-template.Rhtml template, I want to use additional
# CSS style attributes, e.g., H1 in sans font, but what I've done
# doesn't seem to have any effect.
#<head>
#  <title><!--rinline I(.knitr.title) --></title>
#  <style type="text/css">
#  <--
#  H1 {font-family: arial sans-serif}
#  -->
#  </style>
#</head>

#For a vectorized version of stitch(), you can call
#
#mapply(stitch, input = list.files(vcddir, pattern="*\\.R$"), template
#= template)

