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
    initial_condition = 0.1
  []

  [N2]
    family = SCALAR
    order = FIRST
    initial_condition = 0.1
  []

  [O2]
    family = SCALAR
    order = FIRST
    initial_condition = 0.1
  []

  [N]
    family = SCALAR
    order = FIRST
    initial_condition = 0.1
  []

  [O]
    family = SCALAR
    order = FIRST
    initial_condition = 0.1
  []

  [N2+]
    family = SCALAR
    order = FIRST
    initial_condition = 0.1
  []

  [O2+]
    family = SCALAR
    order = FIRST
    initial_condition = 0.1
  []

  [N+]
    family = SCALAR
    order = FIRST
    initial_condition = 0.1
  []

  [O+]
    family = SCALAR
    order = FIRST
    initial_condition = 0.1
  []

  [O2-]
    family = SCALAR
    order = FIRST
    initial_condition = 0.1
  []

  [O-]
    family = SCALAR
    order = FIRST
    initial_condition = 0.1
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
[]

[GlobalReactions]
  [air_reactions]
    species = 'e N2 O2 N2+ O2+ N+ O+ O2- O-'
    file_location = 'data'

    equation_constants = 'T_e T_g'
    equation_values = '116050 300'
    sampling_variable = 'reduced_field'
    
    reactions = '
                 #7
                 e + N2 -> N2+ + e + e    : EEDF (N2_ionization)
                 #1
                 e + N+ + N2 -> N + N2    : 3.12e-23/(T_e^1.5)
                 e + N+ + N -> N + N      : 3.12e-23/(T_e^1.5)
                 e + N+ + O2 -> N + O2    : 3.12e-23/(T_e^1.5)
                 e + N+ + O -> N + O      : 3.12e-23/(T_e^1.5)
                 #2
                 e + e + N+ -> N + e      : 1e-19*(T_g/T_e)^4.5
                 #3
                 e + N -> N+ + 2e         : 1.45e-11*((1.5*T_e/11605)^(2.58))*exp(-8.54/(1.5*T_e/11605))
                 #4
                 e + N2+ -> 2N.           : 2.8e-7*((300/T_e)^0.5)
                 #5
                 e + N2+ + N2 -> N2 + N2  : 3.12e-23/(T_e^1.5)
                 e + N2+ + N -> N2 + N    : 3.12e-23/(T_e^1.5)
                 e + N2+ + O2 -> N2 + O2  : 3.12e-23/(T_e^1.5)
                 e + N2+ + O -> N2 + O    : 3.12e-23/(T_e^1.5)
                 #6                 
                 e + e + N2+ -> N2 + e    : 1e-19*(T_g/T_e)^4.5
                 
                 #8
                 e + O+ + N2 -> O + N2    : 3.12e-23/(T_e^1.5)
                 e + O+ + N -> O + N      : 3.12e-23/(T_e^1.5)
                 e + O+ + O2 -> O + O2    : 3.12e-23/(T_e^1.5)
                 e + O+ + O -> O + O      : 3.12e-23/(T_e^1.5)
                 #9
		 e + e + O+ -> O + e      : 1e-19*(T_g/T_e)^4.5
                 #10
                 e + O -> O+ + 2e         : 4.75e-11*((1.5*T_e/11605)^(0.61))*exp(-22.1/(1.5*T_e/11605))
                 #11
                 e + O + O2 -> O- + O2    : 1e-31
                 #12
		 e + O + O2 -> O + O2-    : 1e-31
                 #13
                 e + O2+ -> 2O            : 2e7*(300/T_e)
                 #14
                 e + e + O2+ -> O2 + e    : 1e-19*(T_g/T_e)^4.5
                 #15
                 e + O2+ + N2 -> O2 + N2  : 3.12e-23/(T_e^1.5)
                 e + O2+ + N -> O2 + N    : 3.12e-23/(T_e^1.5)
                 e + O2+ + O2 -> O2 + O2  : 3.12e-23/(T_e^1.5)
                 e + O2+ + O -> O2 + O    : 3.12e-23/(T_e^1.5)
                 #16
                 #e + O2 -> O + O+ + e + e : EEDF (O_ionization)
	         #17
                 e + O2 -> 2O + e         : 2.03e-11*((1.5*T_e/11605)^(-0.1))*exp(-8.47/(1.5*T_e/11605))
                 #18
                 #e + O2 -> O- + O         : EEDF (Om_ionization)
                 #19
                 #e + O2 -> O2+ + e + e    : EEDF (O2p_ionization)
                 #20
                 e + O2 + O2 -> O2- + O2  : 1.4e-29*(T_g/T_e)*exp(-600/T_g)*exp(700*(T_e - T_g)/(T_e*T_g))     
'
  []
[]

[AuxVariables]
  [reduced_field]
    order = FIRST
    family = SCALAR
    initial_condition = 1e-20
  []
[]

[Executioner]
  type = Transient
  start_time = 0
  end_time = 3
  dt = 0.1

  solve_type = linear

  # You can select different time integrators to see how they affect
  # the accuracy of the solution
  [TimeIntegrator]
    # This one is the default
    type = ImplicitEuler

    #type = LStableDirk2
    #type = BDF2
    #type = CrankNicolson
    #type = ImplicitMidpoint
  []
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