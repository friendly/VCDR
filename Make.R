#################
# Make file for the book
# Updated: 1 Jan 2015
#################

# This R source code compiles the manuscript for the book.

## Installing required packages
# Note: To install the R packages used to compile the book open the Source/FrontMatter/Packages.Rnw. 
# Find: doInstall <- FALSE in the code chunk labeled "FrontPackageCitations". 
# Change the value `FALSE` to `TRUE` and run the code chunk.

# Load knitr package
library(knitr)

# Specify working directories --- No, not portable.  Assume this is source'd() or run in the cwd for revision1

Main <- 'book.Rnw'
# Repo <- "C:/Dropbox/Documents/VCDR"
# Source <- Repo
# setwd(Source)

##### Create PDF Book Manuscript ####
knitr::knit2pdf(input = 'book.Rnw', quiet=TRUE)
# this also runs bibtex and makeindex via tools::texi2pdf

# may need to run BibTeX again sometimes... followed by pdflatex at the end
cat("\nRunning BibTex, makeindex, authorindex, aux2bib...\n")
system("bibtex book")
# make other indices: author index
system("perl authorindex -d book")
# create references.bib from separate bib files under local texmf tree
system("perl aux2bib book")
system("pdflatex book")

# Embed fonts
# C&H wants a file with embedded fonts.  We end up using a large number of fonts in different
# sizes, so this should make them happier. embed_fonts() also makes the file size smaller.

## If using Windows, see extrafont set up instructions at https://github.com/wch/extrafont
# It requires to set the path to GS, so this setting is not portable.

Sys.setenv(R_GSCMD = "C:/Program Files/gs/gs9.14/bin/gswin64c.exe")
extrafont::embed_fonts("book.pdf")


