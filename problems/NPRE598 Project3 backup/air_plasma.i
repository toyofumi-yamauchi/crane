# Course: NPRE 598 Computational Plasma Physics
# Term: Fall 2022
# Author: Toyofumi Yamauchi
# 
# This is the input file for solving the air plasma.  
# 
# Procedure: 
# 1. Open the terminal at the folder where this file is saved.
#    Right-click the folder, click "New Terminal at Folder".
# 2. Type "mamba activate moose" to activate moose.
#    (base) will be changed to (moose).
# 3. Type "../../crane-opt -i air_plasma.i".
#    air_plasma_output.csv should be created in the folder.
# 4. Type "python3 air_plasma_plot.py".
#    Python plot should be generated. 


[Mesh]
  # 'Dummy' mesh - a mesh is always needed to run MOOSE, but
  # scalar variables do not exist on a mesh.
  # When you're doing a 0D problem you just need to give MOOSE 
  # a single element to work with.
  type = GeneratedMesh
  dim = 1
  xmin = 0
  xmax = 1
  nx = 1
[]

[Variables]
  # ODE variables
  # Global variables are called "SCALAR" in MOOSE.
  [e]
    family = SCALAR
    order = FIRST
    initial_condition = 1.00e5
  []

  [N2]
    family = SCALAR
    order = FIRST
    initial_condition = 1.00e19
  []

  [O2]
    family = SCALAR
    order = FIRST
    initial_condition = 0.0
  []

  [N]
    family = SCALAR
    order = FIRST
    initial_condition = 0.0
  []

  [O]
    family = SCALAR
    order = FIRST
    initial_condition = 0.0
  []

  [N2+]
    family = SCALAR
    order = FIRST
    initial_condition = 0.0
  []

  [O2+]
    family = SCALAR
    order = FIRST
    initial_condition = 0.0
  []

  [N+]
    family = SCALAR
    order = FIRST
    initial_condition = 0.0
  []

  [O+]
    family = SCALAR
    order = FIRST
    initial_condition = 0.0
  []

  [O2-]
    family = SCALAR
    order = FIRST
    initial_condition = 0.0
  []

  [O-]
    family = SCALAR
    order = FIRST
    initial_condition = 0.0
  []

  [NO]
    family = SCALAR
    order = FIRST
    initial_condition = 0.0
  []

  [NO+]
    family = SCALAR
    order = FIRST
    initial_condition = 0.0
  []

  [NO-]
    family = SCALAR
    order = FIRST
    initial_condition = 0.0
  []

  [NO2]
    family = SCALAR
    order = FIRST
    initial_condition = 0.0
  []

  [NO2+]
    family = SCALAR
    order = FIRST
    initial_condition = 0.0
  []

  [NO2-]
    family = SCALAR
    order = FIRST
    initial_condition = 0.0
  []

  [N2O]
    family = SCALAR
    order = FIRST
    initial_condition = 0.0
  []

  [N2O+]
    family = SCALAR
    order = FIRST
    initial_condition = 0.0
  []

  [N2O-]
    family = SCALAR
    order = FIRST
    initial_condition = 0.0
  []
[]

