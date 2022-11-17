#Author: Pasith Prayoonrat (pp1922@ic.ac.uk)
#Script: LV2.py
#Created: Nov 2022
#Desc: Practical work on Biological Python 2

#import stuff
import numpy as np
import scipy.integrate as integrate
import matplotlib.pylab as p
import sys

#function for the equation
def dCR_dt(pops, t=0):
    R = pops[0]
    C = pops[1]
    dRdt = r * R * (1 - ( R / K ))- a * R * C
    dCdt = -z * C + e * a * R * C

    return np.array([dRdt, dCdt])

type(dCR_dt)

#define the time vector
t = np.linspace(0, 15, 1000)

#initial value
R0 = 10
C0 = 5
RC0 = np.array([R0, C0])
K = 1000

#function
def LV(r, a, z ,e, K):
    pops, infodict = integrate.odeint(dCR_dt, RC0, t, full_output = True)
    print("The final poppulation density for R(Resources) is",str(pops[-1,0]),"and C(Consumers) is",pops[-1,1])
    pops
    type(infodict)
    infodict.keys()
    infodict['message']

#visualization
    f1 = p.figure()
    p.plot(t, pops[:,0], 'g-', label='Resource density')
    p.plot(t, pops[:,1]  , 'b-', label='Consumer density')
    p.grid()
    p.legend(loc='best')
    p.xlabel('Time')
    p.ylabel('Population density')
    p.title('Consumer-Resource population dynamics')
    p.text(16,1,"r = " + str(r))
    p.text(16,2,"a = " + str(a))
    p.text(16,3,"z = " + str(z))
    p.text(16,4,"e = " + str(e))
    p.text(16,5,"K = " + str(int(K)))

    f2 = p.figure()
    p.plot(pops[:,0], pops[:,1], 'r-')
    p.grid()
    p.xlabel('Resource density')
    p.ylabel('Consumer density')
    p.title('Consumer-Resource population dynamics')
    p.text(10.5,1,"r = " + str(r))
    p.text(10.5,2,"a = " + str(a))
    p.text(10.5,3,"z = " + str(z))
    p.text(10.5,4,"e = " + str(e))
    p.text(10.5,5,"K = " + str(int(K)))

    f1.savefig('../results/LV2_model.pdf')
    f2.savefig('../results/LV2_model2.pdf')

#sys.argv for multiple arguments 
if __name__ == "__main__":
    if len(sys.argv) == 6:
        #import ipdb; ipdb.set_trace()
        r = float(sys.argv[1])
        a = float(sys.argv[2])
        z = float(sys.argv[3])
        e = float(sys.argv[4])
        K = float(sys.argv[5])
        LV(r, a, z, e, K)
    else:
        print("Using default variables of r = 0.5, a = 0.5, z = 0.5, e = 0.5 and K = 10.")
        r = float(0.5)
        a = float(0.5)
        z = float(0.5)
        e = float(0.5)
        K = float(10)
        LV(r, a, z, e, K)