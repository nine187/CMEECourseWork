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

taxa_dic = dict()
genus_set = set([x[1] for x in taxa])
for x in genus_set:
        taxa_dic[x] = set([y[0] for y in taxa if y[1] == x])

from pprint import pprint
pprint(taxa_dic)


# Now write a list comprehension that does the same (including the printing after the dictionary has been created)  

#### Your solution here #### 

taxa_dic_lc = {x[1]:[y[0] for y in taxa if y[1] == x[1]] for x in taxa} #

from pprint import pprint
pprint(taxa_dic_lc)