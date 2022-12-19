#Author: Dashing Dingos
#Script: Vectorize1.R
#Created: Dec 2022
#Desc: Vectorizantion class work: edited for Groupwork practical on Vectorization

# Generate random numbers
m<- matrix(runif(1000000), 1000, 1000)

# Loopy function
SumAllElements <- function(m){
    Dimentions <- dim(m)
    Tot <- 0
    for (i in 1:Dimentions[1]) {
        for (j in 1:Dimentions[2]){
            Tot <- Tot + m[i,j]
        }
    }
    return(Tot)
}


# Do time measurement
# 1: Time the looping function
start_time_loops <- Sys.time()
T <- SumAllElements(m)
end_time_loops <- Sys.time()
time_taken_loops <- difftime(end_time_loops, start_time_loops, units = "secs")[[1]]

# Paste together the time and a string to describe it
loop_time <- paste("R SumAllElements function:",format(time_taken_loops), "seconds" )
print(loop_time)

# 2: Time the vectorized function
start_time_vectorized <- Sys.time()
T<- sum(m)
end_time_vectorized <- Sys.time()
time_taken_vectorized <- difftime(end_time_vectorized, start_time_vectorized, units = "secs")[[1]]

# Paste together the time and a string to describe it
vectorized_time<- paste("R sum vectorized function:",format(time_taken_vectorized), "seconds" )
print(vectorized_time)
