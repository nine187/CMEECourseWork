#!/usr/bin/env python3
"""
Some functions exemplifying the use of control statements
"""
__author__ = 'Pasith Prayoorat(pp1922@ic.ac.uk'
__version__ = '0.0.1'

import sys

def even_or_odd(x=0): # if not specified, x should take value 0.

    """Find whether a number x is even or odd."""
    if x % 2 == 0: #The conditional if
        return f"{x} is Even!"
    return f"{x} is Odd!"

def largest_divisor_five(x=120):
    """Find which is the largest divisor of x among 2,3,4,5."""
    largest = 0
    if x % 5 == 0:
        largest = 5
    elif x % 4 == 0: #means "else, if"
        largest = 4
    elif x % 3 == 0:
        largest = 3
    elif x % 2 == 0:
        largest = 2
    else: # When all other (if, elif) conditions are not met
        return f"No divisor found for {x}!" # Each function can return a value or a variable.
    return f"The largest divisor of {x} is {largest}"

def is_prime(x=70):
    """Find whether an integer is prime."""
    for i in range(2, x): #  "range" returns a sequence of integers
        if x % i == 0:
            print(f"{x} is not a prime: {i} is a divisor") 
            return False
    print(f"{x} is a prime!")
    return True 

def find_all_primes(x=22):
    """Find all the primes up to x"""
    allprimes = []
    for i in range(2, x + 1):
        if is_prime(i):
            allprimes.append(i)
    print(f"There are {len(allprimes)} primes between 2 and {x}")
    return allprimes
      
def main(argv):
    print(even_or_odd(22))
    print(even_or_odd(33))
    print(largest_divisor_five(120))
    print(largest_divisor_five(121))
    print(is_prime(60))
    print(is_prime(59))
    print(find_all_primes(100))
    return 0

if (__name__ == "__main__"):
    status = main(sys.argv)
    sys.exit(status)