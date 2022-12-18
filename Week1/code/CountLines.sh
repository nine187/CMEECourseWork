#!/bin/bash
# Author: Pasith Prayoonrat pp1922@ic.ac.uk
# Script: CountLines.sh
# Description: Count the lines in any given file(or files?)

# Arguments: 1 -> file
# Date: Oct 2022

if [ $# -eq 0 ]; then 
#if the amount of arguments inputted is zero the script will print out the message below and exit
    echo "NO FILES DETECTED! Please input a file."
    exit

else 
#standard countline code from the course will run if any argument is provided

    NumLines=`wc -l < $1`
    echo "The file $1 has $NumLines lines"
    echo "Done"

fi