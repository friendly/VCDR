---
title: "Tasks for Copy Edit of DDAR"
author: "Michael Friendly"
date: "August 26, 2015"
output: html_document
---


## RGB to CMYK

Some discussion on this appears as [issue 45](https://github.com/friendly/VCDR/issues/45)

1. Examine the figures that are included via `\includegraphics` rather than by R chunks.
There is a list of these in the file `includegraphics-fig.txt`, but it doesn't include file extensions --- some
are `.png`, while others are `.pdf`.  

2. Try running ImageMagik `convert` on these files to see how well they convert to CMYK.  

## Fix art

Examine figures noted in the copy edit as "Fix art" --- most of these have to do with either:

* clipped text --- e.g., `par(xpd=TRUE)` not set or not given to `text()`
* label collisions --- e.g., point labels in CA and other plots, factor labels in `mosaic()` plots

I'm not sure how many of these can be fixed in code, but it is worth looking at.
I'd like to resist the temptation to tweak figures manually, but there might be a case or two for this.

## Subject index

Need to make one global pass to try to do a proper index, or improve the current one (mostly generated
automatically) according to standard indexing guidelines
(e.g., Chicago Manual of Style)

1.  Re-run the book.Rnw with the following settings, to produce a version of the book, `book-indexing.pdf`, 
suitable for manual indexing.
  * `% \usepackage{showlabels}` turned off by commenting out
  * `\usepackage{showidx}` to show index entries on each page, or better yet, the LaTeX solution described in
http://tex.stackexchange.com/questions/64249/mark-indexed-entries-in-the-text-itself

2. Run `knit2pdf("book.Rnw", output="book-indexing.tex")` with these settings

3. Read through the book, with the index at hand, marking new or different index entries on the PDF pages.

4. Enter new/changed one in the `.Rnw` files, using `\ix{}` or `\ixon{} ... \ixoff{}`.


