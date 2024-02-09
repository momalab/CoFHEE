
  create_clock [get_pins {u_padring_inst/u_CLK_pad_inst/C}]     -name EXTCLK      -period 4.167   -waveform {0 2.0835}
  create_clock [get_pins {u_padring_inst/*23*u_pad_inst/C}]     -name TEST_CLK    -period 20  -waveform {0 10}


  create_clock [get_pins u_chip_core_inst/u_clk_rst_ctl_inst/U_AD_PLL_INST/Int_Clk]    -name PLLCLK      -period 2   -waveform {0 1}
  create_clock [get_pins u_chip_core_inst/u_clk_rst_ctl_inst/U_AD_PLL_INST/Clk_Out1]   -name PLLDBGCLK1  -period 2   -waveform {0 1}
  create_clock [get_pins u_chip_core_inst/u_clk_rst_ctl_inst/U_AD_PLL_INST/Clk_Out2]   -name PLLDBGCLK2  -period 2   -waveform {0 1}

  create_clock [get_pins u_chip_core_inst/u_clk_rst_ctl_inst/u_safe_clk_mux_inst/u_DONT_TOUCH_mux2_inst/Y] -name HCLK        -period 4.167   -waveform {0 2.0835}
  create_clock [get_pins u_chip_core_inst/u_DONT_TOUCH_clk_buf_hclk_inst/Y]    -name HCLK_DIV    -period 4   -waveform {0 2}

  create_clock [get_pins {u_padring_inst/*15*u_pad_inst/C}]                    -name SPI_CLK     -period 41.67  -waveform {0 20.835}

  set_case_analysis 0 u_chip_core_inst/u_clk_rst_ctl_inst/u_chiplib_mux2_test_clk_inst/u_DONT_TOUCH_mux2_inst/S0

  create_generated_clock -name HCLK_MDMC  -source u_chip_core_inst/u_clk_rst_ctl_inst/u_safe_clk_mux_inst/u_DONT_TOUCH_mux2_inst/Y -master_clock HCLK -divide_by 1 -add [get_pins u_chip_core_inst/u_clk_rst_ctl_inst/u_DONT_TOUCH_clk_buf_hclk_mdmc_inst/Y]
  create_generated_clock -name HCLK_MPOOL -source u_chip_core_inst/u_clk_rst_ctl_inst/u_safe_clk_mux_inst/u_DONT_TOUCH_mux2_inst/Y -master_clock HCLK -divide_by 1 -add [get_pins u_chip_core_inst/u_clk_rst_ctl_inst/u_DONT_TOUCH_clk_buf_hclk_mpool_inst/Y]
  create_generated_clock -name HCLK_FHMEM -source u_chip_core_inst/u_clk_rst_ctl_inst/u_safe_clk_mux_inst/u_DONT_TOUCH_mux2_inst/Y -master_clock HCLK -divide_by 1 -add [get_pins u_chip_core_inst/u_clk_rst_ctl_inst/u_DONT_TOUCH_clk_buf_hclk_fhmem_inst/Y]

  set_multicycle_path 2 -setup \
                        -through u_chip_core_inst/u_uarts_rx_mux_inst/y

  set_multicycle_path 1 -hold \
                        -through u_chip_core_inst/u_uarts_rx_mux_inst/y

  set_multicycle_path 2 -setup \
                        -through u_chip_core_inst/u_uartm_inst/RX

  set_multicycle_path 1 -hold \
                        -through u_chip_core_inst/u_uartm_inst/RX


  set_multicycle_path 2 -setup \
                        -thr    u_chip_core_inst/u_gpcfg_inst/u_cfg_pad*_ctl_reg_inst/wr_reg*

  set_multicycle_path 1 -hold \
                        -thr    u_chip_core_inst/u_gpcfg_inst/u_cfg_pad*_ctl_reg_inst/wr_reg*


  set_multicycle_path 2 -setup \
                        -through    u_chip_core_inst/u_gpcfg_inst/fhe_host_irq

  set_multicycle_path 1 -hold \
                        -through    u_chip_core_inst/u_gpcfg_inst/fhe_host_irq


  set_multicycle_path 2 -setup \
                        -through u_chip_core_inst/u_gpcfg_inst/u_cfg_fhe_ctl_inst/wr_reg*/Q*

  set_multicycle_path 1 -hold \
                        -through u_chip_core_inst/u_gpcfg_inst/u_cfg_fhe_ctl_inst/wr_reg*/Q*


  set_multicycle_path 2 -setup \
                        -through u_chip_core_inst/u_gpcfg_inst/u_cfg_misc1_div_reg_inst/wr_reg*/Q

  set_multicycle_path 1 -hold \
                        -through u_chip_core_inst/u_gpcfg_inst/u_cfg_misc1_div_reg_inst/wr_reg*/Q



  set_multicycle_path 2 -from [get_clocks *]  -to [get_ports pad*]
  set_false_path -hold  -from [get_clocks *]  -to [get_ports pad*]

  #if {[file exist ./constraints/ccs0301_constraints.tcl]} {
  #   source -echo -verbose ./constraints/ccs0301_constraints.tcl
  #}


for {set i 0} {$i < 12} {incr i } {
  set_multicycle_path 2 -setup \
                        -through    u_chip_core_inst/u_gpcfg_inst/u_cfg_fhe_ctl2_reg_inst/wr_reg[$i]
  set_multicycle_path 1 -hold \
                        -through    u_chip_core_inst/u_gpcfg_inst/u_cfg_fhe_ctl2_reg_inst/wr_reg[$i]
}

  set input_ports [remove_from_collection [all_inputs] {HCLK VDD VSS DVDD DVSS pad[0] pad[23] pad[15] pad[16] pad[17]}]
  set output_ports [remove_from_collection [all_outputs] {pad[18]}]

  set_input_delay -max 3   [get_ports $input_ports ] -clock HCLK
  set_input_delay -min 1.5 [get_ports $input_ports ] -clock HCLK

  set_input_delay -max  5 [get_ports pad[17]] -clock SPI_CLK -clock_fall
  set_input_delay -min -5 [get_ports pad[17]] -clock SPI_CLK -clock_fall

  set_output_delay -max 3 [get_ports $output_ports ] -clock HCLK
  set_output_delay -min 3 [get_ports $output_ports ] -clock HCLK

  set_output_delay -max 5 [get_ports pad[18] ] -clock SPI_CLK
  set_output_delay -min 0 [get_ports pad[18] ] -clock SPI_CLK

  set_clock_groups -asynchronous -group {HCLK} -group {SPI_CLK}


  set_input_transition -max 2 [get_ports $input_ports]
  set_input_transition -min 0 [get_ports $input_ports]

  set_multicycle_path 2 -setup \
                        -fall_from   [get_clock HCLK]  \
                        -to          $output_ports
  set_false_path -hold \
                        -to    $output_ports
  set_false_path -hold \
                        -from  $input_ports

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
