#!/bin/sh
# Author: Pasith Prayoonrat pp1922@ic.ac.uk
# Script: csvtospace.sh
# Description: substitute the csv in the files to space

# Saves the output into a .txt file
# Arguments: 1 -> comma delimited file
# Date: Oct 2022

if [ $# -eq 0 ]; then #if the amount of arguments inputted is zero the script will print out the message below and exit
    echo "NO FILE DETECTED! Please input a .csv file" >&2
    exit

elif [ $# -eq 1 ]; then #if the amount of arguments inputted is one the script will print out the message below and exit and move the file in the /results folder
    echo "Creating a delimited version of $1 ..."
    cat $1 | tr -s "," " " >> $1.txt
    echo "Moving $1 file to results"
    mv $1.txt ../results/
    echo "Done!"
    exit

else #if for any other conditions that there are more than 1 argument, the script will return a wrong input text
    echo "Wrong Input"
    exit

fi