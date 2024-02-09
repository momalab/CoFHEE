source ~/source_lib_gf55lpe.tcl
read_verilog -rtl  /home/projects/vlsi/ccs0302/design/modules/clk_ctl/rtl/AD_PLL.v

create_mw_lib AD_PLL -technology  /home/projects/vlsi/libraries/55lpe/tech/tf/sc9_tech.tf -open

foreach_in port [get_ports "*"] {
		  set port_direction [get_attribute $port port_direction]
		  set port_name [get_object_name $port]
		  #if {[sizeof_collection [remove_from_collection $port $clock_ports]] == 0} { set port_direction clk }
		  set basename $port_name  ;# fallback if port is not indexed
		  set index {}  ;# fallback if port is not indexed
		  regexp {(.*)\[(.*)\]} $port_name dummy basename index
		  if {[info exists port_directions($basename)] && $port_directions($basename) ne $port_direction} {
		   error "Bussed port '$basename' cannot be both '$port_directions($basename)' and '$port_direction'."
		  }
		  set port_directions($basename) $port_direction
		  lappend ${port_direction}($basename) $index
		 }

create_qtm_model [get_object_name [current_design]]
set_qtm_technology -lib sc9_55lpe_base_hvt_ss_nominal_max_1p08v_125c

foreach port [lsort [array names in]] {
	  if {[lindex $in($port) 0] eq {}} {
	   create_qtm_port -type input $port
	  } else {
	   set low_index [lindex [lsort -integer -increasing $in($port)] 0]
	   set high_index [lindex [lsort -integer -decreasing $in($port)] 0]
	   create_qtm_port -type input ${port}[$high_index:$low_index]
	  }
	 }

foreach port [lsort [array names out]] {
	  if {[lindex $out($port) 0] eq {}} {
	   create_qtm_port -type output $port
	  } else {
	   set low_index [lindex [lsort -integer -increasing $out($port)] 0]
	   set high_index [lindex [lsort -integer -decreasing $out($port)] 0]
	   create_qtm_port -type output ${port}[$high_index:$low_index]
	  }
	 }

foreach port [lsort [array names inout]] {
	  if {[lindex $inout($port) 0] eq {}} {
	   create_qtm_port -type inout $port
	  } else {
	   set low_index [lindex [lsort -integer -increasing $inout($port)] 0]
	   set high_index [lindex [lsort -integer -decreasing $inout($port)] 0]
	   create_qtm_port -type inout ${port}[$high_index:$low_index]
	  }
	 }

###****************************************
###Report : qtm_model
###Design : AD_PLL
###****************************************
###create_qtm_model AD_PLL
###set_qtm_technology -library sc9_55lpe_base_hvt_ss_nominal_max_1p08v_125c
###create_qtm_port -type input { In_cdn[4:0] }
###create_qtm_port -type input { REF }
###create_qtm_port -type input { div[7:0] }
###create_qtm_port -type input { div_os[3:0] }
###create_qtm_port -type input { rst_nSAR }
###create_qtm_port -type input { rst_nld }
###create_qtm_port -type input { rst_nos }
###create_qtm_port -type output { Clk_Out1 }
###create_qtm_port -type output { Clk_Out2 }
###create_qtm_port -type output { Int_Clk }
###create_qtm_port -type inout { IB_FD }
###create_qtm_port -type inout { IB_PD }
###create_qtm_port -type inout { IB_SNK }
###create_qtm_port -type inout { IB_SRC }
###create_qtm_port -type inout { VB_CSFD }
###create_qtm_port -type inout { VB_CSPD }
###create_qtm_port -type inout { VB_PDN }
###create_qtm_port -type inout { VB_PUP }
###report_qtm_model
save_qtm_model -format db
save_qtm_model -format lib
