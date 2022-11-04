# Author: Pasith Prayoonrat (pp1922@ic.ac.uk)
# Script: try.R
# Desc: Function use to catch error.
# Date: Oct 2022

rm(list = ls())

# this function runs a simulation that involves sampling from a synthetic
# population with replacement and takes its mean, but only if at least 30 unique
# samples are obtained
doit <- function(x) {
  temp_x <- sample(x, replace = TRUE)
  if(length(unique(temp_x)) > 30) { # only take mean if sample was sufficient
    print(paste("Mean of this sample was:", as.character(mean(temp_x))))
  }
  else { # else stop the script
    stop("Couldn't calculate mean: too few unique values!")
  }
}

# generate populations
popn <- rnorm(50)

# visualize popn
hist(popn)

# lapply to repeat sampling 15 times
lapply(1:15, function(i) doit(popn))

# now use try
result <- lapply(1:15, function(i) try(doit(popn), FALSE))

# errors are stored in the object result:
class(result)

# use loop to store results "manually"
result <- vector("list", 15) # Preallocate/Initialize
for(i in 1:15) {
  result[[i]] <- try(doit(popn), FALSE)
}