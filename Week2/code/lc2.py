#!/usr/bin/env python3

"""
Second practical for Python
"""

__author__ = 'Pasith Prayoonrat (pp1922@ic.ac.uk)'
__version__ = '0.0.1'

# Average UK Rainfall (mm) for 1910 by month
# http://www.metoffice.gov.uk/climate/uk/datasets

rainfall = (('JAN',111.4),
            ('FEB',126.1),
            ('MAR', 49.9),
            ('APR', 95.3),
            ('MAY', 71.8),
            ('JUN', 70.2),
            ('JUL', 97.1),
            ('AUG',140.2),
            ('SEP', 27.0),
            ('OCT', 89.4),
            ('NOV',128.4),
            ('DEC',142.2),
           )

# (1) Use a list comprehension to create a list of month,rainfall tuples where
# the amount of rain was greater than 100 mm.

# for every item in rainfall set if the second element is over 100 it will be in this list comprehension
Over_100 = [i for i in rainfall if (i[1] > 100)] 
print("The answer to the first question is:")
print(Over_100)
print("\n")

# (2) Use a list comprehension to create a list of just month names where the
# amount of rain was less than 50 mm. 

#for every item in rainfall set if the second element that is under 50, it will be in this list comprehension
Below_50 = [i for i in rainfall if (i[1] < 50)] 
# next to return the next item from the iterator, zip to take the first element in below 50 and * to take all the element
print("The answer to the second question is:")
print(Below_50) 
print("\n")

# (3) Now do (1) and (2) using conventional loops (you can choose to do 
# this before 1 and 2 !). 

#create empty sets
task3_1 = [] 
task3_2 = []
# for every number in rainfall set
for i in rainfall: 
    #if second variable(rain) is more than 100
    if i[1] > 100: 
        #append all the those number (and coressponding months toos)
        task3_1.append(i) 
    #else if second variable is less than 50
    elif i[1] < 50:
        # append all those number but only the first element (month name)
        task3_2.append(i) 

print("The answer to the third question is:")
print(task3_1)
print(task3_2)

# A good example output is:
#
# Step #1:
# Months and rainfall values when the amount of rain was greater than 100mm:
# [('JAN', 111.4), ('FEB', 126.1), ('AUG', 140.2), ('NOV', 128.4), ('DEC', 142.2)]
# ... etc.