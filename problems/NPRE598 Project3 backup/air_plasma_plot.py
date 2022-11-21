import numpy as np
import matplotlib.pyplot as plt

T_e = 30
filename = 'air_plasma_output.csv'
#filename = 'air_plasma_copy_output.csv'
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
time_factor = 1
plt.plot(t*time_factor, e,   linestyle='-.', linewidth=lINEWIDTH2, color='royalblue', label='$e$')
plt.plot(t*time_factor, N2,  linestyle='-',  linewidth=lINEWIDTH2, color='green',     label='$N_2$')
plt.plot(t*time_factor, N,   linestyle='-',  linewidth=lINEWIDTH2, color='lime',      label='$N$')
plt.plot(t*time_factor, O2,  linestyle='-',  linewidth=lINEWIDTH2, color='orangered', label='$O_2$')
plt.plot(t*time_factor, O,   linestyle='-',  linewidth=lINEWIDTH2, color='orange',    label='$O$')
plt.plot(t*time_factor, N2p, linestyle='--', linewidth=lINEWIDTH2, color='green',     label='$N_2^+$')
plt.plot(t*time_factor, Np,  linestyle='--', linewidth=lINEWIDTH2, color='lime',      label='$N^+$')
plt.plot(t*time_factor, O2p, linestyle='--', linewidth=lINEWIDTH2, color='orangered', label='$O_2^+$')
plt.plot(t*time_factor, Op,  linestyle='--', linewidth=lINEWIDTH2, color='orange',    label='$O^+$')
plt.plot(t*time_factor, O2m, linestyle='-.',  linewidth=lINEWIDTH2, color='purple',   label='$O_2^-$')
plt.plot(t*time_factor, Om,  linestyle='-.',  linewidth=lINEWIDTH2, color='deeppink', label='$O^-$')

#plt.xscale('log')
plt.yscale('log')

#plt.xlim((min(t),max(t)))
plt.xticks(fontsize=12)
plt.xlabel('t [s]', fontsize=12)
#plt.xlabel('t [μs]', fontsize=12)
plt.ylim(((1e-5,1e25)))
plt.yticks(fontsize=12)
plt.ylabel('n [cm$^-$$^3$]', fontsize=12)
#plt.legend(loc='lower center', ncol=3, framealpha=1.0)
plt.legend(loc='best', ncol=3, framealpha=1.0)
plt.title('Air plasma composition ($T_e$ = {:.0f} eV)'.format(T_e))
plt.grid()
plt.tight_layout()
plt.savefig('air_plasma_plot.png',dpi=300)
plt.show()
