#Author: Dashing Dingos
#Script: LV3.py
#Created: Nov 2022
#Desc: Groupwork on python

import matplotlib.pylab as p
import numpy as np
import scipy.integrate as integrate


def dCR_dt(pops, t=0):
    R = pops[0]
    C = pops[1]
    dRdt = R * ((1 + (r + g)) * (1 - R/K) - a * C) 
    dCdt = C * ((1 - (r + g)) + e * a * R)
    return np.array([dRdt, dCdt])

type(dCR_dt)

r = 0.5
a = 0.5
z = 0.5
e = 0.5
#constant that won't exceed the graph
K = 10
#Gausian
g = np.random.normal(1,10)
#define the time series with numpy linearly spaced value func.
t = np.linspace(0, 15, 1000)
R0 = 10
C0 = 5
RC0 = np.array([R0, C0])
pops, infodict = integrate.odeint(dCR_dt, RC0, t, full_output = True)
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

f2 = p.figure()
p.plot(pops[:,0], pops[:,1], 'r-')
p.grid()
p.xlabel('Resource density')
p.ylabel('Consumer density')
p.title('Consumer-Resource population dynamics')

#save the plot
f1.savefig('../results/LV3_model.pdf')
f2.savefig('../results/LV3_model2.pdf')