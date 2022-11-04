# Author: Pasith Prayoonrat (pp1922@ic.ac.uk)
# Script: browser.R
# Desc: debugging example with browser
# Arguments: none
# Date: Oct 2022

Exponential <- function(N0 = 1, r = 1, generations = 10) {
  
  # Runs a simulation of exponential growth
  # Returns a vector of length generations
  
  N <- rep(NA, generations)    # Creates a vector of NA
  
  N[1] <- N0
  for (t in 2:generations) {
    N[t] <- N[t-1] * exp(r)
    browser()
  }
  return (N)
}

plot(Exponential(), type="l", main="Exponential growth")