# Author: Pasith Prayoonrat (pp1922@ic.ac.uk)
# Script: control_flow.R
# Desc: illustrates control flow use in R
# Arguments: none
# Date: Oct 2022

a <- TRUE
if (a == TRUE) {
    print ("a is TRUE")
} else {
    print ("a is FALSE")
}

#alternative if statement
# z <- runif(1) ##Generate a uniformly distributed random number
# if (z <= 0.5) {print ("Less than a half")}