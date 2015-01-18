# barplots, spineplots and tile plots

# what's wrong with barplots?
HE <- margin.table(HairEyeColor, 2:1)  # as in Table 4.2
barplot(HE, xlab="Hair color", ylab="Frequency")
#barplot(t(HE), xlab="Eye color", ylab="Frequency")

# why spineplots are better
#spineplot(HE)
spineplot(t(HE))

# which tile plot(s)?
tile(HE)
tile(HE, tile_type="width")
tile(HE, tile_type="height")

# many other variations in fluctile()
library(extracat)
fluctile(HE)



