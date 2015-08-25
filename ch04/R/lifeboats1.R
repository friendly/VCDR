# new version, using  ggtern_1.0.6.0, ggplot2_1.0.1
# requires some clipping on top, bottom

data("Lifeboats", package="vcd")
library(ggtern)
Lifeboats$id <- ifelse((Lifeboats$men/Lifeboats$total) > .1, 
                        as.character(Lifeboats$boat), "")

plt <- ggtern(data = Lifeboats, 
               mapping = aes(x = women, y = men, z = crew, colour=side, shape=side, label=id)) +
       theme_rgbw() +
       geom_point(size=2) +
       labs(title = "Lifeboats on the Titanic") +
       labs(T="Women and children") +
       geom_smooth_tern(method="lm", size=1.5, alpha=.25, aes(fill=side)) +
       geom_text(vjust=1, color="black") +
       theme(legend.position=c(.85, .85), axis.tern.vshift=unit(5,"mm"))

ggsave("lifeboats1a.pdf")

