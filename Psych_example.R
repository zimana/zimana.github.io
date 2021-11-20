#psych will add a few stats to your data
library(psych)
#added stats
describe(mtcars$hp)
cor(mtcars$hp, mtcars$mpg, method="pearson")
#separate - can read file csv
#read_* * = csv,delim,tsv
#library openxlsx for standard Excel
z <- read.csv("test.csv")

