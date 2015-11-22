# extract R code from chapters

outdir <- "Web/Rcode/"
chapters <- c(sprintf("ch%02d", 1:11))

# function to remove unneeded chunk options in Rcode [UNTESTED]
fix_chunks <- function(scriptname, all=TRUE) {
  script <- readLines(scriptname)
  script <- do.call(paste, list(script, collapse = "\n") )
#   opts_to_remove <- c("h", "w", "out.width", "R.options")
#   pattern <- paste0("(", do.call(paste, list(opts_to_remove, "=.*,", collapse="|")), ")")
  if (all) {
    pattern <- "^(## ----[[:alnum:]]+),.*----"
    rep <- "\\1"
  }
  script <- gsub(pattern = pattern, replacement = rep, x = script, perl=TRUE)
  writeLines(text = script, con= scriptname)
}

for (ch in chapters) {
  input <- paste0(ch, ".Rnw")
  output <- paste0(outdir, ch, ".R")
  cat(paste("\n**purling", input, "->", output, "\n"))
  knitr::purl(input, output=output, quiet=TRUE)
}
