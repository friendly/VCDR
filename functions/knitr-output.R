# knitr hook function to allow an output.lines option
# e.g., 
#   output.lines=12 prints lines 1:12
#   output.lines=3:15 prints lines 3:15

hook_output <- knit_hooks$get("output")

knit_hooks$set(output = function(x, options) {
    lines <- options$output.lines
    if (is.null(lines)) {
      hook_output(x, options)  # pass to default hook
    }
    else {
      x <- unlist(stringr::str_split(x, "\n"))
      more <- "...\n"
      if (length(lines)==1) {        # first n lines
	      if (length(x) > lines) {
	        # truncate the output, but add ....
	        x <- c(head(x, lines), more)
	      }
	    }
	    else {
	    	x <- c(more, x[lines], more)
	    }
      # paste these lines together
      x <- paste(x, collapse = "\n")
      hook_output(x, options)
    }
  })
