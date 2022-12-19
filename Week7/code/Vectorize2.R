#Author: Dashing Dingos
#Script: Vectorize2.R
#Created: Dec 2022
#Desc: Vectorizantion class work: edited for Groupwork practical on Vectorization
#      Runs the stochastic Ricker equation with gaussian fluctuations

rm(list = ls())

# Non-Vectorized Stochastic Ricker equation with gaussian fluctuations
stochrick <- function(p0 = runif(1000, .5, 1.5), r = 1.2, K = 1, sigma = 0.2,numyears = 100)
{

  N <- matrix(NA, numyears, length(p0))  #initialize empty matrix

  N[1, ] <- p0 #initialize empty matrix

  for (pop in 1:length(p0)) { #loop through the populations
    for (yr in 2:numyears){ #for each pop, loop through the years

      N[yr, pop] <- N[yr-1, pop] * exp(r * (1 - N[yr - 1, pop] / K)+ rnorm(1, 0, sigma)) # add one fluctuation from normal distribution
    
     }
  }

 return(N)
}


# Vectorizes the above to the extent possible, with improved performance:
stochrickvect<- function(x, p0 = runif(1000, .5, 1.5), r = 1.2, K = 1, sigma = 0.2,numyears = 100)
{
  N <- matrix(NA, numyears, length(p0)) 
  N[1, ] <- p0

  for (yr in 2:numyears) #loops through years only, R naturally applyies columnwise(poulation) in a vectorized way
  {
     N[yr,] <- N[yr-1,] * exp(r* (1-N[yr - 1,] / K) + rnorm(1, 0 ,sigma))
  }

return(N)
}
 
# Time the vectorized and loopy function
# 1: Time the looping function
start_time_loops <- Sys.time()
T <- stochrick()
end_time_loops <- Sys.time()
time_taken_loops <- difftime(end_time_loops, start_time_loops, units = "secs")[[1]]

# Paste together the time and a string to describe it
loop_time <- paste("Non-vectorized Stochastic Ricker in R takes:",format(time_taken_loops), "seconds" )
print(loop_time)

# 2: Time the vectorizedfunction
start_time_vectorized <- Sys.time()
T <- stochrickvect()
end_time_vectorized <- Sys.time()
time_taken_vectorized <- difftime(end_time_vectorized, start_time_vectorized, units = "secs")[[1]]

# Paste together the time and a string to describe it
vectorized_time<- paste("Vectorized Stochastic Ricker in R takes:",format(time_taken_vectorized), "seconds" )
print(vectorized_time)

