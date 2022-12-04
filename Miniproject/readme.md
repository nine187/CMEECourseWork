## **Miniproject**

This repository contains materials required to run the computing miniproject, detailed in the Miniproject section of [**The Multilingual Quantitative Biologist**](https://mhasoba.github.io/TheMulQuaBio/intro.html).


### **Languages**

Python version 3.8.11

R version 4.1.2

bash version 5.16.1

LaTeX

### **Dependencies and special packages** 

Python:
- Pandas: to create and manipulate dataframes
- Seaborn: initial visualization of the dataset

R:
- ggplot2: create plots
- minpack.lm: to fit linear models
- qpcR: to help with model fitting
- viridis: to make colour-blind-friendly plots
- gtable: combining graphs into one full diagram
- gridExtra: combining graphs and arranging the grids
- grid: for grid graphic
- formattable: to calculate percentages of the models


LaTeX:
- graphicx: insert graphics
- caption: add captions
- float: put diagrams in proper places

### **Usage**

Navigate to the code directory in the command line. Bash execute the [**compile_all.sh**]. The order of file execution are roughly as follows: **data_prep.py**, **model_fitting.R**, **functions.R** **analysis.R**, **visualization.R**, **report.tex**, **references.bib**. 

Scripts:

[**compile_all.sh**]: This script is run from the bash terminal and compiles the entire project from start to finish.

[**data_prep.py**]: Data wrangling script to clean the data.

[**model_fitting.R**]: Model fitting script to fit different models.

[**functions.R**]: Script containing all the necessary functions applied throughout the script.

[**analysis.R**]: Script uses to analyse the data after fitting the model.

[**visualization.R**]: Script to produce diagrams and visualizations for the report.

[**report.tex**]: Script containig the write-up.

[**references.bib**]: Script containing the bibliography.