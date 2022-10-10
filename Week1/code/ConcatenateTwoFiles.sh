#!/bin/bash
# Author: Pasith Prayoonrat pp1922@ic.ac.uk
# Script: ConcatenateTwoFiles.sh
# Description: concatenate the two files inputted 
#
# Saves the output into a .txt file
# Arguments: 1 -> tab dlimited file
# Date: Oct 2022

if [ -z $1 ]; 
    then 
        echo " WRONG NUMBER OF FILES, THIS SCRIPT NEED 2 FILES "
        exit

else
    echo "CORRECT ! THE FILES GETTING THE FUSION TRANSFORMATION ARE $1 AND $2. THE FUSION MATERIAL WILL BE $3"
    cat $1 > $3
    cat $2 >> $3
    echo "Merged File is $3"
    cat $3
    echo "Moving $3 file to results"
    mv $3 ../results/
    echo "Done!"
    exit

fi