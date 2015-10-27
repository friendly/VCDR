# from http://biostat.mc.vanderbilt.edu/wiki/Main/KnitrHowto

# this from Frank Harrell -- no longer useful.  Remove all uses
spar <- function(mar=if(!axes)
                 c(2.25+bot-.45*multi,2+left,.5+top+.25*multi,.5+rt) else
                 c(3.25+bot-.45*multi,3.5+left,.5+top+.25*multi,.5+rt),
                 lwd = if(multi) 1 else 1.75,

                 # The margin line (in mex units) for the axis title, axis labels and axis line. 
  # Note that mgp[1] affects title whereas mgp[2:3] affect axis. The default is c(3, 1, 0).
                 mgp = if(!axes) mgp=c(.75, .1, 0) else
                 if(multi) c(1.5, .365, 0) else c(2.4-.4, 0.475, 0),
  # length of tick marks
                 tcl = if(multi)-0.25 else -0.4, 
                 xpd=FALSE,
                 bot=0, left=0, top=0, rt=0, 
  # point size of text
                 ps=if(multi) 14 else 10,
                 mfrow=NULL, axes=TRUE, ...) {
  multi <- length(mfrow) > 0
  op <- par(mar=mar, lwd=lwd, mgp=mgp, tcl=tcl, ps=ps, xpd=xpd, ...)
  if(multi) op <- par(mfrow=mfrow)
  invisible(op)
}
##################################################################################
# knitrSet is called once at the beginning of each chapter to set defaults
# for all chunks in that chapter

