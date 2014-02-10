data("alzheimer", package = "coin")
alz <- xtabs(~ smoking + disease + gender, data = alzheimer)
dimnames(alz)[[2]] <- c("Alzheimer's", "Dementia", "Other")
names(dimnames(alz)) <- c("Smoking", "Disease", "Gender")

# encapsulate options ...
alz_cotab <- cotab_coindep(alz, condvars = "Gender", n = nrep, margins = c(2, 1, 1, 2),
    varnames = FALSE)

cotabplot(~ Smoking + Disease | Gender, data = alz, panel = alz_cotab)

