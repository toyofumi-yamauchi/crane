import numpy as np
import matplotlib.pyplot as plt
from datetime import datetime

now = datetime.now()
current_time = now.strftime("%Y-%m-%d %H:%M:%S %p")
#print(current_time)

N = 3
species = 7
T_e = np.array((5,10,15))
#savename = np.array(('N2','N','N2+','N+','e'))
savename = np.array(('O2','O','O2+','O+','O2-','O-','e'))
#titlename = np.array(('$N_2$','$N$','$N_2^+$','$N^+$','$e$'))
titlename = np.array(('$O_2$','$O$','$O_2^+$','$O^+$','$O_2^-$','$O^-$','$e$'))
ID = np.array((17,14,18,15,19,16,22))

#for j in range(0,species):
for j in range(4,5):
    plt.figure(figsize=(5.5,4.5))
    for i in range(0,N):
        filename = 'O2_only_case'+str(i+1)
        titlename = 'O2 only: Case #'+str(i+1)
        data = np.genfromtxt(filename+'_output.csv', dtype=float, delimiter=',', skip_header=1)
        if j == 0:
            print(np.shape(data))
            print('{:.2e}'.format(data[-1,0]))
        plt.loglog(data[:,0],data[:,ID[j]]*1e6,label='$T_e$ = {:.0f} eV'.format(T_e[i]))
    plt.xscale('log')
    plt.xticks(fontsize=12)
    plt.xlabel('t [s]', fontsize=12)
    plt.yscale('log')
    #plt.ylim(((1e11,1e20)))
    plt.ylim(((1e-5,1e8)))
    plt.yticks(fontsize=12)
    plt.ylabel('n [m$^-$$^3$]', fontsize=12)

    plt.legend(loc='best', framealpha=1.0)
    plt.title(savename[j]+' Density vs Time')
    plt.grid()
    plt.tight_layout()
    #plt.savefig(filename+'.png',dpi=300)
    plt.savefig('O2 only ('+savename[j]+' Density).png',dpi=300)
#plt.show()


plt.figure(figsize=(5.5,4.5))
colorlist=np.array(('tab:blue','tab:orange','tab:green'))
for i in range(0,N):
    filename = 'O2_only_case'+str(i+1)
    titlename = 'O2 only: Case #'+str(i+1)
    data = np.genfromtxt(filename+'_output.csv', dtype=float, delimiter=',', skip_header=1)
    max_O2p = max(data[:,18])
    max_index_O2p = np.argmax(data[:,18])
    print('{:.2e}'.format(data[max_index_O2p,0]))
    plt.semilogx(data[1:,0],data[1:,18]/(data[1:,18]+data[1:,15]),color=colorlist[i],label='$T_e$ = {:.0f} eV (max $n_O$$_2$$_+$ = {:.2e} $m^-$$^3$)'.format(T_e[i],data[max_index_O2p,18]))
    plt.semilogx(data[max_index_O2p,0],data[max_index_O2p,18]/(data[max_index_O2p,18]+data[max_index_O2p,15]),'*',color=colorlist[i])
plt.xscale('log')
plt.xticks(fontsize=12)
plt.xlabel('t [s]', fontsize=12)
#plt.yscale('log')
#plt.ylim(((1e11,1e20)))
plt.yticks(fontsize=12)
plt.ylabel('$O_2$$^+$ Fraction [-]', fontsize=12)

plt.legend(loc='lower left', framealpha=1.0)
plt.title('O2+ Fraction vs Time')
plt.grid()
plt.tight_layout()
#plt.savefig(filename+'.png',dpi=300)
plt.savefig('O2 only (O2+ fraction).png',dpi=300)
plt.show()

