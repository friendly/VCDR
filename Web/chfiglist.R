figrow <- '
<div class="row">
  <h3>Selected figures</h3>

</div> <!-- row -->
'

media_list_begin <- '
  <div class="col-md-12">
    <ul class="media-list">
'

media_list_end <- '
    </ul> <!-- media-list -->
  </div> <!-- col-md-12 -->
'

media_item <- '
      <li class="media">
        <div class="media-left">
          <a href="#">
            <img class="media-object" src="%file%" width="250" alt="...">
          </a>
        </div>
        <div class="media-body">
          <h4 class="media-heading">Figure %fignum%</h4>
          %caption%
        </div>
      </li>
'

library(stringr)
library(gtools)

dir <- "C:/Dropbox/Documents/DDAR/pages/chapters/"

figfiles <- function(ch) {
	mixedsort(list.files(paste0(dir, sprintf("ch%02d", ch))))
}


one_fig <- function(file) {
	fignum <- unlist(str_split(file, '-'))[1]
	fignum <- sub('_', '.', fignum, fixed=TRUE)
	text <- sub("%file%", file, media_item, fixed=TRUE)
	text <- sub("%fignum%", fignum, text, fixed=TRUE)
	text
}

do_chapter <- function(ch) {
	ffnames <- figfiles(ch)
	figlist <- rep("", length(ffnames))
	for (i in seq_along(ffnames)) {
		figlist[i] <- one_fig(ffnames[i])
	}
	figlist <- c(media_list_begin, figlist, media_list_end)
	text <- sapply(figlist, cat)
	text
}
