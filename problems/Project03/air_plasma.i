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
#    air-plasma.csv should be created in the folder.
# 



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
  [./e]
    family = SCALAR
    order = FIRST
    initial_condition = 0
  []

  [./N2+]
    family = SCALAR
    order = FIRST
    initial_condition = 0
  []

  [./N2]
    family = SCALAR
    order = FIRST
    initial_condition = 0.78
  []

  [./O2+]
    family = SCALAR
    order = FIRST
    initial_condition = 0
  []

  [./O2]
    family = SCALAR
    order = FIRST
    initial_condition = 0.22
  []

  [./O+]
    family = SCALAR
    order = FIRST
    initial_condition = 0
  []

  [./O]
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
  [dN2+_dt]
    type = ODETimeDerivative
    variable = N2+
  []
  [dN2_dt]
    type = ODETimeDerivative
    variable = N2
  []
  [dO2+_dt]
    type = ODETimeDerivative
    variable = O2+
  []
  [dO2_dt]
    type = ODETimeDerivative
    variable = O2
  []
  [dO+_dt]
    type = ODETimeDerivative
    variable = O+
  []
  [dO_dt]
    type = ODETimeDerivative
    variable = O
  []
[]

[GlobalReactions]
  [lieberman_reactions]
    species = 'e N2+ N2 O2+ O2 O+ O'
    reactions = ' -> B       : 5
                 B -> C       : 1'
  []
[]

[AuxVariables]
  [./reduced_field]
    order = FIRST
    family = SCALAR
    initial_condition = 7.7667949e-20
  [../]

  [./mobility]
    order = FIRST
    family = SCALAR
  [../]

  [./Te]
    order = FIRST
    family = SCALAR
  [../]

  [./current]
    order = FIRST
    family = SCALAR
  [../]
[]

[AuxScalarKernels]
  [reduced_field_calculate]
    type = ParsedAuxScalar
    variable = reduced_field
    constant_names = 'V d qe R'
    constant_expressions = '1000 0.004 1.602e-19 1e5'
    args = 'reduced_field Ar current'
    function = 'V/(d+R*current/(reduced_field*Ar*1e6))/(Ar*1e6)'
    execute_on = 'TIMESTEP_END'
  []

  [e_drift]
    type = ParsedAuxScalar
    variable = current
    constant_names = 'r pi'
    constant_expressions = '0.004 3.1415926'
    args = 'reduced_field mobility Ar e'
    function = '(reduced_field * mobility * Ar*1e6) * 1.6e-19 * pi*(r^2.0) * (e*1e6)'
    execute_on = 'TIMESTEP_BEGIN'
  []

  [mobility_calculation]
    type = ScalarLinearInterpolation
    variable = mobility
    sampler = reduced_field
    property_file = 'data/electron_mobility.txt'
    execute_on = 'INITIAL TIMESTEP_BEGIN'
  []

  [temperature_calculation]
    type = ScalarLinearInterpolation
    variable = Te
    sampler = reduced_field
    property_file = 'data/electron_temperature.txt'
    execute_on = 'INITIAL TIMESTEP_BEGIN'
  []
[]

[Debug]
  show_var_residual_norms = true
[]

#[UserObjects]
#  active = 'value_provider'
#
  #[./value_provider]
  #  type = ValueProvider
  #  property_file = 'data/electron_temperature.txt'
  #[../]
#[]

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
    dt = 1e-10
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
  [out_ka_1_kb_5]
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
