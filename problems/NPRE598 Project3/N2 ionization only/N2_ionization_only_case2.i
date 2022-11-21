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
    initial_condition = 1.00e7
  []

  [N2]
    family = SCALAR
    order = FIRST
    initial_condition = 1.00e24
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
    equation_values = '11605 300'
    equation_variables = 'a'
    sampling_variable = 'reduced_field'
    #rate_provider_var = 'reduced_field'
    
    reactions = '
                 
		 # 16
                 #e + O2 -> O + O+ + e + e     : EEDF (Op_ionization)
     		 
		 # 7 (R4)
                 #e + N2 -> N2+ + e + e        : EEDF (N2_ionization)
		 e + N2 -> e + e + N2+        : {1.00e-10*(1.5*T_e/11605)^(1.90)*exp(-14.6/(1.5*T_e/11605))}
		 
		 # 18 (R60)
     		 #e + O2 -> O- + O             : EEDF (Om_ionization)
		 #e + O2 -> O- + O             : 2.63e-10*(1.5*T_e/11605)^(-0.495)*exp(-5.65/(1.5*T_e/11605))
		 # 19 (R10)
     		 #e + O2 -> O2+ + e + e        : EEDF (O2p_ionization)
		 #e + O2 -> O2+ + e + e        : 9.54e-6*(1.5*T_e/11605)^(-1.05)*exp(-55.6/(1.5*T_e/11605))

                 # 1
                 #e + N+ + N2 -> N + N2        : {3.12e-23/(T_e^1.5)}
                 #e + N+ + N -> N + N          : {3.12e-23/(T_e^1.5)}
                 
                 # 2
                 #e + e + N+ -> N + e          : {1e-19*(T_g/T_e)^4.5}
                 # 3
                 #e + N -> N+ + 2e + e         : {1.45e-11*((1.5*T_e/11605)^(2.58))*exp(-8.54/(1.5*T_e/11605))}
                 # 4
                 #e + N2+ -> N + N             : {2.8e-7*((300/T_e)^0.5)}
                 # 5
                 #e + N2+ + N2 -> N2 + N2      : {3.12e-23/(T_e^1.5)}
                 #e + N2+ + N -> N2 + N        : {3.12e-23/(T_e^1.5)}
                 
		 # 52
		 #N + N2+ -> N+ + N2           : 1e-12 
'
  []
[]

[AuxVariables]
  [./reduced_field]
    order = FIRST
    family = SCALAR
    initial_condition = 1.0e-19
  [../]
  [./a]
    order = FIRST
    family = SCALAR
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
  end_time = 5e-3
  solve_type = linear
  dtmin = 1e-11
  dtmax = 1e-2
  line_search = none
  steady_state_detection = true
  [./TimeStepper]
    type = IterationAdaptiveDT
    cutback_factor = 0.9
    dt = 1e-11
    growth_factor = 1.05
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