'''
filename = 'N2_only_case3'
titlename = 'N2 only: Case #3'
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
e    = data[:,21]

print('{:.2e}'.format(t[-1]))
print('{:.0f}'.format(len(t)))

# Crane solutions
lINEWIDTH1 = 1.0
lINEWIDTH2 = 2.0
time_factor = 1
density_factor = 1e6
plt.figure(figsize=(5.5,4.0))
#plt.plot(t*time_factor, N2*density_factor,  linestyle='-',  linewidth=lINEWIDTH2, color='green',     label='$N_2$')
#plt.plot(t*time_factor, N*density_factor,   linestyle='-',  linewidth=lINEWIDTH2, color='lime',      label='$N$')
plt.plot(t*time_factor, O2*density_factor,  linestyle='-',  linewidth=lINEWIDTH2, color='orangered', label='$O_2$')
plt.plot(t*time_factor, O*density_factor,   linestyle='-',  linewidth=lINEWIDTH2, color='orange',    label='$O$')
plt.plot([0,0],[0,0],'w.',label=' ')
#plt.plot(t*time_factor, N2p*density_factor, linestyle='--', linewidth=lINEWIDTH2, color='green',     label='$N_2^+$')
#plt.plot(t*time_factor, Np*density_factor,  linestyle='--', linewidth=lINEWIDTH2, color='lime',      label='$N^+$')
plt.plot(t*time_factor, O2p*density_factor, linestyle='--', linewidth=lINEWIDTH2, color='orangered', label='$O_2^+$')
plt.plot(t*time_factor, Op*density_factor,  linestyle='--', linewidth=lINEWIDTH2, color='orange',    label='$O^+$')
plt.plot([0,0],[0,0],'w.',label=' ')
plt.plot(t*time_factor, O2m*density_factor, linestyle='-.', linewidth=lINEWIDTH2, color='purple',   label='$O_2^-$')
plt.plot(t*time_factor, Om*density_factor,  linestyle='-.', linewidth=lINEWIDTH2, color='deeppink', label='$O^-$')
plt.plot(t*time_factor, e*density_factor,   linestyle='-.', linewidth=lINEWIDTH2, color='royalblue', label='$e$')

plt.xscale('log')
plt.xlim((t[1]*time_factor,t[-1]*time_factor))
plt.xticks(fontsize=12)
plt.xlabel('t [s]', fontsize=12)
#plt.xlabel('t [μs]', fontsize=12)

plt.yscale('log')
plt.ylim(((1e11,1e20)))
plt.yticks(fontsize=12)
plt.ylabel('n [m$^-$$^3$]', fontsize=12)

plt.legend(loc='best', ncol=3, framealpha=1.0)
plt.title(titlename)
plt.grid()
plt.tight_layout()
#plt.savefig(filename+'.png',dpi=300)
plt.savefig(filename+', log-scale.png',dpi=300)

plt.figure(figsize=(5.5,4.0))
plt.plot(t*time_factor, N2*density_factor,  linestyle='-',  linewidth=lINEWIDTH2, color='green',     label='$N_2$')
plt.plot(t*time_factor, N*density_factor,   linestyle='-',  linewidth=lINEWIDTH2, color='lime',      label='$N$')
#plt.plot(t*time_factor, O2*density_factor,  linestyle='-',  linewidth=lINEWIDTH2, color='orangered', label='$O_2$')
#plt.plot(t*time_factor, O*density_factor,   linestyle='-',  linewidth=lINEWIDTH2, color='orange',    label='$O$')
plt.plot(t*time_factor, N2p*density_factor, linestyle='--', linewidth=lINEWIDTH2, color='green',     label='$N_2^+$')
plt.plot(t*time_factor, Np*density_factor,  linestyle='--', linewidth=lINEWIDTH2, color='lime',      label='$N^+$')
#plt.plot(t*time_factor, O2p*density_factor, linestyle='--', linewidth=lINEWIDTH2, color='orangered', label='$O_2^+$')
#plt.plot(t*time_factor, Op*density_factor,  linestyle='--', linewidth=lINEWIDTH2, color='orange',    label='$O^+$')
#plt.plot(t*time_factor, O2m*density_factor, linestyle='-.', linewidth=lINEWIDTH2, color='purple',   label='$O_2^-$')
#plt.plot(t*time_factor, Om*density_factor,  linestyle='-.', linewidth=lINEWIDTH2, color='deeppink', label='$O^-$')
plt.plot(t*time_factor, e*density_factor,   linestyle='-.', linewidth=lINEWIDTH2, color='royalblue', label='$e$')

plt.xscale('log')
plt.xlim((t[1]*time_factor,t[-1]*time_factor))
plt.xticks(fontsize=12)
plt.xlabel('t [s]', fontsize=12)
#plt.xlabel('t [μs]', fontsize=12)

#plt.yscale('log')
#plt.ylim(((1e11,1e25)))
plt.yticks(fontsize=12)
plt.ylabel('n [m$^-$$^3$]', fontsize=12)

plt.legend(loc='best', ncol=3, framealpha=1.0)
plt.title(titlename)
plt.grid()
plt.tight_layout()
plt.savefig(filename+'.png',dpi=300)
#plt.savefig(filename+', log-scale.png',dpi=300)

plt.show()
'''