#!/bin/bash
# Author: Pasith Prayoonrat pp1922@ic.ac.uk
# Script: ConcatenateTwoFiles.sh
# Description: concatenate the two files inputted 

# Saves the output into a .txt file
# Arguments: 1 -> tab dlimited file
# Date: Oct 2022

if [ $# -eq 2 ]; then #if the number of arguments is equal to 2 then the file will be concatenated and move the file to /results folder
    echo "Merging $1 and $2."
    echo "Please enter the name of the merged file."
    read outputname
    echo
    cat $1 > $outputname
    cat $2 >> $outputname
    echo "Merged File is $outputname"
    echo "Moving $outputname file to results"
    mv $outputname ~/Documents/CMEECourseWork/Week1/results/
    echo "Done!"

else #if more than 2 or less than 2 arguments are provided the script will ask the user to input the correct amount of files
    echo " Please input 2 files"
    exit
    fi