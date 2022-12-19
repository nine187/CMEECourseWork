#Author: Dashing Dingos
#Script: get_TreeHeight.R
#Created: Dec 2022
#Desc: Groupwork practical on tree height

# clear working directory
rm(list=ls())

# Function to calculate the height of a tree from its base angl to its top
TreeHeight <- function(degrees, distance) {
  radians <- degrees * pi / 180
  height <- distance * tan(radians)
  
  return (height)
}

# Import the data from the command line
# if the command line length is empty, use a default path
if (length( commandArgs(trailing = T) ) == 0 ){
  print("No files are inputted, using the default pathway. \n ../data/trees.csv ")
  fname = "../data/trees.csv"
} else {
  fname = commandArgs(trailing = T)[1]
}

# read the file as csv
data <- read.csv(file = fname, header = TRUE)

# make a new column on treesdata with the tree height results
data$TreeHeight.m <- TreeHeight(data$Angle.degrees, data$Distance.m)

# get the base file name without the file path or extension
fbase = tools::file_path_sans_ext(basename(fname))

# Write the filepath to save the results
writepath = paste("../results/", fbase, "_treeheights.csv", sep = "")

# save to results
print("Saving results into the results folder")
write.csv(data, writepath)

# Echo message when complete
print("All done in R!")