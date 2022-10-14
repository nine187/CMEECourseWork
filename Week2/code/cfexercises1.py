__author__ = 'Pasith Prayoorat(pp1922@ic.ac.uk'
__version__ = '0.0.1'

import sys #import the system

def foo_1(x=5):
    """Calculate the square root of x"""
    return x ** 0.5

def foo_2(x=5, y=2):
    """If x is more than y, return y"""
    if x > y:
        return x
    return y

def foo_3(x=4, y=5, z=6):
    """ Put x, y, and z in an order from lowest to the highest."""
    if x > y:
        tmp = y
        y = x
        x = tmp
    if y > z:
        tmp = z
        z = y
        y = tmp
    return [x, y, z]

def foo_4(x=6):
    """Factorial of x"""
    result = 1
    for i in range(1, x + 1):
        result = result * i
    return result

def foo_5(x=10):
    """ A recursive function that calculates the factorial of x """
    if x == 1:
        return 1
    return x * foo_5(x - 1)
     
def foo_6(x=5):
    """Calculate the factorial of x in a different way; no if statement involved """
    facto = 1
    while x >= 1:#
        facto = facto * x
        x = x - 1
    return facto