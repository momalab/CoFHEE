date
set_host_options -max_cores 8
set high_fanout_net_threshold 0
set compile_seqmap_propagate_constants     false
set compile_seqmap_propagate_high_effort   false
set compile_enable_register_merging        false
set write_sdc_output_net_resistance        false
set timing_separate_clock_gating_group     true
set verilogout_no_tri tru
set html_log_enable true

  set target_library {
                       /home/projects/vlsi/libraries/55lpe/55lpe/sc9/arm/gf/55lpe/sc9_base_hvt/r1p0/db/sc9_55lpe_base_hvt_ss_nominal_max_1p08v_125c.db \
                     }

  set link_library {
                     /home/projects/vlsi/libraries/55lpe/55lpe/sc9/arm/gf/55lpe/sc9_base_hvt/r1p0/db/sc9_55lpe_base_hvt_ss_nominal_max_1p08v_125c.db \
                     /home/projects/vlsi/libraries/55lpe/55lpe/sc9/arm/gf/55lpe/sc9_base_rvt/r1p0/db/sc9_55lpe_base_rvt_ss_nominal_max_1p08v_125c.db \
                     /home/projects/vlsi/libraries/65lpe/ref_lib/aragio/io_pads/timing_lib/nldm/db/rgo_csm65_25v33_lpe_50c_ss_108_297_125.db         \
                     /home/projects/vlsi/libraries/55lpe/55lpe/sram/USERLIB_ccs_ss_1p08v_1p08v_125c.db                                               \
                   }



read_verilog -netlist  ./24_Sep_2019/netlist/ccs0201.v

current_design ccs0201


  set_wire_load_model -name Zero
  set_annotated_delay -net -from  [get_pins u_padring_inst/*u_pad_inst/PAD] -to [get_ports pad*] 0
  set_annotated_delay -net -to  [get_pins u_padring_inst/*u_pad_inst/PAD] -from [get_ports pad*] 0
  foreach_in_collection port [get_ports *] {
    set_resistance 0 [all_connected $port ]
  }


   foreach_in_collection abc [get_pins u_chip_core_inst/u_random_num_gen*_inst/trng_wrap_inst*/trng_inst*u_trng_inst*/u_trng_mux*_inst/u_DONT_TOUCH_mux2_inst/Y] {
     set pqr [get_attribute $abc full_name]
     set_disable_timing $pqr
   }


  create_clock [get_pins u_chip_core_inst/u_DONT_TOUCH_clk_buf_ro_type1_fix_inst/Y]  -name RO_TYPE1_FIX  -period 2  -waveform {0 1}
  create_clock [get_pins u_chip_core_inst/u_DONT_TOUCH_clk_buf_ro_type2_fix_inst/Y]  -name RO_TYPE2_FIX  -period 2  -waveform {0 1}
  create_clock [get_pins u_chip_core_inst/u_DONT_TOUCH_clk_buf_ro_type3_fix_inst/Y]  -name RO_TYPE3_FIX  -period 2  -waveform {0 1}
  create_clock [get_pins u_chip_core_inst/u_DONT_TOUCH_clk_buf_ro_type4_fix_inst/Y]  -name RO_TYPE4_FIX  -period 2  -waveform {0 1}
  create_clock [get_pins u_chip_core_inst/u_DONT_TOUCH_clk_buf_ro_type1_var_inst/Y]  -name RO_TYPE1_VAR  -period 2  -waveform {0 1}
  create_clock [get_pins u_chip_core_inst/u_DONT_TOUCH_clk_buf_ro_type2_var_inst/Y]  -name RO_TYPE2_VAR  -period 2  -waveform {0 1}
  create_clock [get_pins u_chip_core_inst/u_DONT_TOUCH_clk_buf_ro_type3_var_inst/Y]  -name RO_TYPE3_VAR  -period 2  -waveform {0 1}
  create_clock [get_pins u_chip_core_inst/u_DONT_TOUCH_clk_buf_ro_type4_var_inst/Y]  -name RO_TYPE4_VAR  -period 2  -waveform {0 1}
  create_clock [get_pins u_chip_core_inst/u_DONT_TOUCH_clk_buf_hclk_inst/Y]  -name HCLK_DIV  -period 2  -waveform {0 1}

  create_clock [get_pins {u_padring_inst/u_CLK_pad_inst/C}]  -name HCLK  -period 8  -waveform {0 4}
  #group_path -to u_chip_core_inst/u_bin_ext_gcd_inst/ay_loc_reg*/D -name ay_loc_reg_bin_ext_gcd
  set_multicycle_path 2 -setup \
                        -through u_chip_core_inst/u_mod_mul_il_inst/m*


  set_multicycle_path 1  -hold \
                         -through u_chip_core_inst/u_mod_mul_il_inst/m*

  set_multicycle_path 2 -setup \
                        -through u_chip_core_inst/u_gpcfg_inst/u_mod_exp_inst/m*


  set_multicycle_path 1  -hold \
                         -through u_chip_core_inst/u_gpcfg_inst/u_mod_exp_inst/m*


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
                        -through    u_chip_core_inst/u_gpcfg_inst/cleq_host_irq

  set_multicycle_path 1 -hold \
                        -through    u_chip_core_inst/u_gpcfg_inst/cleq_host_irq

  set_multicycle_path 2 -setup \
                        -through  u_chip_core_inst/u_gpcfg_inst/gfunc_curr_state*/Q* \
                        -to       u_chip_core_inst/u_gpcfg_inst/mod_inv*/*

  set_multicycle_path 1 -hold \
                        -through  u_chip_core_inst/u_gpcfg_inst/gfunc_curr_state*/Q* \
                        -to       u_chip_core_inst/u_gpcfg_inst/mod_inv*/*

  set_multicycle_path 2 -setup \
                        -through u_chip_core_inst/u_gpcfg_inst/arg_b_mod_inv*

  set_multicycle_path 1 -hold \
                        -through u_chip_core_inst/u_gpcfg_inst/arg_b_mod_inv*

  set_multicycle_path 2 -setup \
                        -through u_chip_core_inst/u_gpcfg_inst/u_cfg_cleq_ctl_inst/wr_reg*/Q*

  set_multicycle_path 1 -hold \
                        -through u_chip_core_inst/u_gpcfg_inst/u_cfg_cleq_ctl_inst/wr_reg*/Q*


  set_multicycle_path 2 -setup \
                        -through u_chip_core_inst/u_gpcfg_inst/u_cfg_ro_type*_div_reg_inst/wr_reg*/Q

  set_multicycle_path 1 -hold \
                        -through u_chip_core_inst/u_gpcfg_inst/u_cfg_ro_type*_div_reg_inst/wr_reg*/Q



  set_multicycle_path 2 -setup -thr u_chip_core_inst/u_bin_ext_gcd_inst/x
  set_multicycle_path 1 -hold  -thr u_chip_core_inst/u_bin_ext_gcd_inst/x
  set_multicycle_path 2 -setup -thr u_chip_core_inst/u_bin_ext_gcd_inst/y
  set_multicycle_path 1 -hold  -thr u_chip_core_inst/u_bin_ext_gcd_inst/y

  set_multicycle_path 2 -from [get_clocks *]  -to [get_ports pad*]
  set_false_path -hold  -from [get_clocks *]  -to [get_ports pad*]



