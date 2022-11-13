# Course: NPRE 598 Computational Plasma Physics
# Term: Fall 2022
# Author: Toyofumi Yamauchi
# 
# This is the input file for solving the air plasma.  
# 
# Procedure: 
# 1. Open the terminal at the folder where this file is saved
#    Right-click the folder, click "New Terminal at Folder"
# 2. Type "mamba activate moose" to activate moose
#    (base) will be changed to (moose)
# 3. Type "../../crane-opt -i air_plasma.i"
#    air_plasma_output.csv should be created in the folder.

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
    initial_condition = 0.5
  []

  [N2]
    family = SCALAR
    order = FIRST
    initial_condition = 0.25
  []

  [O2]
    family = SCALAR
    order = FIRST
    initial_condition = 0.25
  []

  [N]
    family = SCALAR
    order = FIRST
    initial_condition = 0
  []

  [O]
    family = SCALAR
    order = FIRST
    initial_condition = 0
  []

  [N2+]
    family = SCALAR
    order = FIRST
    initial_condition = 0
  []

  [O2+]
    family = SCALAR
    order = FIRST
    initial_condition = 0
  []

  [N+]
    family = SCALAR
    order = FIRST
    initial_condition = 0
  []

  [O+]
    family = SCALAR
    order = FIRST
    initial_condition = 0
  []

  [O2-]
    family = SCALAR
    order = FIRST
    initial_condition = 0
  []

  [O-]
    family = SCALAR
    order = FIRST
    initial_condition = 0
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
    #file_location = 'data'

    equation_constants = 'Te'
    equation_values = '11605'

    reactions = 'e + N+ + N2 -> N + N2 : 3.12e-23/(T_e^(1.5))
                 e + N+ + N -> N + N   : 3.12e-23/(T_e^(1.5))
                 e + N+ + O2 -> N + O2 : 3.12e-23/(T_e^(1.5))
                 e + N+ + O -> N + O   : 3.12e-23/(T_e^(1.5))'
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