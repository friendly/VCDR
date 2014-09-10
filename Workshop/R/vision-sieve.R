library(vcd)
women <- subset(VisualAcuity, gender=="female", select=-gender)
structable(~right + left, data=women)
sieve(Freq ~ right + left,  data = women, 
      gp=shading_Friendly, labeling=labeling_values,
      main="Vision data: Women")

men <- subset(VisualAcuity, gender=="male", select=-gender)
structable(~right + left, data=men)
sieve(Freq ~ right + left,  data = men, 
      gp=shading_Friendly, labeling=labeling_values,
      main="Vision data: Men")

# both together
cotabplot(Freq ~ right + left | gender, data=VisualAcuity, panel=cotab_sieve, gp=shading_Friendly)
