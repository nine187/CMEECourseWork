#!/usr/bin/env python3

"""
compare loop vs lis vs join method speed
"""
#Author: Pasith Prayoonrat (pp1922@ic.ac.uk)
#Script: timeitme.py
#Created: Nov 2022
#Desc: timeitme.py

##############################################################################
# loops vs. list comprehensions: which is faster?
##############################################################################

iters = 1000000

import timeit

from profileme import my_squares as my_squares_loops

from profileme2 import my_squares as my_squares_lc

##############################################################################
# loops vs. the join method for strings: which is faster?
##############################################################################

mystring = "my string"

from profileme import my_join as my_join_join

from profileme2 import my_join as my_join