[ScalarKernels]
  # For global problems the only kernels needed are time derivatives.
  # All the source and sink terms are added by the GlobalReactions block.

  # Time derivatives:
  [de_dt]
    type = ODETimeDerivative
    variable = e
  []
  [dN2_dt]
    type = ODETimeDerivative
    variable = N2
  []
  [dO2_dt]
    type = ODETimeDerivative
    variable = O2
  []
  [dN_dt]
    type = ODETimeDerivative
    variable = N
  []
  [dO_dt]
    type = ODETimeDerivative
    variable = O
  []
  [dN2+_dt]
    type = ODETimeDerivative
    variable = N2+
  []
  [dO2+_dt]
    type = ODETimeDerivative
    variable = O2+
  []
  [dN+_dt]
    type = ODETimeDerivative
    variable = N+
  []
  [dO+_dt]
    type = ODETimeDerivative
    variable = O+
  []
  [dO2-_dt]
    type = ODETimeDerivative
    variable = O2-
  []
  [dO-_dt]
    type = ODETimeDerivative
    variable = O-
  []
  [dNO_dt]
    type = ODETimeDerivative
    variable = NO
  []
  [dNO+_dt]
    type = ODETimeDerivative
    variable = NO+
  []
  [dNO-_dt]
    type = ODETimeDerivative
    variable = NO-
  []
  [dNO2_dt]
    type = ODETimeDerivative
    variable = NO2
  []
  [dNO2+_dt]
    type = ODETimeDerivative
    variable = NO2+
  []
  [dNO2-_dt]
    type = ODETimeDerivative
    variable = NO2-
  []
  [dN2O_dt]
    type = ODETimeDerivative
    variable = N2O
  []
  [dN2O+_dt]
    type = ODETimeDerivative
    variable = N2O+
  []
  [dN2O-_dt]
    type = ODETimeDerivative
    variable = N2O-
  []
[]

