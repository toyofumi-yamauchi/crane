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
# 3. Type "../../../crane-opt -i O2_only_case3.i".
#    O2_only_case3.csv should be created in the folder.
# 4. Type "python3 O2_plasma_plot.py" or "python3 O2_ionization_plot_multiple.py".
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
    initial_condition = 1.00e6
  []

  [N2]
    family = SCALAR
    order = FIRST
    initial_condition = 0.0
  []

  [O2]
    family = SCALAR
    order = FIRST
    initial_condition = 1.00e13
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
    equation_values = '174075 300'
    equation_variables = 'a'
    sampling_variable = 'T_e_eV'
    
    reactions = '
                 
		 # 7 (R4)
                 #e + N2 -> e + e + N2+        : {1.00e-10*(1.5*T_e/11605)^(1.90)*exp(-14.6/(1.5*T_e/11605))}
		 # 16
                 e + O2 -> O + O+ + e + e     : EEDF (Op_ionization_Te)
     		 # 18 (R60)
     		 e + O2 -> O- + O             : {2.63e-10*(1.5*T_e/11605)^(-0.495)*exp(-5.65/(1.5*T_e/11605))}
		 # 19 (R10)
     		 e + O2 -> O2+ + e + e        : {9.54e-6*(1.5*T_e/11605)^(-1.05)*exp(-55.6/(1.5*T_e/11605))}

                 # 8
                 e + O+ + O2 -> O + O2        : {3.12e-23/(T_e^1.5)}
                 e + O+ + O -> O + O          : {3.12e-23/(T_e^1.5)}
		 # 9
		 e + e + O+ -> O + e          : {1e-19*(T_g/T_e)^4.5}
                 # 10
                 e + O -> O+ + e + e          : {4.75e-9*((1.5*T_e/11605)^(0.61))*exp(-22.1/(1.5*T_e/11605))}
                 # 11    
                 e + O + O2 -> O- + O2        : 1e-31
                 # 12
		 e + O + O2 -> O + O2-        : 1e-31
                 # 13
                 e + O2+ -> O + O             : {2e-7*(300/T_e)}
                 # 14
                 e + e + O2+ -> O2 + e        : {1e-19*(T_g/T_e)^4.5}
                 # 15
                 e + O2+ + O2 -> O2 + O2      : {3.12e-23/(T_e^1.5)}
                 e + O2+ + O -> O2 + O        : {3.12e-23/(T_e^1.5)}
	   	 # 17
     		 e + O2 -> O + O + e          : {2.03e-8*((1.5*T_e/11605)^(-0.1))*exp(-8.47/(1.5*T_e/11605))}
		 # 20
    		 e + O2 + O2 -> O2- + O2      : {1.4e-29*(T_g/T_e)*exp(-600/T_g)*exp(700*(T_e - T_g)/(T_e*T_g))}
		 # 63
     		 O + O+ + O2 -> O2+ + O2      : 1e-29
     		 O + O+ + O -> O2+ + O        : 1e-29
		 # 64
		 O+ + O- -> O + O             : {2e-7*(300/T_g)^0.5}
		 # 69
		 O+ + O2 -> O2+ + O           : {2.1e-11*(300/T_g)^0.5}
		 # 70
		 O+ + O2- -> O2 + O           : {2e-7*(300/T_g)^0.5}
		 # 78
		 O + O- -> O2 + e             : 1.4e-10
		 # 83
		 O + O2- -> O- + O2           : 3.3e-10
		 # 93
	 	 O- + O2+ -> O + O + O        : 1e-7
		 # 94
		 O- + O2+ -> O + O2           : {2e-7*(300/T_g)^0.5}
		 # 142
	         O2+ + O2- -> O2 + O2         : {2e-7*(300/T_g)^0.5}
		 # 143
		 O2+ + O2- -> O2 + O + O      : 1e-7
		 # 149
		 O2 + O2- -> O2 + O2 + e      : {2.7e-10*(T_g/300)^0.5*exp(-5590/T_g)}

'
  []
[]

[AuxVariables]
  [./T_e_eV]
    order = FIRST
    family = SCALAR
    initial_condition = 15.0
  [../]
  [./a]
    order = FIRST
    family = SCALAR
  [../]
[]

[AuxScalarKernels]
  [T_e_eV_calculate]
    type = ParsedAuxScalar
    variable = T_e_eV
    constant_names = 'x'
    constant_expressions = '15.0'
    args = 'a'
    function = 'x'
    execute_on = 'TIMESTEP_END'
  []
[]

[Executioner]
  type = Transient
  end_time = 1e-1
  solve_type = linear
  dtmin = 1e-6
  dtmax = 1e-2
  line_search = none
  steady_state_detection = true
  [./TimeStepper]
    type = IterationAdaptiveDT
    cutback_factor = 0.9
    dt = 1e-6
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
