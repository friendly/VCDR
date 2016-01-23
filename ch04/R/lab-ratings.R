ratings <- matrix(
c(
  24,  8, 13,     
   8, 13, 11,    
  10,  9, 64
 ), 3, 3, byrow=TRUE)
dimnames(ratings) <- list(Siskal=c("Con", "Mixed", "Pro"),
                          Ebert =c("Con", "Mixed", "Pro"))
ratings

Kappa(ratings)

agreementplot(Ratings)



