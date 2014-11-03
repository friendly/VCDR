# demonstrate stacking with structable

set.seed(1234)
dim <- c(3, 2, 2, 2)
tab <- array(rpois(prod(dim), 15), dim=dim)
dimnames(tab) <- list(Pet=c("dog","cat","bird"), 
                      Age=c("young","old"), 
                      Color=c("black", "white"), 
                      Sex=c("male", "female"))

ftable(Pet + Age ~ Color + Sex, tab)
# stack 
as.matrix(ftable(Pet + Age ~ Color + Sex, tab))

tab.df <- as.data.frame(as.table(tab))
tab.df <- within(tab.df, 
		{Pet.Age = interaction(Pet,Age)
		 Color.Sex = interaction(Color,Sex)
    })               
xtabs(Freq ~ Color.Sex + Pet.Age, data=tab.df)


