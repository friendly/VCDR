Visualizing categorical Data with R
===================================

This document describes the file structure and conventions for the 
book.

File structure
--------------
Book files:  `book.Rnw` is the main source file.  `chapter.Rnw` is a master file for a single chapter.  Chapters are
in chXX.Rnw, and are included as knitr child documents.
All other files (figures, tables, R code) for a given chapter
are in subdirectories, `chXX/{fig,tab,R}`.

I've only just begun to use sub-child documents for sections within
chapters, but this works without problems.


```
book.Rnw  - Main source file; compile with `knit2pdf("book.Rnw")`.  Several latex passes are needed to resolve cross-references and bibtex citations.
ch01.Rnw
ch02.Rnw
Ch03.Rnw
Ch04.Rnw
 ...
ch01/
   fig/
   R/
   tab/
ch02/
   fig/
   R/
   tab/
ch03/
   fig/
   R/
   tab/
ch04/
 ...
front/  - front matter files
inputs/
   commands.tex - all LaTeX style commands (math markup, R abbreviations, examples, etc are defined here)
references.bib - current resolved reference list, extracted via aux2bib
```

There is now also a chapter master file, `chapter.Rnw` for compiling a single chapter, with `knit2pdf("chapter.Rnw")`.  Just before the `\begin{document}`, set the chapter number 
using, e.g., for Chapter 8:
```
<<set-counters, results='asis', tidy=FALSE, echo=FALSE>>=
.chapter <- 8
...
@

```

Then, compile with:

```
knit2pdf("chapter.Rnw", output="chapter08.pdf",  quiet=TRUE)
```


### Other files and directories:
```
chXX.Rnw - a minimal template for a new chapter
Rprofile.R - defines a function `knitrSet()` called at the start of each chapter to set the basename (chXX) and common knitr options for the chapter.

functions/ - R functions that can be `source()`d for the book.  These can be used to override 
bookplan/  - book proposal
vcd/  - source files from the SAS edition of vcd.  I crib from this as needed.
vcd-tutorial/  - files for vcdExtra vignette
Workshop/  - Exercises for my VCD short course
```

### Bibliography files:

At present, I have been keeping all source `.bib` and `.bst` files in a separate
`localtexmf` tree, outside VCDR.  I'll have to move them here or else share a
separate link.

Typically, I use the utility `aux2bib` to extract the relevant entries, to
create a composite file, `references.bib` in the target directory, but that
has to be re-done with changes to the text.  This is a perl script I run on
linux, and Windows (via `perl aux2bib book`)

At present, `references.bib` is up-to-date, and the `.bst` file, `abbrvnat-apa-nourl.bst`
is included in the project root directory.

This points to the need for a `Makefile` for the project.

The `book.Rnw` file now makes it easier to switch from the separate .bib files to `references.bib`:

```
\usepackage{ifthen}
\newboolean{localbibs}         % Use local .bib files or processed references.bib ??
\setboolean{localbibs}{true}   % Change to false to use references.bib
```

Conventions used in the .Rnw files
-----------
I've been using the following conventions for markup in the writing.  The
goal is to avoid idiosyncratic markup for font styles, etc. in the text
(e.g., `\texttt{}`, `textbf{}`) so that the style of a given symbol type can
be changed globally by editing `inputs/commands.tex`.

### Math commands

* Many shorthands for mathematical notation in LaTeX, e.g., `\mat{X}`, `\vec{v}`, `\diag{M}`, etc. 
* In particular, matrices and vectors are defined to use boldmath, `\bm{}`, e.g., `\mat{X}` gives **X**.
* many of these use `\ensuremath`, so they can be used directly in text w/o `$$`.
* `\Bin`, `\Pois`, `\NBin` etc. defined as mathematical operators

### Labels and cross-references

