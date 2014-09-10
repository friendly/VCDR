library(vcdExtra)
data("ICU", package="vcdExtra")

# remove redundant variables (race, coma)
ICU <- ICU[,-c(4, 20)]


head(icu.fit)

# combine categorical risk factors to a single string
risks <- ICU[, c("cancer", "admit", "uncons")]
risks[,1] <- ifelse(risks[,1]=="Yes", "Cancer", "")
risks[,2] <- ifelse(risks[,2]=="Emergency", "Emerg", "")
risks[,3] <- ifelse(risks[,3]=="Yes", "Uncons", "")
risks <- apply(risks, 1, paste, collapse="")
risks[risks==""] <- "(none)"

table(risks)

table(ICU$died, risks)

icu.glm2 <- glm(died ~ age + cancer  + admit + uncons, data=ICU, family=binomial)
icu.fit <- cbind(ICU, predict(icu.glm2, se=TRUE), risks)  
#icu.fit$risks <- risks

# plot on logit scale
gg <- ggplot( icu.fit, aes(x=age, y=fit, color=risks)) +               
  geom_line(size = 1.2) + theme_bw() +
  geom_ribbon(aes(ymin = fit - se.fit,
                  ymax = fit + se.fit,
                  fill = risks), alpha = 0.2,
              color = "transparent") +
  theme_bw() + 
  labs(x = "Age", y = "Log odds (died)") +
  geom_point(size=2)
gg

# plot on prob scale
gg2 <- ggplot( icu.fit, aes(x=age, y=plogis(fit), color=risks)) +               
  geom_line(size = 1.2) + theme_bw() +
  geom_ribbon(aes(ymin = plogis(fit - se.fit),
                  ymax = plogis(fit + se.fit),
                  fill = risks), alpha = 0.2,
              color = "transparent") +
  labs(x = "Age", y = "Probability (died)") +
  geom_point(size=2) 
  
gg2

library(directlabels)
direct.label(gg+xlim(10,100), last.points)
