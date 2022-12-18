#!/usr/bin/env python3
"""A script showing how to input a file in python."""
__author__ = 'Pasith Prayoonrat (pp1922@ic.ac.uk)'
__version__ = '0.0.1'

f = open('../sandbox/test.txt', 'r')

for line in f:
    print(line)

f.close()

f = open('../sandbox/test.txt', 'r')

for line in f:
    print(line)

f.close()

f = open('../sandbox/test.txt', 'r')
for line in f:
    if len(line.strip()) > 0:
        print(line)

f.close()