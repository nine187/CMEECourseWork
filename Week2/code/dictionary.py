#!/usr/bin/env python3
"""Fourth Practical for Python"""
__author__ = 'Pasith Prayoonrat (pp1922@ic.ac.uk)'
__version__ = '0.0.1'

#from operator import add

import sys

taxa = [ ('Myotis lucifugus','Chiroptera'),
         ('Gerbillus henleyi','Rodentia',),
         ('Peromyscus crinitus', 'Rodentia'),
         ('Mus domesticus', 'Rodentia'),
         ('Cleithrionomys rutilus', 'Rodentia'),
         ('Microgale dobsoni', 'Afrosoricida'),
         ('Microgale talazaci', 'Afrosoricida'),
         ('Lyacon pictus', 'Carnivora'),
         ('Arctocephalus gazella', 'Carnivora'),
         ('Canis lupus', 'Carnivora'),
        ]

# Write a python script to populate a dictionary called taxa_dic derived from
# taxa so that it maps order names to sets of taxa and prints it to screen.
# 
# An example output is:
# 
# 'Chiroptera' : set(['Myotis lucifugus']) ... etc. OR, 'Chiroptera': {'Myotis
#  lucifugus'} ... etc

#### Your solution here #### 


#solution

#create taxa _dic as a dictionary
taxa_dic = dict() 
#create the genus set key as a set of genus names from the second variables in the taxa list
genus_set = set([x[1] for x in taxa]) 
#for every item in the genus_set
for x in genus_set: 
        # set a new variable (y) as the value for the first element of the taxa list if the second element is match with the genus_set name to avoid duplication/overwriting
        taxa_dic[x] = set([y[0] for y in taxa if y[1] == x]) 

#beautiful
from pprint import pprint
pprint(taxa_dic)


# Now write a list comprehension that does the same (including the printing after the dictionary has been created)  

#### Your solution here #### 

#create a new list comprehension, set the key as  the second variable in the taxa list and the value as the first variable in the taxa list
taxa_dic_lc = {x[1]:[y[0] for y in taxa if y[1] == x[1]] for x in taxa} 
#if the key in the first list matches the genus on the list, it will be assign as a value for that key

from pprint import pprint
pprint(taxa_dic_lc)