[GlobalReactions]
  [air_reactions]
    species = 'e N2 O2 N O N2+ O2+ N+ O+ O2- O- NO NO+ NO- NO2 NO2+ NO2- N2O N2O+ N2O-'
    file_location = 'data'

    equation_constants = 'T_e T_g'
    equation_values = '464200 300'
    sampling_variable = 'reduced_field'
    #rate_provider_var = 'reduced_field'
    
    reactions = '
                 
		 # 16
                 #e + O2 -> O + O+ + e + e      : EEDF (O2_ionization)
     		 # 7 (R4)
                 #e + N2 -> N2+ + e + e         : EEDF (N2_ionization)
		 e + N2 -> N2+ + e + e         : 1.00e-6*(1.5*T_e/11605)^(1.90)*exp(-14.6/(1.5*T_e/11605))
     		 # 18 (R60)
     		 #e + O2 -> O- + O              : EEDF (Om_ionization)
		 e + O2 -> O- + O              : 2.63e-10*(1.5*T_e/11605)^(-0.495)*exp(-5.65/(1.5*T_e/11605))
		 # 19 (R10)
     		 #e + O2 -> O2+ + e + e         : EEDF (O2p_ionization)
		 e + O2 -> O2+ + e + e         : 9.54e-6*(1.5*T_e/11605)^(-1.05)*exp(-55.6/(1.5*T_e/11605))

                 # 1
                 e + N+ + N2 -> N + N2        : 3.12e-23/(T_e^1.5)
                 e + N+ + N -> N + N          : 3.12e-23/(T_e^1.5)
                 e + N+ + O2 -> N + O2        : 3.12e-23/(T_e^1.5)
                 e + N+ + O -> N + O          : 3.12e-23/(T_e^1.5)
                 # 2
                 e + e + N+ -> N + e          : 1e-19*(T_g/T_e)^4.5
                 # 3
                 e + N -> N+ + e + e          : 1.45e-11*((1.5*T_e/11605)^(2.58))*exp(-8.54/(1.5*T_e/11605))
                 # 4
                 e + N2+ -> N + N             : 2.8e-7*((300/T_e)^0.5)
                 # 5
                 e + N2+ + N2 -> N2 + N2      : 3.12e-23/(T_e^1.5)
                 e + N2+ + N -> N2 + N        : 3.12e-23/(T_e^1.5)
                 e + N2+ + O2 -> N2 + O2      : 3.12e-23/(T_e^1.5)
                 e + N2+ + O -> N2 + O        : 3.12e-23/(T_e^1.5)
                 # 6                 
                 e + e + N2+ -> N2 + e        : 1e-19*(T_g/T_e)^4.5	
                 # 8
                 e + O+ + N2 -> O + N2        : 3.12e-23/(T_e^1.5)
                 e + O+ + N -> O + N          : 3.12e-23/(T_e^1.5)
                 e + O+ + O2 -> O + O2        : 3.12e-23/(T_e^1.5)
                 e + O+ + O -> O + O          : 3.12e-23/(T_e^1.5)
                 # 9
		 e + e + O+ -> O + e          : 1e-19*(T_g/T_e)^4.5
                 # 10
                 e + O -> O+ + e + e          : 4.75e-9*((1.5*T_e/11605)^(0.61))*exp(-22.1/(1.5*T_e/11605))
                 # 11    
                 e + O + O2 -> O- + O2        : 1e-31
                 # 12
		 e + O + O2 -> O + O2-        : 1e-31
                 # 13
                 e + O2+ -> O + O             : 2e-7*(300/T_e)
                 # 14
                 e + e + O2+ -> O2 + e        : 1e-19*(T_g/T_e)^4.5
                 # 15
                 e + O2+ + N2 -> O2 + N2      : 3.12e-23/(T_e^1.5)
                 e + O2+ + N -> O2 + N        : 3.12e-23/(T_e^1.5)
                 e + O2+ + O2 -> O2 + O2      : 3.12e-23/(T_e^1.5)
                 e + O2+ + O -> O2 + O        : 3.12e-23/(T_e^1.5)
	   	 # 17
     		 e + O2 -> O + O + e          : 2.03e-8*((1.5*T_e/11605)^(-0.1))*exp(-8.47/(1.5*T_e/11605))
		 # 20
    		 e + O2 + O2 -> O2- + O2      : 1.4e-29*(T_g/T_e)*exp(-600/T_g)*exp(700*(T_e - T_g)/(T_e*T_g))

		 # 21
    		 e + O2 + N2 -> O2- + N2      : 1.4e-31*(T_g/T_e)^2*exp(-70/T_g)*exp(1500*(T_e - T_g)/(T_e*T_g))
     	         # 22
    		 e + NO+ -> N + O             : 1.07e-5/T_e^0.85
     		 # 23
    		 e + NO+ + N2 -> NO + N2      : 3.12e-23/(T_e^1.5)
    		 e + NO+ + N -> NO + N        : 3.12e-23/(T_e^1.5)
    		 e + NO+ + O2 -> NO + O2      : 3.12e-23/(T_e^1.5)
    		 e + NO+ + O -> NO + O        : 3.12e-23/(T_e^1.5)
    		 # 24
   		 e + e + NO+ -> NO + e        : 1e-19*(T_g/T_e)^4.5
    		 # 25
    		 e + NO + N2 -> NO- + N2      : 8e-31
    		 e + NO + N -> NO- + N        : 8e-31
    		 e + NO + O2 -> NO- + O2      : 8e-31
    		 e + NO + O -> NO- + O        : 8e-31
    		 # 26
		 e + NO2+ -> NO + O           : 3.46e-6/T_e^0.5
		 # 27
    		 e + NO2 + N2 -> NO2- + N2    : 1.5e-30
    		 e + NO2 + N -> NO2- + N      : 1.5e-30
     	 	 e + NO2 + O2 -> NO2- + O2    : 1.5e-30
    		 e + NO2 + O -> NO2- + O      : 1.5e-30
     		 # 28
		 e + NO2 -> O- + NO           : 1e-11
		 # 29
		 e + N2O+ -> N2 + O           : 3.46e-6/T_e^0.5
                 # 30
		 e + N2O -> O- + N2           : 2e-10
		 # 31
		 N+ + O -> O+ + N             : 1e-12
		 # 32
     		 N+ + O + N2 -> NO+ + N2      : 1e-29
    		 N+ + O + N -> NO+ + N        : 1e-29
    		 N+ + O + O2 -> NO+ + O2      : 1e-29
    		 N+ + O + O -> NO+ + O        : 1e-29
		 # 33
		 N+ + O- -> O + N             : 2e-7*(300/T_g)^0.5
    		 # 34
    		 N+ + N + N2 -> N2+ + N2      : 1e-29
    		 N+ + N + N -> N2+ + N        : 1e-29
   		 N+ + N + O2 -> N2+ + O2      : 1e-29
    		 N+ + N + O -> N2+ + O        : 1e-29
		 # 35
		 N+ + NO -> NO+ + N           : 4.72e-10
		 # 36
		 N+ + NO -> N2+ + O           : 8.33e-11
		 # 37
	 	 N+ + NO -> O+ + N2           : 1e-12
		 # 38
		 N+ + NO- -> NO + N           : 2e-7*(300/T_g)^0.5
		 # 39
	   	 N+ + O2 -> NO+ + O           : 2.70e-10
		 # 40
		 N+ + O2 -> O+ + NO           : 2.80e-11
		 # 41
		 N+ + O2 -> O2+ + N           : 3.00e-10
		 # 42
		 N+ + O2- -> O2 + N           : 2e-7*(300/T_g)^0.5
		 # 43
		 N+ + N2O -> NO+ + N2         : 5.50e-10
		 # 44
		 N+ + N2O- -> N2O + N         : 2e-7*(300/T_g)^0.5
		 # 45
		 N+ + NO2 -> NO2+ + N         : 3.00e-10
		 # 46
		 N+ + NO2 -> NO+ + NO         : 5.00e-10
		 # 47
		 N+ + NO2- -> NO2 + N         : 2e-7*(300/T_g)^0.5
		 # 48
     		 N + O+ + N2 -> NO+ + N2      : 1e-29
     		 N + O+ + N -> NO+ + N        : 1e-29
     		 N + O+ + O2 -> NO+ + O2      : 1e-29
     		 N + O+ + O -> NO+ + O        : 1e-29
		 # 49
     		 N + O + N2 -> NO + N2        : 6.3e-33*exp(140/T_g)
     		 N + O + N -> NO + N          : 6.3e-33*exp(140/T_g)
     		 N + O + O2 -> NO + O2        : 6.3e-33*exp(140/T_g)
     		 N + O + O -> NO + O          : 6.3e-33*exp(140/T_g)
		 # 50
		 N + O- -> NO + e             : 2.6e-10
		 # 51 
		 N + N + N2 -> N2 + N2        : 8.3e-34*exp(500/T_g)
     		 N + N + N -> N2 + N          : 8.3e-34*exp(500/T_g)
     		 N + N + O2 -> N2 + O2        : 8.3e-34*exp(500/T_g)
     		 N + N + O -> N2 + O          : 8.3e-34*exp(500/T_g)
		 # 52
		 N + N2+ -> N+ + N2           : 1e-12
		 # 53
		 N + NO+ + N2 -> N2O+ + N2    : 1e-29*300/T_g
     		 N + NO+ + N -> N2O+ + N      : 1e-29*300/T_g
     		 N + NO+ + O2 -> N2O+ + O2    : 1e-29*300/T_g
     		 N + NO+ + O -> N2O+ + O      : 1e-29*300/T_g
		 # 54
		 N + NO -> N2 + O             : 2.1e-11*exp(100/T_g)
		 # 55
		 N + O2+ -> NO+ + O           : 1.5e-10
		 # 56
		 N + O2 -> NO + O             : 1.5e-11*exp(-3600/T_g)
		 # 57
		 N + O2- -> NO2 + e           : 5e-10
		 # 58
		 N + NO2 -> N2O + O           : 5.8e-12*exp(220/T_g)
		 # 59
		 N + NO2 -> N2 + O + O        : 9.1e-13
		 # 60
		 N + NO2 -> NO + NO           : 6e-13
		 # 61
	 	 N + NO2 -> N2 + O2           : 7e-13
		 # 62
		 N + NO2- -> N2 + O2 + e      : 1e-12
		 # 63
     		 O + O+ + N2 -> O2+ + N2      : 1e-29
     		 O + O+ + N -> O2+ + N        : 1e-29
     		 O + O+ + O2 -> O2+ + O2      : 1e-29
     		 O + O+ + O -> O2+ + O        : 1e-29
		 # 64
		 O+ + O- -> O + O             : 2e-7*(300/T_g)^0.5
		 # 65 
	 	 O+ + NO -> NO+ + O           : 1e-12
		 # 66
		 O+ + NO -> O2+ + N           : 3e-12
		 # 67
		 N2 + O+ + N2 -> NO+ + N + N2 : 6e-29*(300/T_g)^2
     		 N2 + O+ + N -> NO+ + N + N   : 6e-29*(300/T_g)^2
     		 N2 + O+ + O2 -> NO+ + N + O2 : 6e-29*(300/T_g)^2
     		 N2 + O+ + O -> NO+ + N + O   : 6e-29*(300/T_g)^2
		 # 68
		 O+ + NO- -> NO + O           : 2e-7*(300/T_g)^0.5
		 
		 # 69
		 O+ + O2 -> O2+ + O           : 2.1e-11*(300/T_g)^0.5
		 # 70
		 O+ + O2- -> O2 + O           : 2e-7*(300/T_g)^0.5
		 # 71
		 O+ + N2O -> N2O+ + O         : 6.3e-10
		 # 72 
		 O+ + N2O -> NO+ + NO         : 2.3e-10
		 # 73
		 O+ + N2O -> O2+ + N2         : 2e-11
		 # 74
		 O+ + N2O- -> N2O + O         : 2e-7*(300/T_g)^0.5
		 # 75
		 O+ + NO2 -> NO+ + O2         : 5e-10
		 # 76
		 O+ + NO2 -> NO2+ + O         : 1.6e-9
		 # 77
	         O+ + NO2- -> NO2 + O         : 2e-7*(300/T_g)^0.5
		 # 78
		 O + O- -> O2 + e             : 1.4e-10
		 # 79
	         O + N2+ -> O+ + N2           : 1e-11*(300/T_g)^0.5
		 # 80
		 O + N2+ -> NO+ + N           : 1.4e-10
		 # 81
		 O + NO + N2 -> NO2 + N2      : 1e-31*(300/T_g)^0.5
     		 O + NO + N -> NO2 + N        : 1e-31*(300/T_g)^0.5
     		 O + NO + O2 -> NO2 + O2      : 1e-31*(300/T_g)^0.5
     		 O + NO + O -> NO2 + O        : 1e-31*(300/T_g)^0.5
		 # 82
		 O + NO- -> O- + NO           : 3e-10
		 # 83
		 O + O2- -> O- + O2           : 3.3e-10
		 # 84
		 O + O + N2 -> O2 + N2        : 3.2e-35*exp(900/T_g)
     		 O + O + N -> O2 + N          : 3.2e-35*exp(900/T_g)
     		 O + O + O2 -> O2 + O2        : 3.2e-35*exp(900/T_g)
     		 O + O + O -> O2 + O          : 3.2e-35*exp(900/T_g)
		 # 85
		 O + NO2 -> NO + O2           : 6.5e-12*exp(120/T_g)
		 # 86
		 O- + NO -> N2O + e           : 1e-12
		 # 87
	 	 O- + NO -> NO2 + e           : 2.6e-10
		 # 88
		 O- + NO + N2 -> NO2- + N2    : 1e-29
     		 O- + NO + N -> NO2- + N      : 1e-29
     		 O- + NO + O2 -> NO2- + O2    : 1e-29
     		 O- + NO + O -> NO2- + O      : 1e-29
		 # 89
		 O- + N2+ -> O + N2           : 2e-7*(300/T_g)^0.5
		 # 90
		 O- + N2+ -> O + N + N        : 1e-7
		 # 91
		 O- + NO+ -> O + O + N        : 1e-7
		 # 92
		 O- + NO+ -> O + NO           : 2e-7*(300/T_g)^0.5
		 # 93
	 	 O- + O2+ -> O + O + O        : 1e-7
		 # 94
		 O- + O2+ -> O + O2           : 2e-7*(300/T_g)^0.5
		 # 95
		 O- + N2O+ -> O + N2O         : 2e-7*(300/T_g)^0.5
		 # 96
		 O- + N2O+ -> O + O + N2      : 1e-7
		 # 97
		 O- + N2O -> NO- + NO         : 2e-10
		 # 98
		 O- + N2O -> N2O- + O         : 2e-10
		 # 99
		 O- + NO2+ -> O + NO2         : 2e-10*(300/T_g)^0.5
		 # 100
		 O- + NO2+ -> O + N + O2      : 1e-7
		 # 101
		 O- + NO2 -> NO2- + O         : 1.2e-9
		 # 102 
		 N2+ + NO -> NO+ + N2         : 3.9e-10
		 # 103
		 N2+ + NO- -> NO + N2         : 2e-7*(300/T_g)^0.5
		 # 104
		 N2+ + NO- -> NO + N + N      : 1e-7
		 # 105
		 N2+ + O2 -> O2+ + N2         : 5e-11
		 # 106
	 	 N2+ + O2- -> O2 + N2         : 2e-7*(300/T_g)^0.5
		 # 107
		 N2+ + O2- => O2 + N + N      : 1e-7
		 # 108
		 N2+ + N2O -> NO+ + N + N2    : 6e-10
		 # 109
		 N2+ + N2O -> NO+ + N + N2    : 4e-10
		 # 110
		 N2+ + N2O- -> N2O + N2       : 2e-7*(300/T_g)^0.5
		 # 111
		 N2+ + N2O- -> N2O + N + N    : 1e-7
		 # 112
		 N2+ + NO2 -> NO+ + N2O       : 5e-11
		 # 113
		 N2+ + NO2 -> NO2+ + N2       : 3e-10
		 # 114
		 N2+ + NO2- -> NO2 + N2       : 2e-7*(300/T_g)^0.5
		 # 115
		 N2+ + NO2- -> NO2 + N + N    : 1e-7
		 # 116
		 N2 + O2+ -> NO+ + NO         : 1e-17
		 # 117
		 N2 + O2- -> N2 + O2 + e      : 1.9e-12*(T_g/300)^0.5*exp(-4990/T_g)

		 # 118
		 NO+ + NO- -> NO + NO         : 2e-7*(300/T_g)^0.5
		 # 119
		 NO+ + NO- -> NO + N +  O     : 1e-7
		 # 120
		 NO+ + O2- -> O2 + N + O      : 1e-7
		 # 121
		 NO+ + O2- -> O2 + NO         : 2e-7*(300/T_g)^0.5
		 # 122
		 NO+ + N2O- ->  N2O + NO      : 2e-7*(300/T_g)^0.5
		 # 123
		 NO+ + N2O- -> N2O + N + O    : 1e-7
		 # 124
		 NO+ + NO2- -> NO2 + NO       : 2e-7*(300/T_g)^0.5
		 # 125
		 NO+ + NO2- -> NO2 + N + O    : 1e-7
		 # 126
		 NO + NO- -> NO + NO + e      : 5e-12
		 # 127
		 NO + O2+ -> NO2 + N + O      : 4.6e-10
		 # 128
		 NO + N2O+ -> NO+ N2O         : 2.3e-10
		 # 129
		 NO + NO2+ -> NO+ + NO2       : 2.75e-10
		 # 130
		 NO + NO2- -> NO- + NO2       : 2.75e-10
		 # 131
		 NO- + N2 -> NO + N2 + e      : 2.4e-13
     		 NO- + N -> NO + N + e        : 2.4e-13
     		 NO- + O2 -> NO + O2 + e      : 2.4e-13
     		 NO- + O -> NO + O + e        : 2.4e-13
		 # 132 
		 NO- + O2+ -> NO + O2         : 2e-7*(300/T_g)^0.5
		 # 133
		 NO- + O2+ -> NO + O + O      : 1e-7
		 # 134
		 NO- + O2 -> O2- + NO         : 5e-10
		 # 135
		 NO- + NO2+ -> NO + NO2       : 2e-7*(300/T_g)^0.5
		 # 137
		 NO- + N2O+ -> NO + N2O       : 2e-7*(300/T_g)^0.5
		 # 138
		 NO- + N2O+ -> NO + N2 + O    : 1e-7
		 # 139
		 NO- + N2O -> NO + N2O + e    : 5.1e-12
		 # 140
		 NO- + N2O -> NO2- + N2       : 2.8e-14
		 # 141
		 NO- + NO2 -> NO2- + NO       : 3e-10
		 # 142
	         O2+ + O2- -> O2 + O2         : 2e-7*(300/T_g)^0.5
		 # 143
		 O2+ + O2- -> O2 + O + O      : 1e-7
		 # 144
		 O2+ + N2O- -> N2O + O2       : 2e-7*(300/T_g)^0.5
		 # 145
		 O2+ + N2O- -> N2O + O + O    : 1e-7
		 # 146
		 O2+ + NO2 -> NO2+ + O2       : 6.6e-10
		 # 147
		 O2+ + NO2- -> NO2 + O2       : 2e-7*(300/T_g)^0.5
		 # 148
		 O2+ + NO2- -> NO2 + O + O    : 1e-7
		 # 149
		 O2 + O2- -> O2 + O2 + e      : 2.7e-10*(T_g/300)^0.5*exp(-5590/T_g)
		 # 150
		 O2 + N2O+ -> NO+ + NO2       : 4.59e-11
		 # 151
		 O2 + N2O+ -> O2+ + N2O       : 2.24e-10
		 # 152
		 O2- + N2O+ -> O2 + N2O       : 2e-7*(300/T_g)^0.5
		 # 153
	         O2- + N2O+ -> O2 + N2 + O    : 1e-7
		 # 154
		 O2- + NO2+ -> O2 + NO2       : 2e-7*(300/T_g)^0.5
		 # 155
		 O2- + NO2+ -> O2 + N + O2    : 1e-7
		 # 156
		 O2- + NO2 -> NO2- + O2       : 7e-10
		 # 157
		 N2O+ + N2O -> NO+ + NO + N2  : 1.2e-11
		 # 158
		 N2O+ + N2O- -> N2O + N2O     : 2e-7*(300/T_g)^0.5
		 # 159
		 N2O+ + N2O- -> N2O + N2 + O  : 1e-17
		 # 160
		 N2O+ + NO2 -> NO+ + N2 + O2  : 4.29e-10
		 # 161
		 N2O+ + NO2 -> NO2+ + N2O     : 2.21e-10
		 # 162
		 N2O+ + NO2- -> NO2 + N2O     : 2e-7*(300/T_g)^0.5
		 # 163
		 N2O+ + NO2- -> NO2 + N2 + O  : 1e-7
		 
		 # 164
		 N2O- + NO2+ -> N2O + NO2     : 2e-7*(300/T_g)^0.5
		 # 165
		 N2O- + NO2+ -> N2O + N + O2  : 1e-7
		 # 166
		 NO2+ + NO2- -> NO2 + NO2     : 2e-7*(300/T_g)^0.5
		 # 167
		 NO2+ + NO2- -> NO2 + N + O2  : 1e-7
