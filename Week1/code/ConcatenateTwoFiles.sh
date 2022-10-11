#!/bin/bash
# Author: Pasith Prayoonrat pp1922@ic.ac.uk
# Script: ConcatenateTwoFiles.sh
# Description: concatenate the two files inputted 
#
# Saves the output into a .txt file
# Arguments: 1 -> tab dlimited file
# Date: Oct 2022
if [ $# -ne 1 ] && [ $# -ne 0 ]; then
    echo "Please input only 2 files"
    exit
fi

if [ $# -eq 0 ]; then 

    echo "NO FILES ARE INPUTTED! Please input 2 Files" >&2
    exit
fi

if [ $# -eq 2] ; then
    echo "CORRECT NUMBER OF FILES ! THE FILES GETTING THE FUSION TRANSFORMATION ARE $1 AND $2. THE FUSION MATERIAL WILL BE $3"
    cat $1 > $3
    cat $2 >> $3
    echo "Merged File is $3"
    cat $3
    echo "Moving $3 file to results"
    mv $3 ../results/
    echo "Done!"
    exit

fi