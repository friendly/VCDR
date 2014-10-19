library(lattice)
data("iris", package="datasets")

#vnames <- c("Sepal\nLength", "Sepal\nWidth", "Petal\nLength", "Petal\nWidth")

vnames <- gsub("\\.", "\\\n", names(iris)) 
key = list(
         columns = 3, title="Species",
         lines = list(col=c("red", "blue", "green3"), lwd=4),
         col=c("red", "blue", "green3"),
         text = list(c("Setosa", "Versicolor", "Virginica")))

# default variable order
parallelplot(~iris[1:4], data=iris, groups = Species,
	varnames = vnames[1:4], key=key,
  horizontal.axis = FALSE, lwd=4,
  col=c("red", "blue", "green3"))


# effect of order of variables
parallelplot(~iris[c(1,3,4,2)], data=iris, groups = Species,
	varnames = vnames[c(1,3,4,2)], key=key,
  horizontal.axis = FALSE, lwd=8, 
  col=c(rgb(1,0,0,.2), rgb(0,0,1,.2), rgb(0,205/255,0,.2) ))
