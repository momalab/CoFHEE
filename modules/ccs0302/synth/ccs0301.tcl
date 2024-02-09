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
#set hdlin_enable_elaborate_ref_linking true

set design       [getenv "PROJECT_NAME"]
set prj_name     [getenv "PROJECT_NAME"]
set prj_path     [getenv "PROJECT_MODULES"]
set target_lib   [getenv "SYNTH_LIBRARY"]
set tech         [getenv "TECH"]
set run_date [date]
set abc      [regexp -inline -all -- {\S+} $run_date]
#set abc      [split $run_date " .*"]
set date     [lindex $abc 2]  
set month    [lindex $abc 1]  
set year     [lindex $abc 4]  
set run_dir  ${date}_${month}_${year}

#if {[file exist $run_dir]} {
#sh rm -rf $run_dir
#}

sh mkdir -p $run_dir/reports
sh mkdir -p $run_dir/netlist

set search_path [concat * $search_path]

sh rm -rf ./work
define_design_lib WORK -path ./work

  set_svf $design.svf


  set target_library {
                       /home/projects/vlsi/libraries/55lpe/55lpe/sc9/arm/gf/55lpe/sc9_base_hvt/r1p0/db/sc9_55lpe_base_hvt_ss_nominal_max_1p08v_125c.db \
                     }

  set link_library {
                     ./AD_PLL.db
                     /home/projects/vlsi/libraries/55lpe/55lpe/sc9/arm/gf/55lpe/sc9_base_hvt/r1p0/db/sc9_55lpe_base_hvt_ss_nominal_max_1p08v_125c.db \
                     /home/projects/vlsi/libraries/55lpe/55lpe/sc9/arm/gf/55lpe/sc9_base_rvt/r1p0/db/sc9_55lpe_base_rvt_ss_nominal_max_1p08v_125c.db \
                     /home/projects/vlsi/libraries/65lpe/ref_lib/aragio/io_pads/timing_lib/nldm/db/rgo_csm65_25v33_lpe_50c_ss_108_297_125.db         \
                     /home/projects/vlsi/libraries/55lpe/ref_lib/arm/memories/spram_hs_32x8192/sram_hs_32x8192_nldm_ss_1p08v_1p08v_125c.db           \
                     /home/projects/vlsi/libraries/55lpe/ref_lib/arm/memories/sram_dp_16x4096/timing_lib/sram_dp_16x4096_nldm_ss_1p08v_1p08v_125c.db \
                     /home/projects/vlsi/libraries/55lpe/ref_lib/arm/memories/spram_hd_32x4096/spram_hd_32x4096_nldm_ss_1p08v_1p08v_125c.db          \
                     /home/projects/vlsi/libraries/55lpe/ref_lib/arm/memories/spram_hd_32x8192/spram_hd_32x8192_nldm_ss_1p08v_1p08v_125c.db
                   }

