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
print(Latin_names)

Common_names = [x[1] for x in birds]
print(Common_names)

Body_masses = [x[2] for x in birds]
print(Body_masses)

# (2) Now do the same using conventional loops (you can choose to do this 
# before 1 !). 

Loop_one = []
for i in birds:
    Loop_one.append(i[0])
print(Loop_one)


Loop_two = []
for i in birds:
    Loop_two.append(i[1])
print(Loop_two)

Loop_three=[]
for i in birds:
    Loop_three.append(i[2])
print(Loop_three)


# A nice example out out is:
# Step #1:
# Latin names:
# ['Passerculus sandwichensis', 'Delichon urbica', 'Junco phaeonotus', 'Junco hyemalis', 'Tachycineata bicolor']
# ... etc.