for {set i 0} {$i < 12} {incr i } {
  set_multicycle_path 2 -setup \
                        -through    u_chip_core_inst/u_gpcfg_inst/u_cfg_cleq_ctl2_reg_inst/wr_reg[$i]
  set_multicycle_path 1 -hold \
                        -through    u_chip_core_inst/u_gpcfg_inst/u_cfg_cleq_ctl2_reg_inst/wr_reg[$i]
}

  set input_ports [remove_from_collection [all_inputs] {HCLK VDD VSS DVDD DVSS pad[0]}]
  set output_ports [all_outputs]

  set_input_delay -max 3 [get_ports $input_ports ] -clock HCLK
  set_input_delay -min 1.5 [get_ports $input_ports ] -clock HCLK

  set_output_delay -max 3 [get_ports $output_ports ] -clock HCLK
  set_output_delay -min 3 [get_ports $output_ports ] -clock HCLK

  set_input_transition -max 2 [get_ports $input_ports]
  set_input_transition -min 0 [get_ports $input_ports]

  set_multicycle_path 2 -setup \
                        -fall_from   [get_clock HCLK]  \
                        -to          [all_outputs]
  set_false_path -hold \
                        -to    [all_outputs]

  #set_units -capacitance fF
  set_load -max 10   [get_ports $output_ports]
  set_load -min 2    [get_ports $output_ports]


  group_path -name output_group -to   [all_outputs]
  group_path -name input_group  -from [all_inputs]

  report_power -analysis_effort high                                              > ~/2
  update_timing
  report_power -analysis_effort high                                              > ~/22
set_switching_activity -toggle_rate 5 -period 100  -static_probability 0.50 -type inputs
propagate_switching_activity
  report_power -analysis_effort high                                              > ~/222

