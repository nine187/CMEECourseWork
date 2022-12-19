# Author: Pasith Prayoonrat (pp1922@ic.ac.uk)
# Script: apply2.R
# Desc: How to use apply to vector
# Arguments: none
# Date: Oct 2022

SomeOperation <- function(v) { # (What does this function do?)
    if (sum(v) > 0) {
        return (v * 100)
    } else {
    return (v)
    }
}

M <- matrix(rnorm(100), 10, 10)
print (apply(M, 1, SomeOperation))