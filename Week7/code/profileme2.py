#!/usr/bin/env python3
"""
Script using loop to improve profile
"""
#Author: Pasith Prayoonrat (pp1922@ic.ac.uk)
#Script: proifleme2.py
#Created: Nov 2022
#Desc: Pprofileme script


def my_squares(iters):
    out = [i ** 2 for i in range(iters)]
    return out

def my_join(iters, string):
    out = ''
    for i in range(iters):
        out += ", " + string
    return out

def run_my_funcs(x,y):
    print(x,y)
    my_squares(x)
    my_join(x,y)
    return 0

run_my_funcs(10000000, "My string")