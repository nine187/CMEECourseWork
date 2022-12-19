#!/bin/bash
# Author: Pasith Prayoonrat (pp1922@ic.ac.uk)
# Script: Florida.sh
# Desc: Shell script for Florida pdf
# Argument: Florida
# Date: Oct 2022

echo "Compiling LaTeX"
pdflatex Florida.tex
bibtex Florida.bib
pdflatex Florida.tex
pdflatex Florida.tex
echo "Compiled LaTeX report"

## Cleanup
rm *.aux
rm *.log
rm *.bbl
rm *.blg
rm *.fls
rm *.fdb*

#run by bash Florida.sh Florida