# This function calculates heights of trees given distance of each tree
# from its base and angle to its top, using the trigonometric formula
#
# height = distance * tan(radians)
#
#ARGUMENTS 
#degrees: The angle of elevation of tree
#distance: The distance from base of tree (e.g., meters)
#
#OUTPUT
#The heights of the tree, same units as "distance"

#clear the list
rm(list=ls())

#read the csv file, header true cause the top is the variable
Tree <- read.csv("../data/trees.csv", header = TRUE)

#math
TreeHeight <- function(degrees, distance) {
    radians <- degrees * pi / 180
    height <- distance * tan(radians)

    return (height)
}

#add TreeHeight.m to the original data by assigning degrees and distance to the function
Tree$TreeHeight.m <- TreeHeight(Tree$Angle.degrees, Tree$Distance.m)

#output to results
write.csv(Tree, "../results/TreeHts.csv")