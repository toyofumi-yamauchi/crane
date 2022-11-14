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
lINEWIDTH1 = 1.0
lINEWIDTH2 = 2.0
plt.plot(t, e,   linestyle='-.', linewidth=lINEWIDTH2, color='royalblue', label='$e$')
plt.plot(t, N2,  linestyle='-',  linewidth=lINEWIDTH2, color='green',     label='$N_2$')
plt.plot(t, N,   linestyle='-',  linewidth=lINEWIDTH2, color='lime',      label='$N$')
plt.plot(t, O2,  linestyle='-',  linewidth=lINEWIDTH2, color='orangered', label='$O_2$')
plt.plot(t, O,   linestyle='-',  linewidth=lINEWIDTH2, color='orange',    label='$O$')
plt.plot(t, N2p, linestyle='--', linewidth=lINEWIDTH2, color='green',     label='$N_2^+$')
plt.plot(t, Np,  linestyle='--', linewidth=lINEWIDTH2, color='lime',      label='$N^+$')
plt.plot(t, O2p, linestyle='--', linewidth=lINEWIDTH2, color='orangered', label='$O_2^+$')
plt.plot(t, Op,  linestyle='--', linewidth=lINEWIDTH2, color='orange',    label='$O^+$')
plt.plot(t, O2m, linestyle='-.',  linewidth=lINEWIDTH2, color='purple',   label='$O_2^-$')
plt.plot(t, Om,  linestyle='-.',  linewidth=lINEWIDTH2, color='deeppink', label='$O^-$')

plt.yscale('log')

plt.legend(loc='best', ncol=1, framealpha=1.0)
plt.xticks(fontsize=15)
plt.yticks(fontsize=15)
plt.xlabel('t', fontsize=18)
plt.ylabel('n', fontsize=18)
plt.grid()
plt.tight_layout()
#plt.savefig('air_plasma_plot.png',dpi=300)
plt.show()
