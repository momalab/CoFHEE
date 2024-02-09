dump -add { ccs0201_tb }  -depth 0 -scope "." -filter=variable,generic,constant,pack_vh,parameter,define_cell,y_cell_lib,specify,child_cell
gui_open_window Wave
#gui_source ./intel_v0.inter.vpd.tcl
gui_source ./host_irq_debug.inter.vpd.tcl
#gui_source ./aes.inter.vpd.tcl
run 3 ms
#gui_source ./rng_sigs.tcl
#gui_source ./aes.inter.vpd.tcl
