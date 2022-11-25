import numpy as np
import matplotlib.pyplot as plt
from datetime import datetime

now = datetime.now()
current_time = now.strftime("%Y-%m-%d %H:%M:%S %p")
#print(current_time)

filename = 'air_plasma'
titlename = 'air_plasma: 50-50 N2-O2'
data = np.genfromtxt(filename+'_output.csv', dtype=float, delimiter=',', skip_header=1)

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
e    = data[:,22]

print('{:.2e}'.format(t[-1]))
print('{:.0f}'.format(len(t)))

# Crane solutions
lINEWIDTH1 = 1.0
lINEWIDTH2 = 2.0
time_factor = 1
density_factor = 1e6
plt.figure(figsize=(5.5,4.0))
plt.plot(t*time_factor, O2*density_factor,  linestyle='-',  linewidth=lINEWIDTH2, color='orangered', label='$O_2$')
plt.plot(t*time_factor, O*density_factor,   linestyle='-',  linewidth=lINEWIDTH2, color='orange',    label='$O$')
plt.plot(t*time_factor, NO*density_factor,  linestyle='-',  linewidth=lINEWIDTH2, color='purple',    label='$NO$')
plt.plot(t*time_factor, N2O*density_factor, linestyle='-',  linewidth=lINEWIDTH2, color='deeppink',  label='$N_2O$')
plt.plot(t*time_factor, NO2*density_factor, linestyle='-',  linewidth=lINEWIDTH2, color='lightpink', label='$NO_2$')
plt.plot(t*time_factor, N2*density_factor,  linestyle='-',  linewidth=lINEWIDTH2, color='green',     label='$N_2$')
plt.plot(t*time_factor, N*density_factor,   linestyle='-',  linewidth=lINEWIDTH2, color='lime',      label='$N$')
#plt.plot([0,0],[0,0],'w.',label=' ')
plt.plot(t*time_factor, O2p*density_factor, linestyle='--', linewidth=lINEWIDTH2, color='orangered', label='$O_2^+$')
plt.plot(t*time_factor, Op*density_factor,  linestyle='--', linewidth=lINEWIDTH2, color='orange',    label='$O^+$')
plt.plot(t*time_factor, NOp*density_factor, linestyle='--', linewidth=lINEWIDTH2, color='purple',    label='$NO^+$')
plt.plot(t*time_factor, N2Op*density_factor,linestyle='--', linewidth=lINEWIDTH2, color='deeppink',  label='$N_2O$$^+$')
plt.plot(t*time_factor, NO2p*density_factor,linestyle='--', linewidth=lINEWIDTH2, color='lightpink', label='$NO_2$$^+$')
plt.plot(t*time_factor, N2p*density_factor, linestyle='--', linewidth=lINEWIDTH2, color='green',     label='$N_2^+$')
plt.plot(t*time_factor, Np*density_factor,  linestyle='--', linewidth=lINEWIDTH2, color='lime',      label='$N^+$')
#plt.plot([0,0],[0,0],'w.',label=' ')
plt.plot(t*time_factor, O2m*density_factor, linestyle='-.', linewidth=lINEWIDTH2, color='orangered', label='$O_2^-$')
plt.plot(t*time_factor, Om*density_factor,  linestyle='-.', linewidth=lINEWIDTH2, color='orange',    label='$O^-$')
plt.plot(t*time_factor, NOm*density_factor, linestyle='-.', linewidth=lINEWIDTH2, color='purple',    label='$NO^-$')
plt.plot(t*time_factor, N2Om*density_factor,linestyle='-.', linewidth=lINEWIDTH2, color='deeppink',  label='$N_2O$$^-$')
plt.plot(t*time_factor, NO2m*density_factor,linestyle='-.', linewidth=lINEWIDTH2, color='lightpink', label='$NO_2$$^-$')
plt.plot(t*time_factor, e*density_factor,   linestyle='-.', linewidth=lINEWIDTH2, color='royalblue', label='$e$')

plt.xscale('log')
plt.xlim((t[1]*time_factor,t[-1]*time_factor))
plt.xticks(fontsize=12)
plt.xlabel('t [s]', fontsize=12)
#plt.xlabel('t [μs]', fontsize=12)

plt.yscale('log')
plt.ylim(((1e11,1e22)))
plt.yticks(fontsize=12)
plt.ylabel('n [m$^-$$^3$]', fontsize=12)

