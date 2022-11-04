#!/bin/bash
# Author: Pasith Prayoonrat (pp1922@ic.ac.uk)
# Script: Florida.sh
# Desc: Shell script for Florida pdf
# Argument: Florida
# Date: Oct 2022

pdflatex $1
evince $1

mv $1.pdf ../results/
## Cleanup
rm *.aux
rm *.log
rm *.bbl
rm *.blg

#run by bash Florida.sh Florida