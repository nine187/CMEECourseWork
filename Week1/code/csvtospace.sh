#!/bin/sh
# Author: Pasith Prayoonrat pp1922@ic.ac.uk
# Script: csvtospace.sh
# Description: substitute the csv in the files to space
#
# Saves the output into a .txt file
# Arguments: 1 -> comma delimited file
# Date: Oct 2022
if [ $# -eq 0 ]; then

    echo "NO FILES ARE INPUTTED!" >&2
    exit 1
else
    echo "Creating a delimited version of $1 ..."
    cat $1 | tr -s "," " " >> $1.txt
    echo "Done!"
fi
exit