* Prefixes for Chapter (`ch:`), section (`sec:`) labels 
* Prefixes for Figure (`fig:`), table (`tab:`) labels
* Equation labels: `eq:`
* `inputs/commands.tex` defines a complete set of macros for references to these, e.g., `\secref{sec:}`, `\figref{fig:}`, `tabref{tab:}`, `\exref{ex:}`, `\eqref{eq:}` etc.
* Also ranges and lists of references, like `\figrange{fig:one}{fig:three}`, producing `Figures~\ref{#1}--\ref{#2}`
* Examples: automatically generate a lable of the form `ex:exname`, so use `exref{ex:exname}` to cross-reference.
* Exercises: automatically generate a label of the form `lab:ch.ex`, so use `labref{lab:ch.ex}` to cross-reference


In the draft version of the text, I'm using `\usepackage{showlabels}` to print these labels.

### R code

* R code in the text: `\code{x <- 0:3}`.  Need to escape special characters or use `\verb|DF$x|`
* I haven't been able to find a LateX re-definition of `\code{}` that avoids the need to escape special characters.
* Functions named in the text: `\func{array}`.  These will print as "array()" in the text and will be automatically indexed. Need to escape special characters, e.g., `\func{Ord\_plot}`.
* R packages: `\pkg{vcd}` or `\Rpackage{vcd}`, the latter producing "vcd package". Automatically indexed.
* Data sets:  Use `\data{HorseKicks}` to mention a data set. Will be automatically indexed.

### Indexing
In addition to the automatic indexing for R stuff in the main index, I use some shorthands:

* `\term{}` - main introduction of a technical word or phrase; prints the term in '\textbf{}` and adds it to the index
* `\ix{}` - add an index entry
* `\IX{}` - insert the term in the text and add an index entry
* `\ixmain{}` - flag an index entry as the main entry (printed in bold)
* `\ixon{}` and `\ixoff{}` to start and end the indexing of a topic spanning multiple pages

Other indexes:  

* Example index: index entries created automatically by the Example environment. To update this, need to run

```
makeindex -o book.ine book.ide
```

* Author index: The author index can be re-created from the `book.aux` file using the following command:

```
perl authorindex book
```



### Common abbreviations

* I use `\etal`, `\loglin`, `\ctab`, `\scat` and other abbreviations to both save typing and ensure consistency in the text.

### Authors notes, etc

* I am using `\TODO{}` to flag work to be done, either in the writing or the software
* I mark them as `\DONE{}` when accomplished.
* Both of these can easily be turned into no-ops to ignore the text, as noted in `commands.tex`.

### Exercises

An impoprtant feature of the book for marketing purposes is the inclusion of lab exercises for each chapter.  These are now marked up as follows:
```
\begin{Exercises}
  \exercise
  \exercise
  \exercise \hard
  ...
\end{Exercises}
```

Each `\excercise` automatically generates a label, of the form `\label{lab:ch.ex}` that can be referenced in the text.
This is dangerous, because inserting a new excercise in the middle of a list will change all subsequent numbers. It is
probably better to use explicit labels, like
```
\begin{Exercises}
  \exercise \label{lab:ch09-iris}
  \exercise \label{lab:ch09-foo}
  \exercise \label{lab:ch09-bar} \hard
  ...
\end{Exercises}
```

There are quite a few LaTeX packages that support such exercises, and also allow including hints and solutions in the text.  It would be good to find one that we can use and re-do the markup of exercises.

Compilation
-----------

I'll work on a proper `Makefile` for the project, but there is a rudimentary `Make.R` file in the project root directory
containing the following main steps:

```
setwd(VCDR)
knitr::knit2pdf(input = 'book.Rnw')
# may need to run BibTeX again sometimes... followed by pdflatex at the end
system("bibtex book")
# make other indices: example index, author index
system("makeindex -o book.ine book.ide")
system("perl authorindex -h")
# create references.bib from separate bib files under local texmf tree
system("perl aux2bib book")
system("pdflatex book")
```
