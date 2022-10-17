#/!/bin/bash
# Author: Pasith Prayoonrat pp1922@ic.ac.uk
# Script: CompileLaTeX.sh
# Description: Compile .tex and .bib into a single pdf

# Saves the output as .pdf file
# Arguments: 1 (.tex file)
# Date: Oct 2022

#run this by typing bash CompileLaTeX.sh FirstExample

if [ $# -eq 1 ] #check if an argument is provided, the script will break if more than one argument is provided (no time to fix)
then

echo " Creating the pdf with the bibliography. "
pdflatex $1 #somehow when I input the file with a .tex extension (FirstExample.tex) the script gave an error respond but when I input just the file name (FirstExample), the script works fine
bibtex $1
pdflatex $1
pdflatex $1
evince $1.pdf
echo "Cleaning up..."
## Cleanup
rm *.aux
rm *.log
rm *.bbl
rm *.blg
mv $1.pdf ../results/

else #if the argument provided is not equal to one the script will return this output
echo "Please input FirstExample or other .tex file as an argument, other input will definitely break this script."
fi
exit