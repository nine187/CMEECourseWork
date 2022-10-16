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

Latin_names = ('Passerculus sandwichensis', 'Delichon urbica', 'Junco phaeonotus', 'Junco hyemalis', 'Tachycineata bicolor')

Common_names = ('Savannah sparrow', 'House martin', 'Yellow-eyed junco', 'Dark-eyed junco', 'Tree swallow')

Body_masses = ('18.7', '19', '19.5', '19.6', '20.2')

# (2) Now do the same using conventional loops (you can choose to do this 
# before 1 !). 

for x in Latin_names:
    print(x)

for x in Common_names:
    print(x)

for x in Body_masses:
    print(x)

# A nice example out out is:
# Step #1:
# Latin names:
# ['Passerculus sandwichensis', 'Delichon urbica', 'Junco phaeonotus', 'Junco hyemalis', 'Tachycineata bicolor']
# ... etc.
 
