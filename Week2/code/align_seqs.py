#!/usr/bin/env python3
"""
This script is designed to align DNA sequences to the closest possible match
"""
__author__ = 'Pasith Prayoonrat (pp1922@ic.ac.uk)'
__version__ = '0.0.1'

#import ipdb #debugger
import csv #use to read csv file
import sys #import the system

#ipdb.set_trace() #the breakpoint
#open the csv file
DNAs_open = open('../data/DNAs.csv', 'r') 

#read the .csv DNA file
read_csv = csv.reader(DNAs_open) 
DNA = []
for row in read_csv:
    DNA.append(row[0])

DNA_1 = str(DNA[1])
DNA_2 = str(DNA[0])

# Two example sequences to match

# Assign the longer sequence s1, and the shorter to s2

#use len to find the length of both DNA
l1 = len(DNA_2)
l2 = len(DNA_1)
if l1 >= l2: # if seq1 length is longer than seq2
    s1 = DNA_2 
    s2 = DNA_1 
else:# if seq2 length is shorter than seq1, s1 will always be the longer sequence
    s1 = DNA_1 
    s2 = DNA_2 
    l1, l2 = l2, l1 # swap the two lengths

# A function that computes a score by returning the number of matches starting
# from arbitrary startpoint (chosen by user)
def calculate_score(s1, s2, l1, l2, startpoint): 
    matched = "" # to hold string displaying alignements
    score = 0
    for i in range(l2):
        if (i + startpoint) < l1:
            if s1[i + startpoint] == s2[i]: # if the bases match
                matched = matched + "*"
                score = score + 1
            else:
                matched = matched + "-"

    # some formatted output
    print("." * startpoint + matched)           
    print("." * startpoint + s2)
    print(s1)
    print(score) 
    print(" ")

    return score

# Test the function with some example starting points:
# ca lculate_score(s1, s2, l1, l2, 0)
# calculate_score(s1, s2, l1, l2, 1)
# calculate_score(s1, s2, l1, l2, 5)

# now try to find the best match (highest score) for the two sequences
my_best_align = None
my_best_score = -1

for i in range(l1): # Note that you just take the last alignment with the highest score
    z = calculate_score(s1, s2, l1, l2, i)
    if z > my_best_score:
        my_best_align = "." * i + s2 # think about what this is doing!
        my_best_score = z 
print(my_best_align)
print(s1)
print("Best score:", my_best_score) 

#use text file in result as an output
sys.stdout = open ('../results/align_seq_result.txt', 'w') 
print ("The best alignment is: " + str(my_best_align) + "." "The best score is: " + str(my_best_score) + ".")

#confirmation to close
sys.stdout.close() 