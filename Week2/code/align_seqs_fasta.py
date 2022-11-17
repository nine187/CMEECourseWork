#!/usr/bin/env python3


"""This script is designed to align 2 FASTA files input and will default to 2 FASTA files in data category when no input is given. """

__author__ = 'Dashing Dingos'
__version__ = '0.0.1'

import ipdb #debugger
import csv #use to read csv file
import sys #import the sys.agrv

#ipdb.set_trace() #the breakpoint
#write a function that define to read the .csv file
def Input(x):
    """Description"""
    


# Two example sequences to match

# Assign the longer sequence s1, and the shorter to s2
# l1 is length of the longest, l2 that of the shortest

l1 = len(DNA_2)
l2 = len(DNA_1)
if l1 >= l2: # if seq1 length is longer than seq2
    s1 = DNA_2 #define s1 as seq1
    s2 = DNA_1 #define s2 as seq2
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