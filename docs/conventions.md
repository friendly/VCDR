## Conventions

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
