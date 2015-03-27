library(ggtern)
# Based of random data.
DATA <- data.frame(A = runif(100), B = runif(100), C = runif(100))
plot <- ggtern(data = DATA,
               mapping = aes(x = A, y = B, z = C)) +
        geom_point()
plot

# example from http://ggtern.com/2013/12/12/patched-density-functions-2/

suppressMessages(library(ggtern))
set.seed(1)
DATA <- data.frame(x = runif(100), 
                   y = runif(100), 
                   z = runif(100))
plot <- ggtern(data = DATA,
               aes(x, y, z))
plot + stat_density2d(method = "lm", fullrange = T,
                      n = 200, geom = "polygon",
                      aes(fill = ..level..,
                          alpha = ..level..)) +
    geom_point() +
    theme_tern_rgbw() +
    labs(title = "Uniform data with density contours")    +
    scale_fill_gradient(low = "blue",high = "red")  +
    guides(color = "none", fill = "none", alpha = "none")


##################################################

# illustrative example

library(ggtern)
DATA <- data.frame(
	A = c(40, 20, 10),
	B = c(30, 60, 10),
	C = c(30, 20, 80),
	id = c("1", "2", "3"))
#plt <-
#ggtern(data = DATA,
#       mapping = aes(x = A, y = B, z = C, label=id, colour=id)) +
#    geom_point(aes(size=2)) +
#    geom_text(vjust=-.5, size=8) +
#    theme_tern_rgbw() +
#    theme(plot.margin=unit(c(0,0,0,0),"mm") +
#    guides(size = "none")  
#plt
## reduce plot margin; not quite a tight bounding box
#plt + theme(plot.margin=unit(c(0,0,0,0),"mm"))

ggtern(data = DATA,
       mapping = aes(x=C, y=A, z=B, colour = id)) +
    geom_point(size=4) +
    geom_text(vjust=-.5, size=8, aes(label=id), show_guide=FALSE) +
    theme_rgbw() +
    theme(plot.margin=unit(c(0,0,0,0),"mm"))

#ggtern(data = DATA,
#       mapping = aes(x=C, y=A, z=B,
#                     label=id, colour=id)) +
#    geom_point(size=2) +
#    geom_text(vjust=-.5, size=8) +
#    theme_rgbw() +
#    theme(plot.margin=unit(c(0,0,0,0),"mm")) +
#    guides(size = "none")
