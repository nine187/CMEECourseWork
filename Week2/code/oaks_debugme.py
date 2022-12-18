#!/usr/bin/env python3
"""A practical problem on debugging of a function that determine whether a species is an oak."""
__author__ = 'Dashing Dingos'
__version__ = '0.0.1'

import csv #import csv
import sys
import doctest

#Define function
#import ipdb; ipdb.set_trace()
def is_an_oak(name):

    """ Returns True if name is starts with 'quercus'
    >>> is_an_oak('Fagus sylvatica') #wrong name
    False
    >>> is_an_oak('Quercus robur') #Capital letter
    True
    >>> is_an_oak('quercus robur') #correct !
    True
    >>> is_an_oak('quercuss robur') #typo 
    True
    """
    return name.lower().startswith('quercus')
doctest.testmod()

def main(argv): 
    """ Exclude the header row and include the column headers. """ 
    f = open('../data/TestOaksData.csv','r')
    g = open('../results/JustOaksData.csv','w')
    taxa = csv.reader(f)
    #use this to exclude the header
    next(taxa)
    csvwrite = csv.writer(g)
    oaks = set()
    for row in taxa:
        #print the species
        print(row)
        print("The genus is: ")
        print(row[0])
        #if it is an oak
        if is_an_oak(row[0]):
            print('FOUND AN OAK!\n')
        #if not
        else:
            print("NOT AN OAK!\n")
            csvwrite.writerow([row[0], row[1]])
    print("\nOaks saved to ../results/JustOaksData.csv")
    return 0

if (__name__ == "__main__"):
    status = main(sys.argv)
    sys.exit(status)