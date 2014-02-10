#################
# Make file for the book
# Updated: 31 July 2013
#################

# This R source code compiles the manuscript for the book.
# It also updates the main README file.

## Installing required packages
# Note: To install the R packages used to compile the book open the Source/FrontMatter/Packages.Rnw. 
# Find: doInstall <- FALSE in the code chunk labeled "FrontPackageCitations". 
# Change the value `FALSE` to `TRUE` and run the code chunk.

# Load knitr package
library(knitr)

# Specify working directories.

Main <- 'book.Rnw'
Repo <- "C:/Documents and Settings/friendly/My Documents/My Dropbox/Documents/VCDR"
Source <- paste0(Repo, 'source')
#Setups <- paste0(Repo, 'setups')
ParentDirectory <- "/git_repositories/Rep-Res-Book/Source/"
## README.Rmd
SetupDirectory <- "/git_repositories/Rep-Res-Book/Writing_Setup/"

##### Create PDF Book Manuscript ####
# Compile the book's parent document
setwd(Source)
knitr::knit2pdf(input = 'book.Rnw')

# Embed fonts
# This is largely for complete replication purposes only and is not necessary.
## If using Windows please see extrafont set up instructions at https://github.com/wch/extrafont
# extrafont::embed_fonts("Rep-Res-Parent.pdf")

# Clean up /git_repositories/Rep-Res-Book/Source/Parent/
# DeleteFiles <- setdiff(list.files(source), c("Rep-Res-Parent.Rnw", 
#                                                      "Rep-Res-Parent.pdf", 
#                                                      "krantz.cls", "figure", 
#                                                      "cache")
#                       )
# unlink(DeleteFiles)

#### Update README ####
# Change working directory to /Rep-Res-Book/Writing_Setup/
setwd(Setups)

# Knit README file
knitr::knit(input = "README.Rmd", output = paste0(Repo, "README.md")