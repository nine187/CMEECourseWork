#!/bin/sh
# Author: Pasith Prayoonrat pp1922@ic.ac.uk
# Script: csvtospace.sh
# Description: substitute the csv in the files to space
#
# Saves the output into a .txt file
# Arguments: 1 -> comma delimited file
# Date: Oct 2022
if [ $# -eq 0 ]; then #if the amount of arguments inputted is zero the script will print out the message below and exit
    echo "NO FILES ARE INPUTTED! Please input a .csv file" >&2
    exit 1

elif [ ! -s $1 ]; then #if the input file is less than 0 byte the script will print out the message

    echo "The file you have inputted is empty!"
    exit

elif [ $1 != *.csv ]; then #if the file detected is a .csv file it will substitute the csv files to space 
    
    echo "Creating a delimited version of $1 ..."
    cat $1 | tr -s "," " " >> $1.txt
    echo "Done!"
fi