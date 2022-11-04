# Author: Pasith Prayoonrat (pp1922@ic.ac.uk)
# Script: boilerplate.R
# Desc: A boilerplate R script
# Arguments: none
# Date: Oct 2022

MyFunction <- function(Arg1, Arg2) {

    # Statements involving Arg1, Arg2:
    print(paste("Argument", as.character(Arg1), "is a", class(Arg1))) # print Arg1's type
    print(paste("Argument", as.character(Arg2), "is a", class (Arg2))) # print Arg3's type

    return (c(Arg1, Arg2)) #this is optional, but very useful
}

MyFunction(1,2) #test the function
MyFunction("Riki","Tiki") #A different test