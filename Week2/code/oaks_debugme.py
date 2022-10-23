#!/usr/bin/env python3


"""A practical problem on debugging of a function that determine whether a species is an oak."""

__author__ = 'Pasith Prayoonrat (pp1922@ic.ac.uk)'
__version__ = '0.0.1'

import csv
import sys
import doctest

""""Debugger Practical for Python"""

__author__ = 'Pasith Prayoonrat (pp1922@ic.ac.uk)'
__version__ = '0.0.1'

#Define function
#import ipdb; ipdb.set_trace()
def is_an_oak(name):
    """ Returns True if name is starts with 'quercus'
    >>> is_an_oak('Quercus robur') 
    'True'
    >>> is_an_oak('Fagus sylvatica')
    'False'
    """
    return name.lower().startswith('quercus')
doctest.testmod()

def main(argv): 
    f = open('../data/TestOaksData.csv','r')
    g = open('../data/JustOaksData.csv','w')
    taxa = csv.reader(f)
    csvwrite = csv.writer(g)
    oaks = set()
    for row in taxa:
        print(row)
        print ("The genus is: ") 
        print(row[0] + '\n')
        if is_an_oak(row[0]):
            print('FOUND AN OAK!\n')
            csvwrite.writerow([row[0], row[1]])
        else:
            print("NOT AN OAK")   

    return 0
if (__name__ == "__main__"):
    status = main(sys.argv)
    sys.exit(status)
