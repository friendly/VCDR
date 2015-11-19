# extract R code from chapters

outdir <- "Rcode/"
chapters <- c(sprintf("ch%02d", 1:11))

for (ch in chapters) {
  input <- paste0(ch, ".Rnw")
  output <- paste0(outdir, ch, ".R")
  cat(paste("\n**purling", input, "->", output, "\n"))
  knitr::purl(input, output=output, quiet=TRUE)
}
