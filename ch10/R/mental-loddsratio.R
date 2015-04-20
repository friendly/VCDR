#' ---
#' title: "Illustrate log odds ratio plots of fitted values"
#' author: "Michael Friendly"
#' date: "20 Apr 2015"
#' ---


data(Mental, package="vcdExtra")
library(vcd)
mental.tab <- xtabs(Freq ~ mental+ses, data=Mental)
mental.lor <- loddsratio(mental.tab)
mental.lor
plot(t(mental.lor), confidence=FALSE, legend_pos="bottomleft", ylim=c(-.4, .4))

# connection between log odds ratios and models
Cscore <- as.numeric(Mental$ses)
Rscore <- as.numeric(Mental$mental)

indep <- glm(Freq ~ mental + ses, data=Mental, family=poisson)

indep.fit <- matrix(fitted(indep), 4, 6, dimnames=dimnames(mental.tab))
#loddsratio(indep.fit)
round(as.matrix(loddsratio(indep.fit)), 2)

linlin <- update(indep, . ~ . + Rscore:Cscore)
linlin.fit <- matrix(fitted(linlin), 4, 6, dimnames=dimnames(mental.tab))
#loddsratio(linlin.fit)
round(as.matrix(loddsratio(linlin.fit)), 3)

roweff <- update(indep, . ~ . + mental:Cscore)
roweff.fit <- matrix(fitted(roweff), 4, 6, dimnames=dimnames(mental.tab))
#loddsratio(roweff.fit)
round(as.matrix(loddsratio(roweff.fit)), 3)
plot(t(loddsratio(roweff.fit)), confidence=FALSE, 
     legend_pos="bottomright", ylim=c(-.1, .3),
     main="log odds ratios for ses and mental, R model")

plot(loddsratio(roweff.fit), confidence=FALSE, 
     legend_pos="bottomright", ylim=c(-.1, .3),
     main="log odds ratios for ses and mental, R model")

coleff <- update(indep, . ~ . + Rscore:ses)
coleff.fit <- matrix(fitted(coleff), 4, 6, dimnames=dimnames(mental.tab))
#loddsratio(coleff.fit)
round(as.matrix(loddsratio(coleff.fit)), 3)
plot(t(loddsratio(coleff.fit)), confidence=FALSE, 
     legend_pos="bottomright", ylim=c(-.1, .3),
     main="log odds ratios for ses and mental, C model")

rowcol <- update(indep, . ~ . + Rscore:ses + mental:Cscore)
rowcol.fit <- matrix(fitted(rowcol), 4, 6, dimnames=dimnames(mental.tab))
#loddsratio(rowcol.fit)
round(as.matrix(loddsratio(rowcol.fit)), 3)
plot(t(loddsratio(rowcol.fit)), confidence=FALSE, 
     legend_pos="bottomright", ylim=c(-.1, .3),
     main="log odds ratios for ses and mental, R+C model")


