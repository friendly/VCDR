data("Lifeboats", package="vcd")
library(ggtern)
Lifeboats$id <- ifelse((Lifeboats$men/Lifeboats$total) > .1, 
                        as.character(Lifeboats$boat), "")

plt <- ggtern(data = Lifeboats, 
               mapping = aes(x = women, y = men, z = crew, colour=side, shape=side, label=id)) +
       theme_tern_rgbw() +
       geom_point(aes(size=2)) +
       labs(title = "Lifeboats on the Titanic") +
       labs(T="Women and children") +
       guides(size = "none") +
       geom_smooth(method="lm", size=1.5, aes(fill=side)) +
       geom_text(vjust=1, color="black") 
plt
plt + theme(plot.margin=unit(c(0,0,0,0),"mm")) # reduce margins

# code for book
ggtern(data = Lifeboats, 
       mapping = aes(x = women, y = men, z = crew, colour=side, shape=side, label=id)) +
     theme_tern_rgbw() +
     theme(plot.margin=unit(c(0,0,0,0),"mm")) +
     geom_point(aes(size=2)) +
     labs(title = "Lifeboats on the Titanic") +
     labs(T="Women and children") +
     guides(size = "none") +
     geom_smooth(method="lm", size=1.5, aes(fill=side)) +
     geom_text(vjust=1, color="black") 


ggplot(data = Lifeboats, aes(x=launch, y=total, colour=side,  label=boat)) +
     geom_smooth(method="lm", aes(fill=side), size=1.2) +
     geom_smooth(method="loess", aes(fill=side), se=FALSE, size=1.5) +
     geom_point() + ylim(c(0,100))
     geom_text(vjust=-.5, color="black") +
     labs(y="Total number loaded", x="Launch time")

# look at percent of capacity loaded

Lifeboats$pctloaded <- 100 * Lifeboats$total / Lifeboats$cap

ggplot(data = Lifeboats, aes(x=launch, y=pctloaded, colour=side,  label=boat)) +
     geom_smooth(method="lm", aes(fill=side), size=1.2) +
     geom_smooth(method="loess", aes(fill=side), se=FALSE, size=1.5) +
     geom_point() + # ylim(c(0,100)) +
     geom_text(vjust=-.5, color="black") +
     labs(y="Percent loaded", x="Launch time")
