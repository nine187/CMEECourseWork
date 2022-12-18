#!/usr/bin/env py
"""
NAME
get_TreeHeight.py

DESCRIPTION
A script to calculate tree height use input file from command line.

FUNCTIONS
TreeHeight(degrees, distance)

DATA
No

VERSION
0.0.1

AUTHOR
Sirui Ye (sy1122@ic.ac.uk)
"""

import sys
import os
import numpy as np
import pandas as pd

# load file from command line (file path)
input_file = sys.argv[1]

# get file name
input_file_name = os.path.basename(input_file)

#strip off file extension
input_file_name = input_file_name.split(".")[0]

# load file data to dataframe
df = pd.read_csv(input_file)

def TreeHeight(degrees, distance):
    """[Calculate tree heights based on distance from tree base and angles from tree top]
       Args:
           degrees ([float])
           distance ([float])
       Returns:
           [list]: [heights of each tree]
       """
    
    radians = np.radians(degrees)
    height = distance * np.tan(radians)
    return height

# store tree heights in a new column in dataframe 
df["Tree.Height.m"] = TreeHeight(df["Angle.degrees"], df["Distance.m"])

# output file location
output_file = "../results/" + input_file_name + "_treeheights.csv"

# save output file 
df.to_csv(output_file,index=False) 

# compelte message 
print("All done.")



