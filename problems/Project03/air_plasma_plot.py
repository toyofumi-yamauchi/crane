import numpy as np
import matplotlib.pyplot as plt

T_e = 10
filename = 'air_plasma_output.csv'
data = np.genfromtxt(filename, dtype=float, delimiter=',', skip_header=1)

t    = data[:,0]
N    = data[:,1]
Np   = data[:,2]
N2   = data[:,3]
N2p  = data[:,4]
N2O  = data[:,5]
N2Op = data[:,6]
N2Om = data[:,7]
NO   = data[:,8]
NOp  = data[:,9]
NOm  = data[:,10]
NO2  = data[:,11]
NO2p = data[:,12]
NO2m = data[:,13]
O    = data[:,14]
Op   = data[:,15]
Om   = data[:,16]
O2   = data[:,17]
O2p  = data[:,18]
O2m  = data[:,19]
e    = data[:,20]

# Crane solutions
lINEWIDTH1 = 1.0
lINEWIDTH2 = 2.0
plt.figure(figsize=(5.5,4.0))
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

plt.legend(loc='lower center', ncol=3, framealpha=1.0)
plt.xticks(fontsize=12)
plt.yticks(fontsize=12)
plt.xlabel('t [s]', fontsize=12)
plt.ylabel('n [m$^-$$^3$]', fontsize=12)
plt.title('Air plasma composition ($T_e$ = {:.0f} eV)'.format(T_e))
plt.grid()
plt.tight_layout()
plt.savefig('air_plasma_plot.png',dpi=300)
#plt.show()
