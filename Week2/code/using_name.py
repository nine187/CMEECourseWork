#!/usr/bin/env python3


"""A script containing the use of a main module. """

__author__ = 'Pasith Prayoonrat (pp1922@ic.ac.uk)'
__version__ = '0.0.1'

# Filename: using_name.py

if __name__ == '__main__':
    print('This program is being run by itself')
else:
    print('I am being imported from another module')
    
print("This module's name is: " + __name__)