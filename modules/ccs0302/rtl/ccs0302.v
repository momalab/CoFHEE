module ccs0302 #(
  parameter NUM_PADS  = 26,
  parameter NBITS     = 128,
`ifdef FPGA_SYNTH
  parameter POLYDEG   = 4096,
`else
  parameter POLYDEG   = 8192,
`endif
  parameter NMUL      = 1,
  parameter NPLINE    = 16
)
  (
`ifndef FPGA_SYNTH
  input wire                VDD,
  input wire                DVDD,
  input wire                VSS,
  input wire                DVSS,
`endif
  inout wire [NUM_PADS-1:0] pad
  );

//-------------------------------
//localparam and wire declaration
//-------------------------------
 localparam PAD_CTL_W = 9;
 
 wire [NUM_PADS-1  :3] pad_in;
 wire [NUM_PADS-1  :0] pad_out;
 wire [PAD_CTL_W-1 :0] pad_ctl[NUM_PADS-1 :3];

  padring #(
    .NUM_PADS  (NUM_PADS),
    .PAD_CTL_W (PAD_CTL_W)
    ) u_padring_inst (
`ifndef FPGA_SYNTH
    .VDD       (VDD),
    .DVDD      (DVDD),
    .VSS       (VSS),
    .DVSS      (DVSS),
`endif
    .pad       (pad),
    .pad_in    (pad_in),
    .pad_out   (pad_out),
    .pad_ctl   (pad_ctl)
    );

  chip_core #(
    .NUM_PADS  (NUM_PADS),
    .PAD_CTL_W (PAD_CTL_W),
    .NBITS     (NBITS),
    .POLYDEG   (POLYDEG),
    .NMUL      (NMUL),
    .NPLINE    (NPLINE)
    )u_chip_core_inst (
    .pad_in    (pad_in),
    .pad_out   (pad_out),
    .pad_ctl   (pad_ctl)
    );


endmodule
