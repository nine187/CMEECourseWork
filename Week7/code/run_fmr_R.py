#!usr/bin/env python3
"""
Load the subprocess and check for error
"""

import subprocess

#use subprocess to open the R script
subprocess.Popen("Rscript fmr.R > ../results/fmrR.Rout 2> ../results/fmrR_errFile.Rout", shell= True).wait()

# open the error file 
with open("../results/fmrR_errFile.Rout", "r") as a:
    Error = a.read()
    #if the length of the object is not equal to zero meaning there is an error
    if len(Error) != 0:
        print("Unsucessful run.")
    #else there are no error and the script ran sucessfully
    else:
        print("Sucessful run.")
        #showing the r console output
        with open("../results/fmrR.Rout", "r") as b:
            b.read()