'
  []
[]

[AuxVariables]
  [./reduced_field]
    order = FIRST
    family = SCALAR
    initial_condition = 1.0e-19
  [../]
[]

[AuxScalarKernels]
  [reduced_field_calculate]
    type = ParsedAuxScalar
    variable = reduced_field
    constant_names = 'V d qe R current'
    constant_expressions = '1000 0.004 1.602e-19 1e5 100'
    args = 'reduced_field N2'
    function = 'V/(d+R*current/(reduced_field*N2*1e6))/(N2*1e6)'
    execute_on = 'TIMESTEP_END'
  []
[]

[Executioner]
  type = Transient
  end_time = 1e-3
  solve_type = linear
  dtmin = 1e-16
  dtmax = 1e-6
  line_search = none
  steady_state_detection = true
  [./TimeStepper]
    type = IterationAdaptiveDT
    cutback_factor = 0.9
    dt = 1e-9
    growth_factor = 1.01
  [../]
  #[TimeIntegrator]
  #  type = LStableDirk2
  #[]
[]

[Preconditioning]
  [./smp]
    type = SMP
    full = true
  [../]
[]

[Outputs]
  [output]
    type = CSV
  []
  # This next one is optional, but highly recommended.
  # Without this, scalar variables are printed on the terminal as the 
  # simulation runs. 
  # It's best to keep this on to prevent things from being cluttered.
  [console]
    type = Console
    execute_scalars_on = 'none'
  []
[]