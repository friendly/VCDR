data(UKSoccer, package="vcd")

soccer.df <- as.data.frame(UKSoccer, stringsAsFactors=FALSE)

soccer.df <- within(soccer.df, 
	{
	Home <- as.numeric(Home)
	Away <- as.numeric(Away)
	Total <- Home + Away
	})

str(soccer.df)

soccer.df <- expand.dft(soccer.df)
str(soccer.df)

apply(soccer.df, 2, FUN= function(x) c(mean=mean(x), var=var(x)))
