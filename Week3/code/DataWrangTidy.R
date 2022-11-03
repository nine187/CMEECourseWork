################################################################
################## Wrangling the Pound Hill Dataset ############
################################################################
rm(list=ls()) 
require(dplyr)
require(tidyr)
############# Load the dataset ###############
# header = false because the raw data don't have real headers
MyData <- as.matrix(read.csv("../data/PoundHillData.csv", header = FALSE))

# header = true because we do have metadata headers
MyMetaData <- read.csv("../data/PoundHillMetaData.csv", header = TRUE, sep = ";")

############# Inspect the dataset ###############
head(MyData)
dim(MyData) #show the dimension of the obj
dplyr::glimpse(MyData) #str() version in tidyr
fix(MyData) #you can also do this
fix(MyMetaData)

############# Transpose ###############
# To get those species into columns and treatments into rows 
MyDataT = as_tibble(Mydata)
head(MyData)
dim(MyData)

############# Replace species absences with zeros ###############
MyData[MyData == ""] = 0

############# Convert raw matrix to data frame ###############

TempData <- as.data.frame(MyData[-1,],stringsAsFactors = F) #stringsAsFactors = F is important!
colnames(TempData) <- MyData[1,] # assign column names from original data

############# Convert from wide to long format  ###############
require(reshape2) # load the reshape2 package

?melt #check out the melt function
#use gather instead of melt 

#pivot_longer increase the row and decrease column to further categorized the
#data (this is the newer version of gather according to tidyverse website)
#https://tidyr.tidyverse.org/reference/gather.html
MyWrangledData <- TempData %>%
  pivot_longer(Species, Count, Cultivation, Block, Plot, Quadrat)

#use mutate to compute the variables into a new column as factor in the first
#four variables and as an integer for count

MyWrangledData <- MyWrangledData %>%
  mutate(across(Cultivation, Block, Plot, Quadrat), as.factor)
  mutate(Count= as.integer(Count))

dplyr::glimpse(MyWrangledData)
head(MyWrangledData)
dim(MyWrangledData)

############# Exploring the data (extend the script below)  ###############
