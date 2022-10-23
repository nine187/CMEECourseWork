# Checks if an integer is even
is.even <- function(n = 2) {
    if (n %% 2 == 0){
        return(paste(n,'is even!'))
    } else {
    return(paste(n,'is odd!'))
    }
}

is.even(6)