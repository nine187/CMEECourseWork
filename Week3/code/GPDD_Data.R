load("../data/GPDDFiltered.RData")
install.packages("maps")
library(maps)
map()
points(gpdd, add = TRUE, col = "red")
#the data points are clustered in the middle part of the world map, so there will
#be geographical biases in the data