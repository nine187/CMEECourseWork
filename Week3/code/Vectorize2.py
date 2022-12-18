""""Stochastic implementation of the Ricker model and a vectorised version"""

__appname__ = "Vectorise2.py"
__author__ = "Dashing Dingos"
__version__ = "0.0.1"
__license__ = "CMEE"

# Import packages
import numpy as np
import sys
import time

# from Vec~2.R Non-Vectorized Stochastic Ricker equation with gaussian fluctuations
def stochrick(p0=np.random.uniform(.5, 1.5, 1000), r=1.2, K=1, sigma=0.2, numyears=100):
    """"Runs the stochastic Ricker equation with Gaussian fluctuations"""

    N = np.zeros((numyears, len(p0))) 

    N[0] = p0 #initialize empty matrix

    for pop in range(len(p0)):  #loop through the populations
        for yr in range(1, numyears):    #for each pop, loop through the years
            N[yr, pop] = N[yr - 1, pop] * np.exp(r * (1 - N[yr - 1, pop] / K) + np.random.normal(0, sigma, 1))# add one fluctuation from normal distribution
    return N

# Vectorizes the above to the extent possible, with improved performance:

def stochrickvect(p0=np.random.uniform(.5, 1.5, 1000), r=1.2, K=1, sigma=0.2, numyears=100):
    """"Runs vectorised version of stochastic Ricker equation with Gaussian fluctuations"""

    N = np.zeros((numyears, len(p0)))  # initialize empty matrix
    N[0] = p0
    for yr in range(1, numyears):  # for each pop, loop through the years
        # note: adds fluctuation from normal distribution at end of line
        N[yr] = N[yr - 1] * np.exp(r * (1 - N[yr - 1] / K) + np.random.normal(0, sigma, len(p0)))
    return N

# Time the two functions
def main(argv):
    """Function to timing the running time for two defined function"""

    # 1: Time the looping function 
    start = time.time()
    T = stochrick()
    end = time.time()
    print("Non-vectorized Stochastic Ricker in Python takes:",end - start, "seconds")

    # 2: Time the vectorized function
    start = time.time()
    T = stochrickvect()
    end = time.time()
    print("Vectorized Stochastic Ricker in Python takes:",end - start, "seconds")


if __name__ == "__main__":
    status = main(sys.argv)
    sys.exit(status)