#!/binsh
#Author: Pasith Prayoonrat pp1922@ic.ac.uk
# Script: boilerplate.sh
#Desc: simple boilerplate for shell scripts
#Arguments: none
#Date: Oct 2019

echo -e "\nThis is a shell script! \n"

#exit#!/bin/bash

NumLines=`wc -l < $1`
echo "The file $1 has $NumLines lines"
echo