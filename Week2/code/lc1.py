#!/usr/bin/env python3

"""First Practical for Python"""

__author__ = 'Pasith Prayoonrat (pp1922@ic.ac.uk)'
__version__ = '0.0.1'

import sys 

birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
         )

#(1) Write three separate list comprehensions that create three different
# lists containing the latin names, common names and mean body masses for
# each species in birds, respectively. 

Latin_names = [x[0] for x in birds] #takes the first element from the birds list and seperate it into a new list called Latin_names
from pprint import pprint #beautiful !
pprint(Latin_names)

Common_names = [x[1] for x in birds]
pprint(Common_names)

Body_masses = [x[2] for x in birds]
pprint(Body_masses)

# (2) Now do the same using conventional loops (you can choose to do this 
# before 1 !). 

#creates a blank set to insert the output in
Loop_one = []
#for every item in birds
for x in birds: 
#append all the first variable in each of the nested tuple (the latin name)
    Loop_one.append(x[0]) 
#print it
pprint(Loop_one) 

#creates a blank set to insert the output in
Loop_two = [] 
# for every item in birds
for x in birds: 
    # append all the second variables in each of the nested tuple (common name)
    Loop_two.append(x[1]) 
pprint(Loop_two)

#creates a blank set to insert the output in
Loop_three=[] 
# for every item in bird
for x in birds: 
    #append all the third variables in each of the nested tuple (bodymass)
    Loop_three.append(x[2]) 
pprint(Loop_three)


# A nice example out out is:
# Step #1:
# Latin names:
# ['Passerculus sandwichensis', 'Delichon urbica', 'Junco phaeonotus', 'Junco hyemalis', 'Tachycineata bicolor']
# ... etc.