chapters <- sprintf("ch%02d", 1:12)
includeonly = c("ch01", "ch02", "ch03")

includes = function(file) {
  if (file %in% includeonly) paste0(file, '.Rnw')
}

## use as:
##<<ch1, child=includes('ch01')>>=