plt.legend(loc='best', ncol=3, framealpha=1.0, prop={'size': 9})
plt.title(titlename)
plt.grid()
plt.tight_layout()
#plt.savefig(filename+'.png',dpi=300)
plt.savefig(filename+', log-scale.png',dpi=300)

plt.figure(figsize=(5.5,4.0))
plt.plot(t*time_factor, O2*density_factor,  linestyle='-',  linewidth=lINEWIDTH2, color='orangered', label='$O_2$')
plt.plot(t*time_factor, O*density_factor,   linestyle='-',  linewidth=lINEWIDTH2, color='orange',    label='$O$')
plt.plot(t*time_factor, NO*density_factor,  linestyle='-',  linewidth=lINEWIDTH2, color='purple',    label='$NO$')
plt.plot(t*time_factor, N2O*density_factor, linestyle='-',  linewidth=lINEWIDTH2, color='deeppink',  label='$N_2O$')
plt.plot(t*time_factor, NO2*density_factor, linestyle='-',  linewidth=lINEWIDTH2, color='lightpink', label='$NO_2$')
plt.plot(t*time_factor, N2*density_factor,  linestyle='-',  linewidth=lINEWIDTH2, color='green',     label='$N_2$')
plt.plot(t*time_factor, N*density_factor,   linestyle='-',  linewidth=lINEWIDTH2, color='lime',      label='$N$')
#plt.plot([0,0],[0,0],'w.',label=' ')
plt.plot(t*time_factor, O2p*density_factor, linestyle='--', linewidth=lINEWIDTH2, color='orangered', label='$O_2^+$')
plt.plot(t*time_factor, Op*density_factor,  linestyle='--', linewidth=lINEWIDTH2, color='orange',    label='$O^+$')
plt.plot(t*time_factor, NOp*density_factor, linestyle='--', linewidth=lINEWIDTH2, color='purple',    label='$NO^+$')
plt.plot(t*time_factor, N2Op*density_factor,linestyle='--', linewidth=lINEWIDTH2, color='deeppink',  label='$N_2O$$^+$')
plt.plot(t*time_factor, NO2p*density_factor,linestyle='--', linewidth=lINEWIDTH2, color='lightpink', label='$NO_2$$^+$')
plt.plot(t*time_factor, N2p*density_factor, linestyle='--', linewidth=lINEWIDTH2, color='green',     label='$N_2^+$')
plt.plot(t*time_factor, Np*density_factor,  linestyle='--', linewidth=lINEWIDTH2, color='lime',      label='$N^+$')
#plt.plot([0,0],[0,0],'w.',label=' ')
plt.plot(t*time_factor, O2m*density_factor, linestyle='-.', linewidth=lINEWIDTH2, color='orangered', label='$O_2^-$')
plt.plot(t*time_factor, Om*density_factor,  linestyle='-.', linewidth=lINEWIDTH2, color='orange',    label='$O^-$')
plt.plot(t*time_factor, NOm*density_factor, linestyle='-.', linewidth=lINEWIDTH2, color='purple',    label='$NO^-$')
plt.plot(t*time_factor, N2Om*density_factor,linestyle='-.', linewidth=lINEWIDTH2, color='deeppink',  label='$N_2O$$^-$')
plt.plot(t*time_factor, NO2m*density_factor,linestyle='-.', linewidth=lINEWIDTH2, color='lightpink', label='$NO_2$$^-$')
plt.plot(t*time_factor, e*density_factor,   linestyle='-.', linewidth=lINEWIDTH2, color='royalblue', label='$e$')

plt.xscale('log')
plt.xlim((t[1]*time_factor,t[-1]*time_factor))
plt.xticks(fontsize=12)
plt.xlabel('t [s]', fontsize=12)
#plt.xlabel('t [μs]', fontsize=12)

#plt.yscale('log')
#plt.ylim(((1e11,1e21)))
plt.yticks(fontsize=12)
plt.ylabel('n [m$^-$$^3$]', fontsize=12)

plt.legend(loc='best', ncol=3, framealpha=1.0, prop={'size': 9})
plt.title(titlename)
plt.grid()
plt.tight_layout()
plt.savefig(filename+'.png',dpi=300)
#plt.savefig(filename+', log-scale.png',dpi=300)

plt.show()
