"""Vectorize1.R rewritten in python"""

__appname__ = 'Vectorize1.py'
__author__ = 'Dashing Dingos'
__version__ = '0.0.1'
__license__ = "CMEE"

import numpy as np
import time

# Generate random numbers
m = np.random.uniform(low=0 , high=1, size=(1000,1000))


#loop 
def SumAllElements(m):
    """Loop way to calculate the sum of all random values generated"""
    Dimentions = m.shape
    Tot = 0
    for i in range(0,Dimentions[0]):
        for j in range(0, Dimentions[1]):
            Tot = Tot +  m[i,j]
    
    return Tot


#do time measurement
# 1:time the looping function
start = time.time()       
SumAllElements(m)
end = time.time()
Time_period = end - start
print("Python SumAllElements function: {}".format(Time_period), "seconds")


#2:time the vectorized sum function.
start = time.time()
m.sum()
end = time.time()
Time_period2 = end - start
print("Python sum vectorised function: {}".format(Time_period2), "seconds")