#mod_mul.v         montgomery_red.v* nom_mul.v

  analyze -library WORK -format sverilog "
                            $prj_path/ccs0301_defines/rtl/ccs0301_defines.v \
                            $prj_path/memss/rtl/pram.v \
                            $prj_path/memss/rtl/sram_wrap.v \
                            $prj_path/memss/rtl/sram_wrap_dp.v \
                            $prj_path/memss/rtl/sram_wrap_cm0.v \
                            $prj_path/ahb_ic/rtl/ahb_ic.v \
                            $prj_path/uartm/rtl/uartm.v \
                            $prj_path/uartm/rtl/uartm_rx.v \
                            $prj_path/uartm/rtl/uartm_tx.v \
                            $prj_path/uartm/rtl/uartm_ahb.v \
                            $prj_path/spim/rtl/spim.v \
                            $prj_path/spim/rtl/spim_ahb.v \
                            $prj_path/spim/rtl/SPI_Slave.v \
                            $prj_path/mdmc/rtl/mdmc.v \
                            $prj_path/mdmc/rtl/mdmc_ahb.v \
                            $prj_path/multpool/rtl/multpool_rd_wr.v \
                            $prj_path/multpool/rtl/mutlpool_rdata_mux.v \
                            $prj_path/multpool/rtl/mod_mul_il.v \
                            $prj_path/multpool/rtl/nom_mul.v \
                            $prj_path/multpool/rtl/mod_mul.v \
                            $prj_path/multpool/rtl/barrett_red.v \
                            $prj_path/multpool/rtl/butterfly.v \
                            $prj_path/multpool/rtl/multpool.v \
                            $prj_path/multpool/rtl/mul_fifo.v \
                            $prj_path/gpcfg/rtl/gpcfg_rd.v \
                            $prj_path/gpcfg/rtl/gpcfg_rd_wr.v \
                            $prj_path/gpcfg/rtl/gpcfg_rd_wr_p.v \
                            $prj_path/gpcfg/rtl/gpcfg_rdata_mux.v \
                            $prj_path/gpcfg/rtl/command_fifo.v \
                            $prj_path/gpcfg/rtl/gpcfg.v \
                            $prj_path/dma/rtl/dma.v \
                            $prj_path/gpio/rtl/gpio.v \
                            $prj_path/timer/rtl/timer.v \
                            $prj_path/uarts/rtl/uarts_rx.v \
                            $prj_path/uarts/rtl/uarts_tx.v \
                            $prj_path/uarts/rtl/uarts.v \
                            $prj_path/chip_core/rtl/chip_core.v \
                            $prj_path/clk_ctl/rtl/clk_rst_ctl.v \
                            $prj_path/clk_ctl/rtl/gfm.v \
                            $prj_path/clk_ctl/rtl/clkdiv.v \
                            $prj_path/chiplib/rtl/chiplib.v \
                            $prj_path/$design/rtl/$design.v \
                            $prj_path/padring/rtl/padring.v"

  if {[file exist ./cm0_locked_netlist/CORTEXM0DS_wrap_TRLL_DisORC_scan_post_gates_withLAT.v]} {
     read_verilog -netlist ./cm0_locked_netlist/CORTEXM0DS_wrap_TRLL_DisORC_scan_post_gates_withLAT.v
     elaborate $design
     set_dont_touch [get_cells u_chip_core_inst/u_cortexm0_wrap_inst/* -filter "ref_name =~ *SDFF*"]
  } else {
                            #$prj_path/cortexm0/rtl/cortexm0ds_logic_128_all.v
    analyze -library WORK -format sverilog "
                            $prj_path/cortexm0/rtl/cortexm0ds_logic.v \
                            $prj_path/cortexm0/rtl/CORTEXM0DS.v \
                            $prj_path/chip_core/rtl/CORTEXM0DS_wrap.v"

    elaborate CORTEXM0DS_wrap
    if {[file exist ./constraints/cm0_constraints.tcl]} {
       source -echo -verbose ./constraints/cm0_constraints.tcl
    }
    compile_ultra -no_autoungroup -no_seq_output_inversion -no_boundary_optimization -area_high_effort_script
    ungroup -all -flatten
    write -format verilog -hierarchy -output $run_dir/netlist/CORTEXM0DS_wrap_for_lock.v
  #}



date
set_dont_use [get_lib_cells */*X0P*]

 
set_dont_touch [get_cells -hier *DONT_TOUCH*]

set_dont_touch_network VDD
set_dont_touch_network DVDD
set_dont_touch_network VSS
set_dont_touch_network DVSS
set_dont_touch_network u_padring_inst/u_nRESET_pad_inst/C
set_dont_touch_network u_padring_inst/u_nPORESET_pad_inst/C
set_dont_touch_network u_padring_inst/u_CLK_pad_inst/C

set_dont_touch_network [all_connected [get_nets -hier *_HV]]


link

  set_wire_load_model -name Zero
  set_max_area 0
  set_clock_gating_style -sequential_cell latch -positive_edge_logic {nand} -negative_edge_logic {nor} -minimum_bitwidth 5 -max_fanout 64
  set_annotated_delay -net -from  [get_pins u_padring_inst/*u_pad_inst/PAD] -to [get_ports pad*] 0
  set_annotated_delay -net -to    [get_pins u_padring_inst/*u_pad_inst/PAD] -from [get_ports pad*] 0
  foreach_in_collection port [get_ports *] {
    set_resistance 0 [all_connected $port ]
  }


#date
  uniquify

current_design $design

  create_clock [get_pins {u_padring_inst/u_CLK_pad_inst/C}]     -name EXTCLK      -period 4   -waveform {0 2}
  create_clock [get_pins {u_padring_inst/*23*u_pad_inst/C}]     -name TEST_CLK    -period 20  -waveform {0 10}


  create_clock [get_pins u_chip_core_inst/u_clk_rst_ctl_inst/U_AD_PLL_INST/Int_Clk]    -name PLLCLK      -period 4   -waveform {0 2}
  create_clock [get_pins u_chip_core_inst/u_clk_rst_ctl_inst/U_AD_PLL_INST/Clk_Out1]   -name PLLDBGCLK1  -period 4   -waveform {0 2}
  create_clock [get_pins u_chip_core_inst/u_clk_rst_ctl_inst/U_AD_PLL_INST/Clk_Out2]   -name PLLDBGCLK2  -period 4   -waveform {0 2}

  create_clock [get_pins u_chip_core_inst/u_clk_rst_ctl_inst/u_safe_clk_mux_inst/u_DONT_TOUCH_mux2_inst/Y] -name HCLK        -period 4   -waveform {0 2}
  create_clock [get_pins u_chip_core_inst/u_DONT_TOUCH_clk_buf_hclk_inst/Y]    -name HCLK_DIV    -period 8   -waveform {0 4}

  create_clock [get_pins {u_padring_inst/*15*u_pad_inst/C}]                    -name SPI_CLK     -period 20  -waveform {0 10}

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

  #set_units -capacitance fF
  set_load -max 10   [get_ports $output_ports]
  set_load -min 2    [get_ports $output_ports]


  group_path -name output_group -to   $output_ports
  group_path -name input_group  -from $input_ports

date
  check_design -nosplit      > ./$run_dir/reports/check_design_pre_comp.rpt
  compile_ultra -no_autoungroup -no_seq_output_inversion -no_boundary_optimization -gate_clock -area_high_effort_script

  change_names -hier -rule verilog
  write_file -hierarchy -format verilog -output "./$run_dir/netlist/${design}_comp1.v"
  write_sdc "./$run_dir/netlist/${design}_comp1.sdc"
  report_area

  if {[file exist ./constraints/ccs0301_constraints.tcl]} {
     source -echo -verbose ./constraints/ccs0301_constraints.tcl
  }


date
   optimize_netlist -area
   report_area
date
  compile_ultra -no_autoungroup -no_seq_output_inversion -no_boundary_optimization -incremental
date
   
   change_names -hier -rule verilog

   write_file -hierarchy -format verilog -output "./$run_dir/netlist/${design}.v"
   write_sdc "./$run_dir/netlist/${design}.sdc"
   write_file -hierarchy -format ddc -output "./$run_dir/netlist/${design}.ddc"

set_switching_activity -toggle_rate 5 -period 100  -static_probability 0.50 -type inputs
propagate_switching_activity

   report_timing -delay max  -nosplit -input -nets -cap -max_path 10 -nworst 10    > ./$run_dir/reports/report_timing_max.rpt
   report_timing -delay min  -nosplit -input -nets -cap -max_path 10 -nworst 10    > ./$run_dir/reports/report_timing_min.rpt
   report_constraint -all_violators -verbose  -nosplit                             > ./$run_dir/reports/report_constraint.rpt
   check_design -nosplit                                                           > ./$run_dir/reports/check_design.rpt
   report_design                                                                   > ./$run_dir/reports/report_design.rpt
   report_area                                                                     > ./$run_dir/reports/report_area.rpt
   report_timing -loop                                                             > ./$run_dir/reports/timing_loop.rpt
   report_power -analysis_effort high                                              > ./$run_dir/reports/report_power.rpt
   report_qor                                                                      > ./$run_dir/reports/report_qor.rpt
   report_area -hierarchy -nosplit                                                 > ./$run_dir/reports/report_area_hier.rpt
   report_power -hierarchy -analysis_effort high                                   > ./$run_dir/reports/report_power_hier.rpt

date

current_design CORTEXM0DS_wrap
current_dbarrett_red_opt_4_fly_NBITS${numbits}_LOG2POLYDEG${zbits}_PBITS${pbits}ap
write -fobarrett_red_opt_4_fly_NBITS${numbits}_LOG2POLYDEG${zbits}_PBITS${pbits}rchy -output $run_dir/netlist/CORTEXM0DS_wrap_for_pd.v
write_sdc "./$run_dir/netlist/CORTEXM0DS_wrap_for_lock_final.sdc"

current_design $design
remove_design -hier CORTEXM0DS_wrap
write_file -hierarchy -format verilog -output "./$run_dir/netlist/${design}_cm0_bbox.v"

