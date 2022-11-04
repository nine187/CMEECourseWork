# Author: Pasith Prayoonrat (pp1922@ic.ac.uk)
# Script: GPDD_Data.R
# Desc: Practical for maps package
# Date: Oct 2022

#load the file  in data
load("../data/GPDDFiltered.RData")

#install the maps package
install.packages("maps")
library(maps)

#create the map of the world
map()

#add all locations of the data into our dataframe
points(gpdd, add = TRUE, col = "red")

#The data points are clustered in the middle part of the world map, so there will be geographical biases in the data.