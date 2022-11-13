import numpy as np
import matplotlib.pyplot as plt

filename = 'air_plasma_output.csv'
data = np.genfromtxt(filename, dtype=float, delimiter=',', skip_header=1)

t = data[:,0]
N   = data[:,1]
Np  = data[:,2]
N2  = data[:,3]
N2p = data[:,4]
O   = data[:,5]
Op  = data[:,6]
Om  = data[:,7]
O2  = data[:,8]
O2p = data[:,9]
O2m = data[:,10]
e   = data[:,11]

t_exact = np.linspace(0, 3, 100)

# Crane solutions
lINEWIDTH = 2.0
plt.plot(t, e,   linewidth=lINEWIDTH, label='$e$')
plt.plot(t, N,   linewidth=lINEWIDTH, label='$N$')
plt.plot(t, Np,  linewidth=lINEWIDTH, label='$N^+$')
plt.plot(t, N2,  linewidth=lINEWIDTH, label='$N_2$')
plt.plot(t, N2p, linewidth=lINEWIDTH, label='$N_2^+$')
plt.plot(t, O,   linewidth=lINEWIDTH, label='$O$')
plt.plot(t, Op,  linewidth=lINEWIDTH, label='$O^+$')
plt.plot(t, Om,  linewidth=lINEWIDTH, label='$O^-$')
plt.plot(t, O2,  linewidth=lINEWIDTH, label='$O_2$')
plt.plot(t, O2p, linewidth=lINEWIDTH, label='$O_2^+$')
plt.plot(t, O2m, linewidth=lINEWIDTH, label='$O_2^-$')

plt.legend(loc='best', ncol=3)
plt.xticks(fontsize=15)
plt.yticks(fontsize=15)
plt.xlabel('t', fontsize=18)
plt.ylabel('n', fontsize=18)
#plt.savefig('ex1_plot.png')
plt.show()
