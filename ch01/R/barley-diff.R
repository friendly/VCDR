data(barley, package="lattice")
head(barley, 30)

#
library(ggplot2)
gg <- ggplot(data=barley, aes(x=yield, y=variety, color=year)) +
  geom_point() + 
  facet_wrap(~site)

gg

ggplot(barley, aes(x = variety, y = yield, color = year)) +
   geom_point() +
   geom_line(aes(group = year)) +
   coord_flip() +
   facet_wrap(~ site) 



# yield differences
yield <- array(barley$yield, c(6, 10, 2))
#dimnames(yield)[[1]] <- levels(barley$site)
#dimnames(yield)[[2]] <- levels(barley$variety)
#dimnames(yield)[[3]] <- levels(barley$year)
#names(dimnames(yield)) <- c("site", "variety", "year")

dimnames(yield) <- list(
  site = levels(barley$site),
  variety = levels(barley$variety),
  year = levels(barley$year))

str(yield)

diff <- t(yield[,,2] - yield[,,1])
cord <- order(colMeans(diff))
rord <- order(rowMeans(diff))

round(colMeans(diff), 1)
round(rowMeans(diff), 1)

round(diff[rord,cord])