knitrSet <- function(basename=NULL, w=4, h=3,
                     fig.align='center', fig.show='hold', fig.pos='!htbp',
                     fig.lp='fig:', 
                     dev='pdf',
                     tidy=FALSE, 
                     error=FALSE,
                     cache=FALSE,
                     width=65,
                     digits=5,
                     decinline=5, 
                     keep.source=TRUE) {
  ## Specify dev=c('pdf','png') to produce two graphics files for each plot
  ## But: dev='CairoPNG' is preferred for png

  require(knitr)

# use CMYK for PDF graphs
  grDevices::pdf.options(colormodel = "cmyk")

# set names of input directory and name of current input file:
#  in_dir <- knitr:::knitEnv$input_dir
  in_file <- knitr:::knit_concord$get("infile")
  
  options(width=width, digits=digits)

	## How to render output? - default is render_latex()
#	render_latex()      # uses alltt package
#  render_listings()  # uses listings package, with shaded background

  opts_knit$set(out.format = "latex")
  #knit_theme$set("default")
  #knit_theme$set("print")      # for only b/w, with bold highlighing
  #knit_theme$set("seashell")    # light salmon background color
  
	## re-direct warning messages to messages.txt
#  unlink('messages.txt') # Start fresh with each run-- now in book.Rnw & chapter.Rnw
  hook_log = function(x, options) cat(x, file='messages.txt', append=TRUE)
  knit_hooks$set(warning = hook_log, message = hook_log)# , error = hook_lst_bf)
  cat("** Chapter ", basename, " **\n", file='messages.txt', append=TRUE )

  ## this did not allow for character strings!!
#   if(length(decinline)) {
#     rnd <- function(x, dec) round(x, dec)
#     formals(rnd) <- list(x=NULL, dec=decinline)
#     knit_hooks$set(inline = rnd)
#   }

  inline_hook <- function(x) {
    if(length(decinline)) dec <- decinline else 2
    if(is.numeric(x)) x <- round(x, dec)
    paste(as.character(x), collapse=", ")
  }
  knit_hooks$set(inline = inline_hook)

# Allow use of crop=TRUE in figure chunks to invoke pdfcrop.
  if (!Sys.which('pdfcrop')=="")
    knit_hooks$set(crop=hook_pdfcrop)
  
  knit_hooks$set(par=function(before, options, envir)
                 if(before && options$fig.show != 'none') {
#                    p <- c('bty','mfrow','ps','bot','top','left','rt','lwd',
#                           'mgp','tcl', 'axes','xpd')
#                    pars <- opts_current$get(p)
#                    pars <- pars[!is.na(names(pars))]
#                    if(length(pars)) do.call('spar', pars) else spar()
                 })

  opts_knit$set(aliases=c(h='fig.height', w='fig.width',
                  cap='fig.cap', scap='fig.scap'),
                eval.after = c('fig.cap','fig.scap'),
                error=error, keep.source=keep.source
#                comment=NA, prompt=TRUE
                )

# suggestion of reviewer: make R output look more 'normal'
# maybe we should also dispense with code highlighting
#  opts_knit$set(comment=NA, prompt=TRUE)

  opts_chunk$set(fig.path=paste0(basename, '/fig/'), 
                 fig.align=fig.align, w=w, h=h,
                 fig.show=fig.show, fig.lp=fig.lp, fig.pos=fig.pos,
                 cache.path=paste0(basename, '/cache/'),
                 cache=cache,
                 dev=dev, par=TRUE, tidy=tidy, 
                 comment=NA, prompt=TRUE,
                 out.width=NULL)

  hook_chunk = knit_hooks$get('chunk')
  ## centering will not allow too-wide figures to go into left margin
  knit_hooks$set(chunk = function(x, options) { 
    res = hook_chunk(x, options) 
    if (options$fig.align != 'center') return(res) 
    gsub('\\{\\\\centering (\\\\includegraphics.+)\n\n\\}', 
         '\\\\centerline{\\1}', res) 
  })
  
  # modify knitr output hook to allow an optional output.lines option
  # this follows from the knitr book, p. 118, \S 12.3.5
  # but that does it globally.  As well, the option should be called
  # output.lines, because out.* options generally pertain to figures.
  
  # a more general version would also allow output.lines to be a
  # vector of integers, as in output.lines=3:15, selecting those numbered lines, 
  # as with echo=
  
  # NB: this code has a dependency on stringr, but that is a knitr
  # Depends:
  
  # get the default output hook
#  hook_output <- knit_hooks$get("output")
#  
#  knit_hooks$set(output = function(x, options) {
#    lines <- options$output.lines
#    if (is.null(lines)) {
#      hook_output(x, options)  # pass to default hook
#    }
#    else {
#      x <- unlist(stringr::str_split(x, "\n"))
#      if (length(x) > lines) {
#        # truncate the output, but add ....
#        x <- c(head(x, lines), "...\n")
#      }
#      # paste these lines together
#      x <- paste(x, collapse = "\n")
#      hook_output(x, options)
#    }
#  })

  # knitr hook function to allow an output.lines option
  # e.g., 
  #   output.lines=12 prints lines 1:12 ...
  #   output.lines=1:12 does the same
  #   output.lines=3:15 prints lines ... 3:15 ...
  #   output.lines=-(1:8) removes lines 1:8 and prints ... 9:n ...
  #   No allowance for anything but a consecutive range of lines

  hook_output <- knit_hooks$get("output")
  knit_hooks$set(output = function(x, options) {
     lines <- options$output.lines
     if (is.null(lines)) {
       return(hook_output(x, options))  # pass to default hook
     }
     x <- unlist(strsplit(x, "\n"))
     more <- "..."
     if (length(lines)==1) {        # first n lines
       if (length(x) > lines) {
         # truncate the output, but add ....
         x <- c(head(x, lines), more)
       }
     } else {
       x <- c(if (abs(lines[1])>1 | lines[1]<0) more else NULL, 
              x[lines], 
              if (length(x)>lines[abs(length(lines))]) more else NULL
             )
     }
     # paste these lines together
     x <- paste(c(x, ""), collapse = "\n")
     hook_output(x, options)
   })

  # http://stackoverflow.com/questions/23349525/how-to-set-knitr-chunk-output-width-on-a-per-chunk-basis
  # NO: now use chunk option R.options=list(width=) in knitr 1.6+
#   knit_hooks$set(output.width=local({
#     .width <- 0
#     function(before, options, envir) {
#       if (before) .width <<- options(width=options$width)
#       else options(.width)
#     }
#   })
#   )

  
}
## see http://yihui.name/knitr/options#package_options

## Use caption package options to control caption font size