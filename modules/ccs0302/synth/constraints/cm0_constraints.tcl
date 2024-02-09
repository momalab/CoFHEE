  create_clock HCLK  -name CLK  -period 4

  set input_ports  [remove_from_collection [all_inputs] HCLK]
  set output_ports [all_outputs]

  set_input_delay  -max 2   [get_ports $input_ports ]  -clock CLK
  set_input_delay  -min 0   [get_ports $input_ports ]  -clock CLK

  set_output_delay -max 2   [get_ports $output_ports ] -clock CLK
  set_output_delay -min 0.5 [get_ports $output_ports ] -clock CLK

  set_input_transition -max 0.5 [get_ports $input_ports]
  set_input_transition -min 0   [get_ports $input_ports]

  set_load -max .5     [get_ports $output_ports]
  set_load -min .0005  [get_ports $output_ports]

  group_path -name output_group -to   [all_outputs]
  group_path -name input_group  -from [all_inputs]
