# Checks if a number is a power of 2
is.power2 <- function(n = 2) {
    if (log2(n) %% 1==0) {
        return(paste(n, 'is a power of 2!'))
    } else {
    return(paste(n,'is not a power of 2!'))
    }
}

is.power2(4)