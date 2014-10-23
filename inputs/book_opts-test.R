<<book-opts, include=FALSE>>=
book_opts <- list(localbibs=TRUE, 
                  showlabels=TRUE)
@

<<show-refs, result='asis'>>=
if (book_opts$showlabels) cat('\usepackage{showlabels}\n')
@

<<set-bibs, result='asis'>>=
if (book_opts$localbibs) cat('\\bibliography{graphics,statistics,timeref,Rpackages}\n') else
      cat('\\bibliography{references}\n')
@