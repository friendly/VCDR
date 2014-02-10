library(lattice)
data("iris", package="datasets")

#vnames <- c("Sepal\nLength", "Sepal\nWidth", "Petal\nLength", "Petal\nWidth")

vnames <- gsub("\\.", "\\\n", names(iris)) 
key = list(
         columns = 3, 
         lines = list(col=c("red", "blue", "green3"), lwd=4),
         col=c("red", "blue", "green3"),
         text = list(c("Setosa", "Versicolor", "Virginica")))

parallelplot(~iris[1:4], data=iris, groups = Species,
	varnames = vnames[1:4], key=key,
  horizontal.axis = FALSE, lwd=2, 
  col=c("red", "blue", "green3"))

# thicker line width
parallelplot(~iris[1:4], data=iris, groups = Species,
	varnames = vnames[1:4],
  horizontal.axis = FALSE, lwd=4,
  col=c("red", "blue", "green3"))

#  use alpha-blennding
parallelplot(~iris[1:4], data=iris, groups = Species,
	varnames = vnames[1:4], key=key,
  horizontal.axis = FALSE, lwd=8, 
  col=c(rgb(1,0,0,.2), rgb(0,0,1,.2), rgb(0,205/255,0,.2) )
  )

# also showing species
parallelplot(~iris[1:5], data=iris, groups = Species,
	varnames = vnames, key = key,
  horizontal.axis = FALSE, lwd=8, 
  col=c(rgb(1,0,0,.2), rgb(0,0,1,.2), rgb(0,205/255,0,.2) )
  )

# make ordered factors
iris2 <- within(iris, {
   sepalL <- cut(Sepal.Length, 3)
   sepalW <- cut(Sepal.Width, 3)
   petalL <- cut(Petal.Length, 3)
   petalW <- cut(Petal.Width, 3)
   })

# 
parallelplot(~iris2[6:9], data=iris2, groups = Species,
	varnames = vnames[1:4],
  horizontal.axis = FALSE, lwd=8, key=key,
  col=c(rgb(1,0,0,.2), rgb(0,0,1,.2), rgb(0,205/255,0,.2) )
  )

# effect of order of variables
parallelplot(~iris[c(1,3,4,2)], data=iris, groups = Species,
	varnames = vnames[c(1,3,4,2)], key=key,
  horizontal.axis = FALSE, lwd=8, 
  col=c(rgb(1,0,0,.2), rgb(0,0,1,.2), rgb(0,205/255,0,.2) )
  )
    