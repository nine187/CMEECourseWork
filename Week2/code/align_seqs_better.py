#!/usr/bin/env python3
"""
NAME
align_seqs_fasta.py

DESCRIPTION
A script to find out all the equally-best alignments.

FUNCTIONS
inputs(seq1, seq2)
calculate_score(s1, s2, l1, l2, startpoint)
find_best_alignment(s1, s2, l1, l2)

DATA
command input

VERSION
0.0.1

AUTHOR
Chuxinyao Wang
Sirui Ye (sy1122@ic.ac.uk)
"""


#load packages
import sys
import pickle



#To start the function:
def inputs(input_file1, input_file2):
    """
    [Calculate tree heights based on distance from tree base and angles from tree top]
    Args:
        seq1
        seq2
       Returns:
        [string]: 2 strings of sequences
        [interger]: 2 lengths of the sequences
    """
    #read the sequences line by line
    with open(input_file1, "r") as f1:
        lines1=f1.readlines()
    with open(input_file2, "r") as f2:
        lines2=f2.readlines()
    ls1=[]
    ls2=[]
    #This is for deleting the info of sequences at line1 also "\n"
    for line in lines1:
        if not line.startswith('>'):
            ls1.append(line.replace('\n',''))
    #Same for another sequences
    for line in lines2:
        if not line.startswith('>'):
            ls2.append(line.replace('\n',''))
    #make seq1&seq2 from lists to strings 
    #to make it easier to align with this:
    seq1 = ''.join(ls1)
    seq2 = ''.join(ls2)
    # Assign the longer sequence s1, and the shorter to s2
    # l1 is length of the longest, l2 that of the shortest
    l1 = len(seq1)
    l2 = len(seq2)
    if l1 >= l2:
        s1 = seq1
        s2 = seq2
    else:
        s1 = seq2
        s2 = seq1
        l1, l2 = l2, l1 # swap the two lengths
    
    return s1, s2, l1, l2

# A function that computes a score by returning the number of matches starting
# from arbitrary startpoint (chosen by user)
def calculate_score(s1, s2, l1, l2, startpoint):
    """
    [Calculate similarity score for sequence alignment]
    Args:
        s1: sequence 1
        s2: sequence 2
        l1: sequence 1 length
        l2: sequence 2 length
        startpoint
       Returns:
        [interger]: score
    """
    matched = "" # to hold string displaying alignements
    score = 0
    for i in range(l2):
        if (i + startpoint) < l1:
            if s1[i + startpoint] == s2[i]: # if the bases match
                matched = matched + "*"
                score = score + 1
            else:
                matched = matched + "-"

    return score

# now try to find the best match (highest score) for the two sequences
def find_best_alignment(s1, s2, l1, l2):
    """
    [Find the alignment of the two sequences that gives the best match and highest score]
    Args:
        s1: sequence 1
        s2: sequence 2
        l1: sequence 1 length
        l2: sequence 2 length
       Returns:
        [interger]: best score
        [string]: best alignment
    """
    my_best_align = None
    my_best_score = -1
    best_score_collection = list()
    best_align_collection = list()

    # calculate score for each alignment
    for i in range(l1): 
        z = calculate_score(s1, s2, l1, l2, i)
        best_score_collection.append(z)
    
    # find out the best score
    my_best_score  = max(best_score_collection)  

    # find the best alignment
    for i in range(l1):
        if best_score_collection[i] == my_best_score:
            my_best_align = "." * i + s2 # "." indicates start point
            best_align_collection.append(my_best_align)
            
    best_results = dict()
    best_results[my_best_score] = [best_align_collection]

    print("The highest score is:", my_best_score)
    print("The best alignment is", best_align_collection)

    with open('../results/align_seqs_better.pickle', 'wb') as f:
        print ("======storing the result=====")
        pickle.dump(best_results, f)
    
    return best_results


def main(argv):
    """Main entry point of the program: 
    reads in files, calculates the best match, 
    and saves results to output files"""
    
    # if no arguments given, use default files
    if len(sys.argv) != 3:
        input_file1 = "../data/407228326.fasta"
        input_file2 = "../data/407228412.fasta"
        
    else:# take from command line
        input_file1 = sys.argv[1]
        input_file2 = sys.argv[2]

    # Run inputs(seq1, seq2) to find out the longer sequence
    s1, s2, l1, l2 = inputs(input_file1, input_file2)

    # Run find_best_align to find best alignment of sequences
    best_results = find_best_alignment(s1, s2, l1, l2)
    my_best_score = best_results.keys()
    best_align_collection = best_results.values()


    # Output file
    with open("../results/align_seq_fasta.txt", "w") as f:
         f.write("best_align_collection" + str(best_align_collection))
         f.write("\n")
         f.write("\nBest score: " + str(my_best_score))
         print("Your results can be found in the results directory!")

    return None




if (__name__ == "__main__"):
    status = main(sys.argv)
    sys.exit(status)


