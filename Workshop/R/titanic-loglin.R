# Exercises: survival on the titanic, using loglm()

data(Titanic, package="datasets")  # effects::Titanic gives a case-form version

Titanic <- Titanic + 0.5   # adjust for 0 cells
titanic.mod1 <- loglm(~ (Class * Age * Sex) + Survived, data=Titanic)
titanic.mod1
plot(titanic.mod1, main="Model [AGC][S]")

titanic.mod2 <- loglm(~ (Class * Age * Sex) + Survived*(Class + Age + Sex), data=Titanic)
titanic.mod2
plot(titanic.mod2,  main="Model [AGC][AS][GS][CS]")

titanic.mod3 <- loglm(~ (Class * Age * Sex) + Survived*(Class + Age * Sex), data=Titanic)
titanic.mod3
plot(titanic.mod3, ,  main="Model [AGC][AS][GS][CS][AGS]")

# compare models
anova(titanic.mod1, titanic.mod2, titanic.mod3, test="chisq")



