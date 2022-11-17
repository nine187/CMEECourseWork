#Author: Pasith Prayoonrat (pp1922@ic.ac.uk)
#Script: LV1.py
#Created: Nov 2022
#Desc: Practical work on Biological Python 2

#import stuff
import numpy as np
import scipy as sc
import scipy.integrate as integrate
import matplotlib.pylab as p

#function for the equation
def dCR_dt(pops, t=0):
    R = pops[0]
    C = pops[1]
    dRdt = r * R - a * R * C
    dCdt = -z * C + e * a * R * C
    return np.array([dRdt, dCdt])

type(dCR_dt)

#assign the parameter values
r = 1
a = 0.1
z = 1.5
e = 0.75

#define the time vector
t = np.linspace(0, 15, 1000)

R0 = 10
C0 = 5
RC0 = np.array([R0, C0])
pops, infodict = integrate.odeint(dCR_dt, RC0, t, full_output = True)
pops
type(infodict)
infodict.keys()
infodict['message']

f1 = p.figure()
p.plot(t, pops[:,0], 'g-', label='Resource density')
p.plot(t, pops[:,1]  , 'b-', label='Consumer density')
p.grid()
p.legend(loc='best')
p.xlabel('Time')
p.ylabel('Population density')
p.title('Consumer-Resource population dynamics')

f2 = p.figure()
p.plot(pops[:,0], pops[:,1], 'r-')
p.grid()
p.xlabel('Resource density')
p.ylabel('Consumer density')
p.title('Consumer-Resource population dynamics')

f1.savefig('../results/LV_model.pdf')
f2.savefig('../results/LV_model2.pdf')