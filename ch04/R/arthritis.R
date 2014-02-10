# \S 4.2

data("Arthritis", package="vcd")
Art.tab <- xtabs(~Treatment + Improved, data=Arthritis)
Art.tab
#prop.table(Art.tab, margin=1)
round(100*prop.table(Art.tab, margin=1), 2)
assocstats(Art.tab)

CMHtest(Art.tab)

# \S 4.3
Art.tab2 <- xtabs(~Treatment + Improved + Sex, data=Arthritis)
Art.tab2
assocstats(Art.tab2[,,1])  # female
assocstats(Art.tab2[,,2])  # male

apply(Art.tab2, MARGIN=3, FUN=assocstats)
CMHtest(Art.tab2)


# testing homogeneity of association: no 3-way

loglm(~ (1+2+3)^2, data=Art.tab2)

loglm(~ (Treatment + Improved + Sex)^2, data=Art.tab2)

# sieve diagram -- show similar pattern for M/F
sieve(Art.tab2, condvars="Sex", shade=TRUE)
