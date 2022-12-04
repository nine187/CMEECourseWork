#!/bin/bash
# Author: pp1922@ic.ac.uk
# Script: Run Miniproject
# Desc: Script to run Miniproject from code for data wrangling, modelling, and analysis to final LaTeX report compilation
# Date: December 2021

# Data Wrangling
echo "Cleaning the datset.."
python3 data_prep.py
echo "Cleaned"

# Model fitting
echo "Fitting models..."
Rscript model_fitting.R
echo "Models fitted !"

#analysis
echo "analysing the data..."
Rscript analysis.R
echo"Done analysing!"

#visualization
echo "Visualizing diagrams.."
Rscript visualization.R
echo "Done visualizing"

# count words in report
texcount -1 -sum=1,2 report.tex > words.sum

# LaTeX report
echo "Compiling LaTeX"
pdflatex report.tex
bibtex references.aux
pdflatex report.tex
pdflatex report.tex
echo "Compiled LaTeX report"

echo "The wordcount of LaTeX is..."
mv report.pdf ../results/
cat words.sum
mv words.sum ../results/

mv *pdf ../results/
rm report.fdb_latexmk
rm *.aux
rm *.log
rm *.bbl
rm *.blg
rm *.fls