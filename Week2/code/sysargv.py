#!/usr/bin/env python3


"""A script contataining sys.argv in Python explaining the basics of it."""

__author__ = 'Pasith Prayoonrat (pp1922@ic.ac.uk)'
__version__ = '0.0.1'

import sys
print("This is the name of the script: ", sys.argv[0])
print("Number of arguments: ", len(sys.argv))
print("The arguments are: ", str(sys.argv))