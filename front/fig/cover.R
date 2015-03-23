library(vcd)
grid.newpage()
pushViewport(viewport(layout = grid.layout(3,3)))

## diagonal entries: text
pushViewport(viewport(layout.pos.col = 1, layout.pos.row = 1))
grid.text("Discrete", gp = gpar(fontsize = 36))
popViewport()
pushViewport(viewport(layout.pos.col = 2, layout.pos.row = 2))
grid.text("Data", gp = gpar(fontsize = 36))
popViewport()
pushViewport(viewport(layout.pos.col = 3, layout.pos.row = 3))
grid.text("Analysis", gp = gpar(fontsize = 36))
popViewport()

hec <- margin.table(HairEyeColor, 1:2)

## mosaic
pushViewport(viewport(layout.pos.col = 1, layout.pos.row = 2))
mosaic(hec, shade = TRUE, newpage = FALSE, legend = FALSE, labels = FALSE, margins = 0.5)
popViewport()

## assoc plot
pushViewport(viewport(layout.pos.col = 2, layout.pos.row = 1))
assoc(hec, shade = TRUE, newpage = FALSE, legend = FALSE, labels = FALSE, margins = 0.5)
popViewport()

## sieve plot
pushViewport(viewport(layout.pos.col = 2, layout.pos.row = 3))
sieve(hec, shade = TRUE, newpage = FALSE, legend = FALSE, labels = FALSE, margins = 0.5)
popViewport()

## agreement plot
pushViewport(viewport(layout.pos.col = 1, layout.pos.row = 3))
agreementplot(hec, newpage = F, margins = 0.5, xlab = "", ylab = "",
              xscale = F, yscale = F, gp = gpar(fontsize = 0))
popViewport()

## ternary plot
pushViewport(viewport(layout.pos.col = 3, layout.pos.row = 1))
suppressMessages(library(ggtern))
set.seed(1)
DATA <- data.frame(x = runif(100), 
                   y = runif(100), 
                   z = runif(100))
plot <- ggtern(data = DATA,
               aes(x, y, z))
plot <- plot + stat_density2d(method = "lm", fullrange = T,
                      n = 200, geom = "polygon",
                      aes(fill = ..level..,
                          alpha = ..level..)) +
#    geom_point() +
#    theme_tern_rgbw() +
    theme(plot.margin = unit(c(0,0,0,0), "npc"),
          axis.tern.padding = unit(0.2, "npc")) +
    scale_fill_gradient(low = "blue",high = "red") +
    guides(color = "none", fill = "none", alpha = "none")
print(plot, newpage = F)
popViewport()

## fourfold
pushViewport(viewport(layout.pos.col = 3, layout.pos.row = 2))
fourfold(margin.table(UCBAdmissions, 1:2), newpage = F)
popViewport()
