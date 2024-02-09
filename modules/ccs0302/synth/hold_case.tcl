     1  source ../scripts/setup/icc_setup.tcl
     2  open_mw_lib ccs0302_LIB/
     3  open_mw_cel route_opt_icc
     4  report_timing
     5  report_timing -delay_type min -slack_lesser_than -0.5
     6  report_timing -to u_chip_core_inst/sram_dp_fhe_gen_0__u_sram_wrap_dp_fhe_inst/genblk1_1__u_sram00_dp_16x4096/COLLDISN -delay min
     7  report_timing -to u_chip_core_inst/sram_dp_fhe_gen_0__u_sram_wrap_dp_fhe_inst/genblk1_1__u_sram00_dp_16x4096/* -delay min -nworst 1 -max_paths 100 -path_type summary
     8  report_timing -to u_chip_core_inst/sram_dp_fhe_gen_0__u_sram_wrap_dp_fhe_inst/genblk1_1__u_sram00_dp_16x4096/* -delay min -nworst 1 -max_paths 100 -path_type start
     9  q
    10  report_timing -to u_chip_core_inst/sram_dp_fhe_gen_0__u_sram_wrap_dp_fhe_inst/genblk1_1__u_sram00_dp_16x4096/* -delay min -nworst 1 -max_paths 100 -path_type start -slack_lesser_than 0 > ~/mtn2
    11  sh cat ~/mtn2
    12  report_timing -to u_chip_core_inst/sram_dp_fhe_gen_0__u_sram_wrap_dp_fhe_inst/genblk1_1__u_sram00_dp_16x4096/* -delay min -nworst 1 -max_paths 100 -path_type end  -slack_lesser_than 0 > ~/mtn2
    13  sh cat ~/mtn2
    14  sh grep COLLDISN /home/projects/vlsi/ccs0302/design/modules/memss/rtl/sram_wrap_dp.v
    15  set_case_analysis 0 u_chip_core_inst/sram_dp_fhe_gen_*__u_sram_wrap_dp_fhe_inst/genblk1_*__u_sram*_dp_16x4096/COLLDISN
    16  sh grep EMA /home/projects/vlsi/ccs0302/design/modules/memss/rtl/sram_wrap_dp.v
    17  set_case_analysis 1 u_chip_core_inst/sram_dp_fhe_gen_*__u_sram_wrap_dp_fhe_inst/genblk1_*__u_sram*_dp_16x4096/EMA*[2]
    18  set_case_analysis 0 u_chip_core_inst/sram_dp_fhe_gen_*__u_sram_wrap_dp_fhe_inst/genblk1_*__u_sram*_dp_16x4096/EMA*[1]
    19  set_case_analysis 0 u_chip_core_inst/sram_dp_fhe_gen_*__u_sram_wrap_dp_fhe_inst/genblk1_*__u_sram*_dp_16x4096/EMA*[0]
    20  sh grep RET /home/projects/vlsi/ccs0302/design/modules/memss/rtl/sram_wrap_dp.v
    21  set_case_analysis 1 u_chip_core_inst/sram_dp_fhe_gen_*__u_sram_wrap_dp_fhe_inst/genblk1_*__u_sram*_dp_16x4096/RET1N
    22  history > /home/projects/vlsi/ccs0302/design/modules/ccs0302/synth/hold_case.tcl
