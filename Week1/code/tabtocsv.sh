#!/bin/sh
# Author: Pasith Prayoonrat pp1922@ic.ac.uk
# Script: tabtocsv.sh
# Description: substitute the tabs in the files with commas

# Saves the output into a .csv file
# Arguments: 1 -> tab delimited file
# Date: Oct 2022
if [ $# -eq 0 ]; then #if the amount of arguments inputted is zero the script will print out the message below and exit

    echo "NO FILES ARE INPUTTED! Please input a file" >&2
    exit 1
elif [ ! -s $1 ]; then #if the input file is less than 0 byte the script will print out the message

    echo "Empty file!"
    exit

elif [ $# -eq 1 ]; then #if the input file is equal to 1 then the script will remove the tab and comma and changing it to a .csv file and move the file to the /results folder
    echo "NICE! THE FILE NAME IS $1.csv"
    echo "Creating a comma delimited version of $1 ..."
    cat $1 | tr -s "\t" "," >> $1.csv
    echo "Moving $1.csv to results directory"
    mv $1 ../results/
    echo "Done!"
    exit
fi