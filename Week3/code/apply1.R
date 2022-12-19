# Author: Pasith Prayoonrat (pp1922@ic.ac.uk)
# Script: apply1.R
# Desc: How to use apply to vector
# Arguments: none
# Date: Oct 2022

## Build a random matrix
M <- matrix(rnorm(100), 10, 10)

## Take the mean of each row
RowMeans <- apply(M, 1, mean)
print (RowMeans)

## Now the variance
RowVars <- apply(M, 1, var)
print (RowVars)

##By column
ColMeans <- apply(M, 2, mean)
print (ColMeans)