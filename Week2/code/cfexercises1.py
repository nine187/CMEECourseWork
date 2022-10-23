#!/usr/bin/env python3


"""Different foo function examples."""

__author__ = 'Pasith Prayoonrat (pp1922@ic.ac.uk)'
__version__ = '0.0.1'


import sys #import the system

def foo_1(x = 5): #if not specified x should take the value of 5 for reasons
    """Calculate the square root of x"""
    y = x ** 0.5
    return " The square root of %d is %d" % (x , y)

def foo_2(x = 5, y = 2): # x = 5 and y = 2 is the default
    """If x is more than y, return y"""
    if x > y:
        return "%d is the higher number." % x
    return "%d is the higher number." % y

def foo_3(x = 4, y = 5, z = 6): # 4,5,6 is the default
    """ Put x, y, and z in an order from lowest to the highest."""
    if x > y:
        tmp = y
        y = x
        x = tmp
    if y > z:
        tmp = z
        z = y
        y = tmp
    return "Lowest number is %d. Second from highest number is %d. Highest number is %d." % (x, y, z)

def foo_4(x = 6): # 6 is the default
    """Factorial of x"""
    result = 1
    for i in range(1, x + 1):
        result = result * i
    return "Factorial of %d is %d" % (x, result)

def foo_5(x = 10 ): #10 is the default
    """ A recursive function that calculates the factorial of x """
    if x == 1:
        return 1
    return x * foo_5(x - 1)
     
def foo_6(x = 5):
    """Calculate the factorial of x in a different way; no if statement involved """
    facto = 1
    while x >= 1:#
        facto = facto * x
        x = x - 1
    return facto

#functions testing 

def main(argv):
    """Entry point"""
    print(foo_1(5))
    print(foo_2(5, 2))
    print(foo_3(4, 5, 6))
    print(foo_4(5))
    print(foo_5(10))
    print(foo_6(5))
    return 0
#makes sure the file is usable and importable
if __name__ == "__main__":
    status = main(sys.argv)
    sys.exit(status)