set_multicycle_path -setup 3 -to u_chip_core_inst/u_gpio_inst/gpio*_sync1_reg/D -from $input_ports
set_false_path -hold         -to u_chip_core_inst/u_gpio_inst/gpio*_sync1_reg/D -from $input_ports

set_multicycle_path -setup 2 -to u_chip_core_inst/*sram_*wrap_*inst/*u_spram_inst/RET1N
set_multicycle_path -hold  1 -to u_chip_core_inst/*sram_*wrap_*inst/*u_spram_inst/RET1N


set_multicycle_path -setup 3 -from u_chip_core_inst/u_gpcfg_inst/u_cfg_*reg_inst/wr_reg*/C*K -to $output_ports
set_false_path -hold         -from u_chip_core_inst/u_gpcfg_inst/u_cfg_*reg_inst/wr_reg*/C*K -to $output_ports


set_multicycle_path -setup 3 -from u_chip_core_inst/u_clk_rst_ctl_inst/nporeset_sync0_reg/CK  -to $output_ports
set_false_path -hold         -from u_chip_core_inst/u_clk_rst_ctl_inst/nporeset_sync0_reg/CK  -to $output_ports


set_multicycle_path -setup 3 -from $input_ports  -to [get_clocks HCLK]

set_multicycle_path 2 -start -setup -from [get_clock HCLK] -to [get_clock HCLK_DIV]
set_multicycle_path 1 -hold         -from [get_clock HCLK] -to [get_clock HCLK_DIV]

set_false_path -setup -to $output_ports -from [get_clocks HCLK_DIV]

set_false_path -hold -from u_chip_core_inst/u_gpcfg_inst/u_cfg_misc1_div_reg_inst/wr_reg_reg_*/CK -to [get_clocks HCLK_DIV]

set_false_path -hold -to u_chip_core_inst/u_uarts_inst/sample_data_bit_reg/D -from $input_ports


set_case_analysis 1 [get_pins u_chip_core_inst/*sram_wrap*/*spram_inst*/RET1N]
set_case_analysis 1 [get_pins u_chip_core_inst/*sram_wrap*/*spram_inst*/EMA[0]]
set_case_analysis 0 [get_pins u_chip_core_inst/*sram_wrap*/*spram_inst*/EMA[1]]
set_case_analysis 1 [get_pins u_chip_core_inst/*sram_wrap*/*spram_inst*/EMA[2]]
set_case_analysis 0 [get_pins u_chip_core_inst/*sram_wrap*/*spram_inst*/EMAW[0]]
set_case_analysis 0 [get_pins u_chip_core_inst/*sram_wrap*/*spram_inst*/EMAW[1]]
#set_case_analysis 0 [get_pins u_chip_core_inst/*sram_wrap*/*spram_inst*/EMAS]
