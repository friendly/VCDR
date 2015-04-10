# functions to create a Package List section for VCDR

# To get the list of cited packages:
# grep "citation{" book.aux | grep -v ":" | perl -pe 's|^\\citation\{||; s|\}||' | sort -u > inputs/cited-packages.txt

# NB:  The Author field in DESCRIPTION is in pretty raw form.
#   It might be better to use the the author field from citation()

packageDescList <-
function (x = .packages(), file = "", sort=TRUE) 
{
    idx = mapply(system.file, package = x) == ""
    if (any(idx)) {
        warning("package(s) ", paste(x[idx], collapse = ", "), 
            " not found")
        x = x[!idx]
    }
    .base.pkgs <- c("base", "compiler", "datasets", "graphics", "grDevices", "grid", "methods", "parallel", "splines", "stats", "stats4", "tcltk", "tools", "utils")

    x = setdiff(x, .base.pkgs)
    if (sort) x <- sort(x)
    
    desc = sapply(x, function(pkg) {
        des = packageDescription(pkg, fields = c("Package", "Version", "Title", "Description", "Author", "URL"))
        entry = toLatex(des)
        gsub("", "", entry)
    }, simplify = FALSE)
		header <- "\\begin{description}\n"
		footer <- "\\end{description}\n"

		ndes <- length(desc)
		desc <- c(header, desc, footer)
    if (!is.null(file)) 
        cat(unlist(desc), sep = "\n", file = file)
    cat("Wrote ", ndes, "package description entries", if (file!="") "to ", file, "\n")
    invisible(desc)
}


# translate to an item in a description list
toLatex.packageDescription <- function (object) {
	pkg <- object$Package
	ver <- object$Version
	title <- object$Title
	title <- gsub(' & ?', ' \\\\& ', title)      # bare use of & will cause a LaTeX error
	desc <- sub("^\n *", "", object$Description)
	aut <- gsub(" \\[[ ,a-z]*\\]", "", object$Author)
	aut <- gsub("\n ", "", aut)
	aut <- gsub("\\s+", " ", aut, perl=TRUE)
	aut <- gsub("<(.*?)>", "\\\\url{email:\\1}", aut, perl=TRUE)
	
	z <- paste0("  \\item [", pkg, "] \\emph{", title, "} (v.~", ver, ").\n\t", desc, "\n\t", "\\textbf{Authors}: ", aut, "\n\n")
	z
}

TESTME <- TRUE
if(TESTME) {
#pkgs <- c("vcd", "vcdExtra")
#packageDescList(pkgs)

cited.pkgs <- scan("C:/Dropbox/Documents/VCDR/inputs/cited-packages.txt", what="character")
file <- "C:/Dropbox/Documents/VCDR/front/packageList.tex"
packageDescList(cited.pkgs, file=file)
}

