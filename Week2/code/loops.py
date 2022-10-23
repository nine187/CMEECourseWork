#!/usr/bin/env python3


"""A script containing loop examples."""

__author__ = 'Pasith Prayoonrat (pp1922@ic.ac.uk)'
__version__ = '0.0.1'

# FOR loops
for i in range(5):
    print(i)

my_list = [0, 2, "geronimo!", 3.0, True, False]
for k in my_list:
    print(k)

total = 0
summands = [0, 1, 11, 111, 1111]
for s in summands:
    total = total + s
    print(total)

# WHILE loop
z = 0
while z < 100:
    z = z + 1
    print(z)