[Mesh]
  type = GeneratedMesh
  dim = 1
  nx = 1
[]

[Variables]
  [./N]
    family = SCALAR
    order = FIRST
    initial_condition = 0.0
    #scaling = 1e-5
  [../]

  [./N2]
    family = SCALAR
    order = FIRST
    initial_condition = 2.4474637681159418e+19
    #scaling = 1e-10
  [../]

  [./N2A]
    family = SCALAR
    order = FIRST
    initial_condition = 0.0
    #scaling = 1e-8
  [../]

  [./N2B]
    family = SCALAR
    order = FIRST
    initial_condition = 0.0
    #scaling = 1e-5
  [../]

  [./N2a1]
    family = SCALAR
    order = FIRST
    initial_condition = 0.0
  [../]

  [./N2C]
    family = SCALAR
    order = FIRST
    initial_condition = 0.0
    #scaling = 1e-5
  [../]

  [./N+]
    family = SCALAR
    order = FIRST
    initial_condition = 0.0
    #scaling = 1e-5
  [../]

  [./N2+]
    family = SCALAR
    order = FIRST
    initial_condition = 0.0
    #scaling = 1e-5
  [../]

  [./N3+]
    family = SCALAR
    order = FIRST
    initial_condition = 0.0
    #scaling = 1e-5
  [../]

  [./N4+]
    family = SCALAR
    order = FIRST
    initial_condition = 0.0
    #scaling = 1e-5
  [../]
[]

[ScalarKernels]
  [./dN_dt]
    type = ODETimeDerivative
    variable = N
  [../]

  [./dN2_dt]
    type = ODETimeDerivative
    variable = N2
  [../]

  [./dN2A_dt]
    type = ODETimeDerivative
    variable = N2A
  [../]

  [./dN2B_dt]
    type = ODETimeDerivative
    variable = N2B
  [../]

  [./dN2a_dt]
    type = ODETimeDerivative
    variable = N2a1
  [../]

  [./dN2C_dt]
    type = ODETimeDerivative
    variable = N2C
  [../]

  [./dN+_dt]
    type = ODETimeDerivative
    variable = N+
  [../]

  [./dN2+_dt]
    type = ODETimeDerivative
    variable = N2+
  [../]

  [./dN3+_dt]
    type = ODETimeDerivative
    variable = N3+
  [../]

  [./dN4+_dt]
    type = ODETimeDerivative
    variable = N4+
  [../]
[]

[GlobalReactions]
  [nitrogen]
    species = 'N N2 N2A N2B N2a1 N2C N+ N2+ N3+ N4+'
    file_location = 'data'

    # These are parameters required equation-based rate coefficients
    equation_variables = 'Te Teff'
    rate_provider_var = 'reduced_field'


    reactions = 'e + N2 -> e + N2A          : EEDF (N2A_excitation)
                 e + N2 -> e + N2B          : EEDF (N2B_excitation)
                 e + N2 -> e + N2a1         : EEDF (N2a1_excitation)
                 e + N2 -> e + N2C          : EEDF (N2C_excitation)
                 e + N2 -> e + e + N2+      : EEDF (N2_ionization)
                 N2A + N2a1 -> N4+ + e      : 4.0e-12
                 N2a1 + N2a1 -> N4+ + e     : 4.0e-11
                 N+ + e + N2 -> N + N2      : {6.0e-27*(300/(Te*11600))^1.5}
                 N2+ + e -> N + N           : {1.8e-7*(300/(Te*11600))^0.39}
                 N3+ + e -> N2 + N          : {2.0e-7*(300/(Te*11600))^0.5}
                 N4+ + e -> N2 + N2         : {2.3e-6*(300/(Te*11600))^0.53}
                 N+ + N + N2 -> N2+ + N2    : 1.0e-29
                 N+ + N2 + N2 -> N3+ + N2   : {1.7e-29*(300.0/Teff)^2.1}
                 N2+ + N -> N+ + N2         : {7.2e-13*(Teff/300.0)}
                 N2+ + N2A -> N3+ + N       : 3.0e-10
                 N2+ + N2 + N -> N3+ + N2   : {9.0e-30*exp(400.0/Teff)}
                 N2+ + N2 + N2 -> N4+ + N2  : {5.2e-29*(300.0/Teff)^2.2}
                 N3+ + N -> N2+ + N2        : 6.6e-11
                 N4+ + N -> N+ + N2 + N2    : 1.0e-11
                 N4+ + N2 -> N2+ + N2 + N2  : {2.1e-16*exp(Teff/121.0)}
                 N2A -> N2                  : 5.0e-1
                 N2B -> N2A                 : 1.3e5
                 N2a1 -> N2                 : 1.0e2
                 N2C -> N2B                 : 2.5e7
                 N2A + N -> N2 + N          : 2.0e-12
                 N2A + N2 -> N2 + N2        : 3.0e-16
                 N2A + N2A -> N2 + N2B      : 3.0e-10
                 N2A + N2A -> N2 + N2C      : 1.5e-10
                 N2B + N2 -> N2 + N2        : 2.0e-12
                 N2B + N2 -> N2A + N2       : 3.0e-11
                 N2a1 + N2 -> N2 + N2B      : 1.9e-13
                 N2C + N2 -> N2 + N2a1      : 1.0e-11
                 N + N + N2 -> N2A + N2     : 1.7e-33
                 N + N + N2 -> N2B + N2     : 2.4e-33'
  []
[]

[AuxVariables]
  [./reduced_field]
    order = FIRST
    family = SCALAR
  [../]

  [./e]
    order = FIRST
    family = SCALAR
  [../]

  [./Te]
    order = FIRST
    family = SCALAR
  [../]

  [./Teff]
    order = FIRST
    family = SCALAR
  [../]
[]

[AuxScalarKernels]
  [./field_calculation]
    type = ScalarLinearInterpolation
    variable = reduced_field
    # scale_factor = 1e-21
    use_time = true
    property_file = 'data/reduced_field.txt'
    execute_on = 'TIMESTEP_BEGIN'
  [../]

  [./temperature_calculation]
    type = ScalarLinearInterpolation
    variable = Te
    scale_factor = 1.5e-1
    sampler = reduced_field
    property_file = 'data/electron_temperature.txt'
    # execute_on = 'TIMESTEP_BEGIN'
    execute_on = 'TIMESTEP_BEGIN'
  [../]

  [./density_calculation]
    type = ScalarLinearInterpolation
    variable = e
    use_time = true
    property_file = 'data/electron_density.txt'
    # execute_on = 'INITIAL TIMESTEP_END'
    execute_on = 'TIMESTEP_BEGIN'
  [../]

  [./Teff_calculation]
    type = ParsedAuxScalar
    variable = Teff
    constant_names = 'Tgas'
    constant_expressions = '300'
    args = 'reduced_field'
    function = 'Tgas+(0.12*(reduced_field*1e21)^2)'
    execute_on = 'INITIAL NONLINEAR'
  [../]
[]

[Executioner]
  type = Transient
  automatic_scaling = true
  end_time = 2.5e-3
  solve_type = linear
  dt = 1e-6
[]

[Preconditioning]
  [./smp]
    type = SMP
    full = true
    #ksp_norm = none
  [../]
[]

[Outputs]
  csv = true
  [./console]
    type = Console
    execute_scalars_on = 'none'
    # execute_on = 'initial'
  [../]
[]
