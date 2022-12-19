#!/bin/bash
# Author: Pasith Prayoonrat pp1922@ic.ac.uk
# Script: tiff2png.sh
# Description: convert .tiff file to png
# Arguments: 1 -> .tiff file

# Date: Oct 2022

if [ "$1" == "" ] #if there are no files provided, the scirpt will as the user to provide a file and exit
then 
echo 'Please provide a file.'
exit
fi

for f in *.tiff; #regular code from the course that convert .tiff to .png modified from .tif to .tiff
    do  
        echo "Converting $f"; 
        convert "$f"  "$(basename "$f" .tiff).png"; 
    done
    exit