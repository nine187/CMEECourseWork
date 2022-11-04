# Author: Pasith Prayoonrat (pp1922@ic.ac.uk)
# Script: R_conditionals.R
# Desc: Examples of writing conditions in R.
# Date: Oct 2022

# Checks if an integer is even
is.even <- function(n = 2){
  if (n %% 2 == 0)
  {
    return(paste(n,'is even!'))
  } 
  return(paste(n,'is odd!'))
}

is.even(6)

# Checks if a number is a power of 2
is.power2 <- function(n = 2){
  if (log2(n) %% 1==0)
  {
    return(paste(n, 'is a power of 2!'))
  } 
  return(paste(n,'is not a power of 2!'))
}

is.power2(4)

# Checks if a number is prime
is.prime <- function(n){
  if (n==0){
    return(paste(n,'is a zero!'))
  }
  if (n==1){
    return(paste(n,'is just a unit!'))
  }
  ints <- 2:(n-1)
  if (all(n%%ints!=0)){
    return(paste(n,'is a prime!'))
  } 
  return(paste(n,'is a composite!'))
}

is.prime(3)