#!/bin/sh
# Author: Pasith Prayoonrat pp1922@ic.ac.uk
# Script: tabtocsv.sh
# Description: substitute the tabs in the files with commas
#
# Saves the output into a .csv file
# Arguments: 1 -> tab dlimited file
# Date: Oct 2022
if [ $# -eq 0 ]; then

    echo "NO FILES ARE INPUTTED!" >&2
    exit 1
else
    echo "NICE! THE FILE NAME IS $1"
    
fi

echo "Creating a comma delimited version of $1 ..."
cat $1 | tr -s "\t" "," >> $1.csv
echo "Moving $1 to results directory"
mv $1.csv ../results/
echo "Done!"
exit