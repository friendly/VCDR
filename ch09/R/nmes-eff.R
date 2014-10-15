
data("NMES1988", package="AER")
nmes2 <- NMES1988[, c(1:4, 6:8, 13, 15, 18)]
str(nmes2)

library(MASS)

nmes2.nbin1 <- glm.nb(visits ~ hospital + health + chronic + gender + school + insurance, data = nmes2)
nmes2.nbin2 <- glm.nb(nvisits ~ hospital + health + chronic + gender + school + insurance, data = nmes2)
nmes2.nbin3 <- glm.nb(ovisits ~ hospital + health + chronic + gender + school + insurance, data = nmes2)
nmes2.nbin4 <- glm.nb(novisits ~ hospital + health + chronic + gender + school + insurance, data = nmes2)

library(effects)

eff1 <- allEffects(nmes2.nbin1)
eff2 <- allEffects(nmes2.nbin2)
eff3 <- allEffects(nmes2.nbin3)
eff4 <- allEffects(nmes2.nbin4)

plot(eff1)
plot(eff2)
plot(eff3)
plot(eff4)

pdf(file="nmes-eff-health.pdf", h=6, w=4, onefile=TRUE)
plot(eff1["health"], main="visits: health effects", ylab="Physician office visits")
plot(eff2["health"], main="nvisits: health effects", ylab="Non-physician office visits")
plot(eff3["health"], main="ovisits: health effects", ylab="Physician hospital visits")
plot(eff4["health"], main="novisits: health effects", ylab="Non-hysician hospital visits")
dev.off()


# add interactions
nmes2.nbin1 <- update(nmes2.nbin1, . ~ . + (health+chronic+hospital)^2 + health:school )
nmes2.nbin2 <- update(nmes2.nbin2, . ~ . + (health+chronic+hospital)^2 + health:school )
nmes2.nbin3 <- update(nmes2.nbin3, . ~ . + (health+chronic+hospital)^2 + health:school )
nmes2.nbin4 <- update(nmes2.nbin4, . ~ . + (health+chronic+hospital)^2 + health:school )

eff1 <- allEffects(nmes2.nbin1)
eff2 <- allEffects(nmes2.nbin2)
eff3 <- allEffects(nmes2.nbin3)
eff4 <- allEffects(nmes2.nbin4)

plot(eff1, multiline=TRUE)
plot(eff2, multiline=TRUE)
plot(eff3, multiline=TRUE)
plot(eff4, multiline=TRUE)

# plot insurance effect for all 4 responses 
plot(eff1[2])
plot(eff2[2])
plot(eff3[2])
plot(eff4[2])

