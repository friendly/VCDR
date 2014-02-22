library(vcdExtra)

data("Cancer", package="vcdExtra")


mosaic3d(Cancer)

# reproduce the view
par3d(zoom=.8)
#M <- par3d("userMatrix")
M <-
structure(c(0.836400210857391, 0.158238977193832, -0.524780988693237, 
0, -0.547337055206299, 0.189991027116776, -0.815061688423157, 
0, -0.0292708333581686, 0.968949794769287, 0.245518609881401, 
0, 0, 0, 0, 1), .Dim = c(4L, 4L))
par3d(userMatrix=M)
snapshot3d("mos3d-cancer.png")

# more interesting mosaic with more shading levels
mosaic(aperm(Cancer), shade=TRUE, gp_args=(list(interpol=1:4)))


data("Bartlett", package="vcdExtra")

mosaic3d(Bartlett)
par3d(zoom=.8)

M <- structure(c(0.94417679309845, 0.0351246893405914, -0.327561259269714, 
0, -0.326185703277588, -0.0397212021052837, -0.944470822811127, 
0, -0.0461855791509151, 0.998593211174011, -0.02604672126472, 
0, 0, 0, 0, 1), .Dim = c(4L, 4L))

snapshot3d("mos3d-bartlett.png")
