#Author: Pasith Prayoonrat (pp1922@ic.ac.uk)
#Script: PP_Dists.R
#Created: Oct 2022
#Desc: Practical on vectorization

# Runs the stochastic Ricker equation with gaussian fluctuations

rm(list = ls())


# original loop provided:

stochrick <- function(p0 = runif(1000, .5, 1.5), r = 1.2, K = 1, sigma = 0.2,numyears = 100)
{
  #initialize empty matrix
  N <- matrix(NA, numyears, length(p0))  
  
  N[1, ] <- p0 
  #loop through the populations
  for (pop in 1:length(p0)) { 
    #loop through the years
    for (yr in 2:numyears){ 
      
      N[yr, pop] <- N[yr-1, pop] * exp(r * (1 - N[yr - 1, pop] / K) + rnorm(1, 0, sigma))
    }
    
  }
  return(N)
  
}
#calculate first row then column
# Now write another function called stochrickvect that vectorizes the above to
# the extent possible, with improved performance: 

#clear the list

  #vectorized function
 stochrickvect <- function(p0=runif(1000, .5, 1.5), r = 1.2, K = 1, sigma = 0.2,
                          numyears = 100) {

    #initialize empty matrix
   N<-matrix(NA,numyears,length(p0))
   
   N[1,]<-p0
   
   #loop through the years and ignore the pop
   for (yr in 2:numyears) 
   # remove pop from the loop to reduce computational time
   {
     N[yr,] <- N[yr-1,] * exp(r* (1-N[yr - 1,] / K) + rnorm(1, 0 ,sigma))
   }
   return(N)
 }
print("Non-vectorized Stochastic Ricker takes:")
print(system.time(res1 <- stochrick()))
print("Vectorized Stochastic Ricker takes:")
print(system.time(res2<-stochrickvect()))
