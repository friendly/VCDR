data("HorseKicks")
data("Federalist")
data("Butterfly")
data("WomenQueue")

ord <- Ord_plot(Butterfly, main = "Butterfly species collected in Malaya", 
                gp=gpar(cex=1), pch=16)
ord

Ord_plot(HorseKicks, main = "Death by horse kicks", gp=gpar(cex=1), pch=16)
Ord_plot(Federalist, main = "Instances of 'may' in Federalist papers", gp=gpar(cex=1), pch=16)
Ord_plot(WomenQueue, main = "Women in queues of length 10", gp=gpar(cex=1), pch=16)

# illustrate calculation -- 

data(HorseKicks, package="vcd")
nk <- as.vector(HorseKicks)
k <- as.numeric(names(HorseKicks))
nk1 <- c(NA, nk[-length(nk)])
y <- k * nk/nk1
weight = sqrt(pmax(nk, 1) - 1)
(ord.df <- data.frame(k, nk, nk1, y, weight))
coef(lm(y ~ k, weights=weight, data=ord.df))



# example from ?Ord_plot
grid.newpage()
pushViewport(viewport(layout = grid.layout(2, 2)))

pushViewport(viewport(layout.pos.col=1, layout.pos.row=1))
Ord_plot(HorseKicks, main = "Death by horse kicks", newpage = FALSE)
popViewport()

pushViewport(viewport(layout.pos.col=1, layout.pos.row=2))
Ord_plot(Federalist, main = "Instances of 'may' in Federalist papers", newpage = FALSE)
popViewport()

pushViewport(viewport(layout.pos.col=2, layout.pos.row=1))
Ord_plot(Butterfly, main = "Butterfly species collected in Malaya", newpage = FALSE)
popViewport()

pushViewport(viewport(layout.pos.col=2, layout.pos.row=2))
Ord_plot(WomenQueue, main = "Women in queues of length 10", newpage = FALSE)
popViewport(2)

