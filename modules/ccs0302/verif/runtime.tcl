dump -add { ccs0302_tb }  -depth 0 -scope "." -filter=variable,generic,constant,pack_vh,parameter,define_cell,y_cell_lib,specify,child_cell
gui_open_window Wave
gui_source ./barrett.inter.vpd.tcl
#gui_source ./host_irq_debug.inter.vpd.tcl
#gui_source ./aes.inter.vpd.tcl
#run 2 ms
#run 96 ms
#gui_source ./rng_sigs.tcl
#gui_source ./aes.inter.vpd.tcl
