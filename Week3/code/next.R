# Author: Pasith Prayoonrat (pp1922@ic.ac.uk)
# Script: next.R
# Desc: example of how to use next for loop
# Arguments: none
# Date: Oct 2022

for (i in 1:10) {
    if ((i %% 2) == 0 ) #check if the number is odd
        next #pass to next iteration of loop
    print(i)
}