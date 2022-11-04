# Author: Pasith Prayoonrat (pp1922@ic.ac.uk)
# Script: break.R
# Desc: A script showing how to use break in loop
# Arguments: none
# Date: Oct 2022

i <- 0 #Initialize i
    while (i < Inf) {
        if (i == 10){
            break
        } else { # Break out of the while loop !
                cat("i equals", i , "\n")
                i <- i + 1 #Update i
        }
    }