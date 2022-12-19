# Author: Pasith Prayoonrat (pp1922@ic.ac.uk)
# Script: basic_io.R
# Desc: R input and output examples
# Arguments: none
# Date: Oct 2022

MyData <- read.csv("../data/trees.csv", header = TRUE) #import with headers
write.csv(MyData, "../results/MyData.csv") #write it out as a new file
write.table(MyData[1,], file = "../results/MyData.csv", append=TRUE) #Append to it
write.csv(MyData, "../results/MyData.csv", row.names=TRUE) #write row names
write.table(MyData, "../results/MyData.csv", col.names=FALSE) #ignore column names