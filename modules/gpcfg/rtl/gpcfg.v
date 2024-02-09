module gpcfg #(
parameter NBITS = 128) (  
  // CLOCK AND RESETS ------------------
  input  wire                 hclk,              // Clock
  input  wire                 hresetn,           // Asynchronous reset
 // AHB-LITE MASTER PORT --------------
  input   wire                hsel,              // AHB transfer: non-sequential only
  input   wire [31:0]         haddr,             // AHB transaction address
  input   wire [ 3:0]         hsize,             // AHB size: byte, half-word or word
  input   wire [31:0]         hwdata,            // AHB write-data
  input   wire                hwrite,            // AHB write control
  output  wire [31:0]         hrdata,            // AHB read-data
  output  reg                 hready,            // AHB stall signal
  output  reg                 hresp,             // AHB error response
  output  wire  [31:0]        pad03_ctl_reg,
  output  wire  [31:0]        pad04_ctl_reg,
  output  wire  [31:0]        pad05_ctl_reg,
  output  wire  [31:0]        pad06_ctl_reg,
  output  wire  [31:0]        pad07_ctl_reg,
  output  wire  [31:0]        pad08_ctl_reg,
  output  wire  [31:0]        pad09_ctl_reg,
  output  wire  [31:0]        pad10_ctl_reg,
  output  wire  [31:0]        pad11_ctl_reg,
  output  wire  [31:0]        pad12_ctl_reg,
  output  wire  [31:0]        pad13_ctl_reg,
  output  wire  [31:0]        pad14_ctl_reg,
  output  wire  [31:0]        pad15_ctl_reg,
  output  wire  [31:0]        pad16_ctl_reg,
  output  wire  [31:0]        pad17_ctl_reg,
  output  wire  [31:0]        pad18_ctl_reg,
  output  wire  [31:0]        pad19_ctl_reg,
  output  wire  [31:0]        pad20_ctl_reg,
  output  wire  [31:0]        pad21_ctl_reg,
  output  wire  [31:0]        pad22_ctl_reg,
  output  wire  [31:0]        pad23_ctl_reg,
  output  wire  [31:0]        pad24_ctl_reg,
  output  wire  [31:0]        pad25_ctl_reg,
  output  wire  [31:0]        dma_src_addr,
  output  wire  [31:0]        dma_dst_addr,
  output  wire  [31:0]        dma_bst_size,
  output  wire  [31:0]        pll_ctl,
  output  wire  [31:0]        gpctl0,
  output  wire  [31:0]        gpctl1,
  output  wire  [31:0]        uartm_baud_ctl_reg,
  output  wire  [31:0]        uartm_ctl_reg,
  output  wire  [31:0]        sp_addr,
  output  wire  [31:0]        reset_addr,
  output  wire  [31:0]        nmi_addr,
  output  wire  [31:0]        fault_addr,
  output  wire  [31:0]        irq0_addr,
  output  wire  [31:0]        irq1_addr,
  output  wire  [31:0]        irq2_addr,
  output  wire  [31:0]        irq3_addr,
  output  wire  [31:0]        irq4_addr,
  output  wire  [31:0]        irq5_addr,
  output  wire  [31:0]        irq6_addr,
  output  wire  [31:0]        irq7_addr,
  output  wire  [31:0]        irq8_addr,
  output  wire  [31:0]        irq9_addr,
  output  wire  [31:0]        irq10_addr,
  output  wire  [31:0]        irq11_addr,
  output  wire  [31:0]        irq12_addr,
  output  wire  [31:0]        irq13_addr,
  output  wire  [31:0]        irq14_addr,
  output  wire  [31:0]        irq15_addr,
  output  wire  [31:0]        hclk_div,
  output  wire  [31:0]        timer_ctl,
  output  wire  [31:0]        timerA_cfg,
  output  wire  [31:0]        timerB_cfg,
  output  wire  [31:0]        timerC_cfg,
  output  wire  [31:0]        wdtimer_ctl,
  output  wire  [31:0]        wdtimer_cfg,
  output  wire  [31:0]        wdtimer_cfg2,
  output  wire  [31:0]        uarts_baud_ctl_reg,
  output  wire  [31:0]        uarts_ctl_reg,
  output  wire  [31:0]        uarts_tx_data_reg,
  input   wire  [31:0]        uarts_rx_data,
  output  wire  [31:0]        uarts_tx_send_reg,
  output  wire  [31:0]        spare0_reg,
  output  wire  [31:0]        spare1_reg,
  output  wire  [31:0]        spare2_reg,
  output  wire  [31:0]        signature_reg,
  output  wire  [31:0]        key_reg0,
  output  wire  [31:0]        key_reg1,
  output  wire  [31:0]        key_reg2,
  output  wire  [31:0]        key_reg3,
  output  wire  [31:0]        key_reg4,
  output  wire  [31:0]        key_reg5,
  output  wire  [31:0]        key_reg6,
  output  wire  [31:0]        key_reg7,
  output  wire [NBITS-1:0]    modulus,
  output  wire [NBITS-1:0]    invmodulus,
  output  wire [2*NBITS-1:0]  baret_mdk,
  output  wire [15:0]         polysize,
  output  wire                gate_utx_cf,
  output  wire                trig_ntt,
  output  wire                trig_intt,
  output  wire                trig_mul,
  output  wire                trig_add,
  output  wire                trig_sub,
  output  wire                trig_constmul,
  output  wire                trig_dma,
  output  wire                trig_sqr,
  output  wire                trig_nmul,
  output  wire                dp_en,
  output  wire                uarts_tx_ctl,
  output  wire                gate_mul_done,
  output  wire                cm0_sw_rstn,
  output  wire                test_en,
  input   wire                ntt_done,
  input   wire                intt_done,
  input   wire                pwise_mul_done,
  input   wire                add_done,
  input   wire                sub_done,
  input   wire                dma_done,
  input   wire                sqr_done,
  input   wire                nmul_done,
  output  wire                sel_pll,
  output  reg                 fhe_host_irq,
  output  reg                 fhe_busy,
  output  wire [7 :0]         base_addr_a,
  output  wire [7 :0]         base_addr_b,
  output  wire [7 :0]         base_addr_ra,
  output  wire [7 :0]         base_addr_t,
  output  wire [7 :0]         base_addr_rb,
  output  wire [7 :0]         mdmc_throt_cnt_ntt,
  output  wire [7 :0]         mdmc_throt_cnt_mul,
  output  wire [7 :0]         mdmc_throt_cnt_add,
  output  wire [255:0]        tkey,
  input   wire                mdmc_done,
  input   wire [31:0]         mdmc_data,
  output  wire                dma_cfifo_sel

);

//----------------------------------------------
//localparameter, genva and wire/reg declaration
//----------------------------------------------

localparam KEY_REG3_RST_VAL = 32'b10010000000100010011101001010110;
localparam KEY_REG2_RST_VAL = 32'b11101000100011111000011110001110;
localparam KEY_REG1_RST_VAL = 32'b10110011111110110110101111110101;
localparam KEY_REG0_RST_VAL = 32'b10010000001000011111010000011100;

  `include "gpcfg_addr_params.v"

  reg [31:0] haddr_lat;
  reg        valid_wr_lat;
  wire       dec_err;

  reg [3:0]  wbyte_en;
  reg [3:0]  wbyte_en_lat;

  reg  [31:0] fhe_ctl_p_reg;
  reg  [31:0] fhe_ctl_reg;
  reg  [31:0] fhe_ctl2_reg;
  reg  [31:0] fhe_ctl3_reg;

  reg  [NBITS -1:0]   fhe_n_reg;
  reg  [NBITS -1:0]   fhe_ninv_reg;
  reg  [2*NBITS -1:0] baret_mdk_reg;


  wire [NBITS   -1:0] fhe_pc_reg;


  reg                 fhe_busy_d; 

  reg   [16:0] busy_flag_set;
  wire  busy_flag_rel;

  wire [11:0]   fhe_log2ofn;
  wire          host_irq_clr;

  wire          tot_busy_cnt_clr;


  reg  [NBITS   -1:0] dbg_data; 
  reg [31:0] mdmc_data_lat;

  wire [2         :0] dbg_data_sel;


  wire          trig_ntt_cf;
  wire          trig_intt_cf;
  wire          trig_mul_cf;
  wire          trig_constmul_cf;
  wire          trig_dma_cf;
  wire          trig_sqr_cf;
  wire          trig_nmul_cf;
  wire          trig_add_cf;
  wire          trig_sub_cf;
  wire          dp_en_cf;
  wire [7 :0]  base_addr_a_cf;
  wire [7 :0]  base_addr_b_cf;
  wire [7 :0]  base_addr_r_cf;
 


reg[31:0] tot_busy_cnt;
reg       cntnue_tot_cnt;

 
  parameter MAX_RDATA = 1024;
  reg [31:0] rdata [0: MAX_RDATA];
//--------------------------
//Identify valid transaction
//--------------------------
  assign valid_wr = hsel &  hwrite & hready & ~dec_err;
  assign valid_rd = hsel & ~hwrite & hready & ~dec_err;

//--------------------------
//Capture write address
//--------------------------

  always @(posedge hclk or negedge hresetn) begin 
    if (hresetn == 1'b0) begin
      haddr_lat    <= 32'b0;
      wbyte_en_lat <= 3'b0;
    end
    else if (valid_wr == 1'b1) begin
      haddr_lat    <= haddr;
      wbyte_en_lat <= wbyte_en;
    end
  end

  always @(posedge hclk or negedge hresetn) begin 
    if (hresetn == 1'b0) begin
      valid_wr_lat <= 1'b0;
    end
    else begin
      valid_wr_lat <= valid_wr;
    end
  end


     //.OEN  (pad_ctl[i][0]),  //Output Enable
     //.REN  (pad_ctl[i][1]),  //RX     Enable
     //.P1   (pad_ctl[i][2]),  //pull settting Z, pull up, pull down Repeater
     //.P2   (pad_ctl[i][3]),  //pull settting
     //.E1   (pad_ctl[i][4]),  //drive strength 2,4,8,12ma
     //.E2   (pad_ctl[i][5]),  //drive strength
     //.SMT  (pad_ctl[i][6]),  //Schmitt trigger
     //.SR   (pad_ctl[i][7]),  //Slew Rate Control
     //.POS  (pad_ctl[i][8]),  //Power on state control, state of pad when VDD goes down
     //
                          //                      OEN       REN        Pull     Drive     Override
     //PAD03_CTL  UARTM_TX 0000_0000_0000_0001_0110, Enabled   Enabled     Pull Up,   4mA,     Disabled
     //PAD04_CTL  UARTM_RX 0000_0000_0000_0001_0111  Disabled  Enabled     Pull Up,   4ma,     Disabled
     //PAD05_CTL  UARTS_TX 0001_0000_0000_0001_0111  Disabled  Enabled     Pull Up,   4mA,     Enabled
     //PAD06_CTL  UARTS_RX 0001_0000_0000_0001_0111  Disabled  Enabled     Pull Up,   4mA,     Enabled
     //PAD07_CTL  GPIO0    0001_0000_0000_0001_1011  Disabled  Enabled     Pull Down, 4mA,     Enabled
     //PAD08_CTL  GPIO1    0001_0000_0000_0001_1011  Disabled  Enabled     Pull Down, 4mA,     Enabled
     //PAD09_CTL  GPIO2    0001_0000_0000_0001_1011  Disabled  Enabled     Pull Down, 4mA,     Enabled
     //PAD10_CTL  GPIO3    0001_0000_0000_0001_1011  Disabled  Enabled     Pull Down, 4mA,     Enabled
     //PAD11_CTL
     //PAD12_CTL
     //PAD13_CTL
     //PAD14_CTL
     //PAD15_CTL
     //PAD16_CTL
     //PAD17_CTL
     //PAD18_CTL
     //PAD19_CTL


//----------------------------
// Logic for getting read data
//----------------------------
gpcfg_rd_wr #( .RESET_VAL (32'h16), .CFG_ADDR (GPCFG0_ADDR)) u_cfg_pad03_ctl_reg_inst (
  .hclk    (hclk),          .hresetn (hresetn),
  .wr_en   (valid_wr_lat),  .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat),  .wr_addr (haddr_lat),
  .rd_addr (haddr),         .wdata   (hwdata),
  .wr_reg  (pad03_ctl_reg), .rdata   (rdata[0][31:0]));


gpcfg_rd_wr #( .RESET_VAL (32'h17), .CFG_ADDR (GPCFG1_ADDR)) u_cfg_pad04_ctl_reg_inst (
  .hclk    (hclk),          .hresetn (hresetn),
  .wr_en   (valid_wr_lat),  .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat),  .wr_addr (haddr_lat),
  .rd_addr (haddr),         .wdata   (hwdata),
  .wr_reg  (pad04_ctl_reg), .rdata   (rdata[1][31:0]));


gpcfg_rd_wr #( .RESET_VAL (32'h10_0017), .CFG_ADDR (GPCFG2_ADDR)) u_cfg_pad05_ctl_reg_inst (
  .hclk    (hclk),          .hresetn (hresetn),
  .wr_en   (valid_wr_lat),  .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat),  .wr_addr (haddr_lat),
  .rd_addr (haddr),         .wdata   (hwdata),
  .wr_reg  (pad05_ctl_reg), .rdata   (rdata[2][31:0]));


gpcfg_rd_wr #( .RESET_VAL (32'h10_0017), .CFG_ADDR (GPCFG3_ADDR)) u_cfg_pad06_ctl_reg_inst (
  .hclk    (hclk),          .hresetn (hresetn),
  .wr_en   (valid_wr_lat),  .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat),  .wr_addr (haddr_lat),
  .rd_addr (haddr),         .wdata   (hwdata),
  .wr_reg  (pad06_ctl_reg), .rdata   (rdata[3][31:0]));


gpcfg_rd_wr #( .RESET_VAL (32'h10_001B), .CFG_ADDR (GPCFG4_ADDR)) u_cfg_pad07_ctl_reg_inst (
  .hclk    (hclk),          .hresetn (hresetn),
  .wr_en   (valid_wr_lat),  .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat),  .wr_addr (haddr_lat),
  .rd_addr (haddr),         .wdata   (hwdata),
  .wr_reg  (pad07_ctl_reg), .rdata   (rdata[4][31:0]));


gpcfg_rd_wr #( .RESET_VAL (32'h10_001B), .CFG_ADDR (GPCFG5_ADDR)) u_cfg_pad08_ctl_reg_inst (
  .hclk    (hclk),          .hresetn (hresetn),
  .wr_en   (valid_wr_lat),  .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat),  .wr_addr (haddr_lat),
  .rd_addr (haddr),         .wdata   (hwdata),
  .wr_reg  (pad08_ctl_reg), .rdata   (rdata[5][31:0]));


gpcfg_rd_wr #( .RESET_VAL (32'h10_001B), .CFG_ADDR (GPCFG6_ADDR)) u_cfg_pad09_ctl_reg_inst (
  .hclk    (hclk),          .hresetn (hresetn),
  .wr_en   (valid_wr_lat),  .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat),  .wr_addr (haddr_lat),
  .rd_addr (haddr),         .wdata   (hwdata),
  .wr_reg  (pad09_ctl_reg), .rdata   (rdata[6][31:0]));


gpcfg_rd_wr #( .RESET_VAL (32'h10_001B), .CFG_ADDR (GPCFG7_ADDR)) u_cfg_pad10_ctl_reg_inst (
  .hclk    (hclk),           .hresetn (hresetn),
  .wr_en   (valid_wr_lat),   .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat),   .wr_addr (haddr_lat),
  .rd_addr (haddr),          .wdata   (hwdata),
  .wr_reg  (pad10_ctl_reg), .rdata    (rdata[7][31:0]));


gpcfg_rd_wr #( .RESET_VAL (32'h10_001B), .CFG_ADDR (GPCFG8_ADDR)) u_cfg_pad11_ctl_reg_inst (
  .hclk    (hclk),          .hresetn (hresetn),
  .wr_en   (valid_wr_lat),  .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat),  .wr_addr (haddr_lat),
  .rd_addr (haddr),         .wdata   (hwdata),
  .wr_reg  (pad11_ctl_reg), .rdata   (rdata[8][31:0]));


gpcfg_rd_wr #( .RESET_VAL (32'h10_001B), .CFG_ADDR (GPCFG9_ADDR)) u_cfg_pad12_ctl_reg_inst (
  .hclk    (hclk),          .hresetn (hresetn),
  .wr_en   (valid_wr_lat),  .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat),  .wr_addr (haddr_lat),
  .rd_addr (haddr),          .wdata  (hwdata),
  .wr_reg  (pad12_ctl_reg), .rdata   (rdata[9][31:0]));


gpcfg_rd_wr #( .RESET_VAL (32'h10_001B), .CFG_ADDR (GPCFG10_ADDR)) u_cfg_pad13_ctl_reg_inst (
  .hclk    (hclk),           .hresetn (hresetn),
  .wr_en   (valid_wr_lat),   .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat),   .wr_addr (haddr_lat),
  .rd_addr (haddr),          .wdata   (hwdata),
  .wr_reg  (pad13_ctl_reg),  .rdata   (rdata[10][31:0]));


gpcfg_rd_wr #( .RESET_VAL (32'h10_001B), .CFG_ADDR (GPCFG11_ADDR)) u_cfg_pad14_ctl_reg_inst (
  .hclk    (hclk),          .hresetn (hresetn),
  .wr_en   (valid_wr_lat),  .rd_en (valid_rd),
  .byte_en (wbyte_en_lat),  .wr_addr (haddr_lat),
  .rd_addr (haddr),   .wdata (hwdata),
  .wr_reg  (pad14_ctl_reg), .rdata (rdata[11][31:0]));


`ifdef FPGA_SYNTH
gpcfg_rd_wr #( .RESET_VAL (32'h17), .CFG_ADDR (GPCFG12_ADDR)) u_cfg_pad15_ctl_reg_inst (
`else
gpcfg_rd_wr #( .RESET_VAL (32'h10_001B), .CFG_ADDR (GPCFG12_ADDR)) u_cfg_pad15_ctl_reg_inst (
`endif
  .hclk    (hclk),          .hresetn (hresetn),
  .wr_en   (valid_wr_lat),  .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat),  .wr_addr (haddr_lat),
  .rd_addr (haddr),         .wdata   (hwdata),
  .wr_reg  (pad15_ctl_reg), .rdata   (rdata[12][31:0]));


`ifdef FPGA_SYNTH
gpcfg_rd_wr #( .RESET_VAL (32'h17), .CFG_ADDR (GPCFG13_ADDR)) u_cfg_pad16_ctl_reg_inst (
`else
gpcfg_rd_wr #( .RESET_VAL (32'h10_001B), .CFG_ADDR (GPCFG13_ADDR)) u_cfg_pad16_ctl_reg_inst (
`endif
  .hclk    (hclk),          .hresetn (hresetn),
  .wr_en   (valid_wr_lat),  .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat),  .wr_addr (haddr_lat),
  .rd_addr (haddr),         .wdata   (hwdata),
  .wr_reg  (pad16_ctl_reg), .rdata   (rdata[13][31:0]));


gpcfg_rd_wr #( .RESET_VAL (32'h17), .CFG_ADDR (GPCFG14_ADDR)) u_cfg_pad17_ctl_reg_inst (
  .hclk    (hclk),          .hresetn (hresetn),
  .wr_en   (valid_wr_lat),  .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat),  .wr_addr (haddr_lat),
  .rd_addr (haddr),         .wdata   (hwdata),
  .wr_reg  (pad17_ctl_reg), .rdata   (rdata[14][31:0]));


gpcfg_rd_wr #( .RESET_VAL (32'h16), .CFG_ADDR (GPCFG15_ADDR)) u_cfg_pad18_ctl_reg_inst (
  .hclk    (hclk),          .hresetn (hresetn),
  .wr_en   (valid_wr_lat),  .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat),  .wr_addr (haddr_lat),
  .rd_addr (haddr),          .wdata  (hwdata),
  .wr_reg  (pad18_ctl_reg), .rdata   (rdata[15][31:0]));


gpcfg_rd_wr #( .RESET_VAL (32'h10_001B), .CFG_ADDR (GPCFG16_ADDR)) u_cfg_pad19_ctl_reg_inst (
  .hclk    (hclk),          .hresetn (hresetn),
  .wr_en   (valid_wr_lat),  .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat),  .wr_addr (haddr_lat),
  .rd_addr (haddr),         .wdata   (hwdata),
  .wr_reg  (pad19_ctl_reg), .rdata   (rdata[16][31:0]));


`ifdef FPGA_SYNTH
gpcfg_rd_wr #( .RESET_VAL (32'd40), .CFG_ADDR (GPCFG17_ADDR)) u_cfg_uartm_baud_ctl_reg_inst (
`else
gpcfg_rd_wr #( .RESET_VAL (32'd2500), .CFG_ADDR (GPCFG17_ADDR)) u_cfg_uartm_baud_ctl_reg_inst (
`endif
  .hclk    (hclk),               .hresetn (hresetn),
  .wr_en   (valid_wr_lat),       .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat),       .wr_addr (haddr_lat),
  .rd_addr (haddr),              .wdata   (hwdata),
  .wr_reg  (uartm_baud_ctl_reg), .rdata   (rdata[17][31:0]));


gpcfg_rd_wr #( .RESET_VAL (32'h0), .CFG_ADDR (GPCFG18_ADDR)) u_cfg_uartm_ctl_reg_inst (
  .hclk    (hclk),          .hresetn (hresetn),
  .wr_en   (valid_wr_lat),  .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat),  .wr_addr (haddr_lat),
  .rd_addr (haddr),         .wdata   (hwdata),
  .wr_reg  (uartm_ctl_reg), .rdata   (rdata[18][31:0]));

gpcfg_rd_wr #( .RESET_VAL (32'h20001400), .CFG_ADDR (GPCFG19_ADDR)) u_cfg_sp_addr_reg_inst (
  .hclk    (hclk),          .hresetn (hresetn),
  .wr_en   (valid_wr_lat),  .rd_en (valid_rd),
  .byte_en (wbyte_en_lat),  .wr_addr (haddr_lat),
  .rd_addr (haddr),   .wdata (hwdata),
  .wr_reg  (sp_addr), .rdata (rdata[19][31:0]));

gpcfg_rd_wr #( .RESET_VAL (32'h20000E31), .CFG_ADDR (GPCFG20_ADDR)) u_cfg_reset_addr_reg_inst (
  .hclk    (hclk),          .hresetn (hresetn),
  .wr_en   (valid_wr_lat),  .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat),  .wr_addr (haddr_lat),
  .rd_addr (haddr),         .wdata   (hwdata),
  .wr_reg  (reset_addr),    .rdata   (rdata[20][31:0]));

gpcfg_rd_wr #( .RESET_VAL (32'h20000BFD), .CFG_ADDR (GPCFG21_ADDR)) u_cfg_nmi_addr_reg_inst (
  .hclk    (hclk),          .hresetn (hresetn),
  .wr_en   (valid_wr_lat),  .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat),  .wr_addr (haddr_lat),
  .rd_addr (haddr),         .wdata   (hwdata),
  .wr_reg  (nmi_addr),      .rdata   (rdata[21][31:0]));

gpcfg_rd_wr #( .RESET_VAL (32'h20000BF9), .CFG_ADDR (GPCFG22_ADDR)) u_cfg_fault_addr_reg_inst (
  .hclk    (hclk),          .hresetn (hresetn),
  .wr_en   (valid_wr_lat),  .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat),  .wr_addr (haddr_lat),
  .rd_addr (haddr),         .wdata   (hwdata),
  .wr_reg  (fault_addr),    .rdata   (rdata[22][31:0]));

gpcfg_rd_wr #( .RESET_VAL (32'h20000C21), .CFG_ADDR (GPCFG23_ADDR)) u_cfg_irq0_addr_reg_inst (
  .hclk    (hclk),          .hresetn (hresetn),
  .wr_en   (valid_wr_lat),  .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat),  .wr_addr (haddr_lat),
  .rd_addr (haddr),         .wdata   (hwdata),
  .wr_reg  (irq0_addr),     .rdata   (rdata[23][31:0]));

gpcfg_rd_wr #( .RESET_VAL (32'h20000C25), .CFG_ADDR (GPCFG24_ADDR)) u_cfg_irq1_addr_reg_inst (
  .hclk    (hclk),          .hresetn (hresetn),
  .wr_en   (valid_wr_lat),  .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat),  .wr_addr (haddr_lat),
  .rd_addr (haddr),         .wdata   (hwdata),
  .wr_reg  (irq1_addr),     .rdata   (rdata[24][31:0]));

gpcfg_rd_wr #( .RESET_VAL (32'h20000CE1), .CFG_ADDR (GPCFG25_ADDR)) u_cfg_irq2_addr_reg_inst (
  .hclk    (hclk),          .hresetn (hresetn),
  .wr_en   (valid_wr_lat),  .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat),  .wr_addr (haddr_lat),
  .rd_addr (haddr),         .wdata   (hwdata),
  .wr_reg  (irq2_addr),     .rdata   (rdata[25][31:0]));

gpcfg_rd_wr #( .RESET_VAL (32'h20000CEF), .CFG_ADDR (GPCFG26_ADDR)) u_cfg_irq3_addr_reg_inst (
  .hclk    (hclk),          .hresetn (hresetn),
  .wr_en   (valid_wr_lat),  .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat),  .wr_addr (haddr_lat),
  .rd_addr (haddr),         .wdata   (hwdata),
  .wr_reg  (irq3_addr),     .rdata   (rdata[26][31:0]));

gpcfg_rd_wr #( .RESET_VAL (32'h0), .CFG_ADDR (GPCFG27_ADDR)) u_cfg_timer_ctl_reg_inst (
  .hclk    (hclk),          .hresetn (hresetn),
  .wr_en   (valid_wr_lat),  .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat),  .wr_addr (haddr_lat),
  .rd_addr (haddr),         .wdata   (hwdata),
  .wr_reg  (timer_ctl),     .rdata   (rdata[27][31:0]));

gpcfg_rd_wr #( .RESET_VAL (32'h0), .CFG_ADDR (GPCFG28_ADDR)) u_cfg_timerA_cfg_reg_inst (
  .hclk    (hclk),          .hresetn (hresetn),
  .wr_en   (valid_wr_lat),  .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat),  .wr_addr (haddr_lat),
  .rd_addr (haddr),         .wdata   (hwdata),
  .wr_reg  (timerA_cfg),    .rdata   (rdata[28][31:0]));

gpcfg_rd_wr #( .RESET_VAL (32'h0), .CFG_ADDR (GPCFG29_ADDR)) u_cfg_timerB_cfg_reg_inst (
  .hclk    (hclk),         .hresetn (hresetn),
  .wr_en   (valid_wr_lat), .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat), .wr_addr (haddr_lat),
  .rd_addr (haddr),        .wdata   (hwdata),
  .wr_reg  (timerB_cfg),   .rdata   (rdata[29][31:0]));

gpcfg_rd_wr #( .RESET_VAL (32'h0), .CFG_ADDR (GPCFG30_ADDR)) u_cfg_timerC_cfg_reg_inst (
  .hclk    (hclk),          .hresetn (hresetn),
  .wr_en   (valid_wr_lat),  .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat),  .wr_addr (haddr_lat),
  .rd_addr (haddr),         .wdata   (hwdata),
  .wr_reg  (timerC_cfg),    .rdata   (rdata[30][31:0]));

gpcfg_rd_wr #( .RESET_VAL (32'h0), .CFG_ADDR (GPCFG31_ADDR)) u_cfg_wdtimer_ctl_reg_inst (
  .hclk    (hclk),         .hresetn (hresetn),
  .wr_en   (valid_wr_lat), .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat), .wr_addr (haddr_lat),
  .rd_addr (haddr),        .wdata   (hwdata),
  .wr_reg  (wdtimer_ctl),  .rdata   (rdata[31][31:0]));

gpcfg_rd_wr #( .RESET_VAL (32'h0), .CFG_ADDR (GPCFG32_ADDR)) u_cfg_wdtimer_cfg_reg_inst (
  .hclk    (hclk),         .hresetn (hresetn),
  .wr_en   (valid_wr_lat), .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat), .wr_addr (haddr_lat),
  .rd_addr (haddr),        .wdata   (hwdata),
  .wr_reg  (wdtimer_cfg),  .rdata   (rdata[32][31:0]));

gpcfg_rd_wr #( .RESET_VAL (32'h0), .CFG_ADDR (GPCFG33_ADDR)) u_cfg_wdt_wdt_wdtimer_cfg2_reg_inst (
  .hclk    (hclk),         .hresetn (hresetn),
  .wr_en   (valid_wr_lat), .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat), .wr_addr (haddr_lat),
  .rd_addr (haddr),        .wdata   (hwdata),
  .wr_reg  (wdtimer_cfg2), .rdata   (rdata[33][31:0]));

gpcfg_rd_wr #( .RESET_VAL (32'h9C4), .CFG_ADDR (GPCFG34_ADDR)) u_cfg_uarts_baud_ctl_reg_inst (
  .hclk    (hclk),               .hresetn (hresetn),
  .wr_en   (valid_wr_lat),       .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat),       .wr_addr (haddr_lat),
  .rd_addr (haddr),              .wdata   (hwdata),
  .wr_reg  (uarts_baud_ctl_reg), .rdata   (rdata[34][31:0]));


gpcfg_rd_wr #( .RESET_VAL (32'h9C4), .CFG_ADDR (GPCFG35_ADDR)) u_cfg_uarts_ctl_reg_inst (
  .hclk    (hclk),          .hresetn (hresetn),
  .wr_en   (valid_wr_lat),  .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat),  .wr_addr (haddr_lat),
  .rd_addr (haddr),         .wdata   (hwdata),
  .wr_reg  (uarts_ctl_reg), .rdata   (rdata[35][31:0]));


gpcfg_rd_wr #( .RESET_VAL (32'h0), .CFG_ADDR (GPCFG36_ADDR)) u_cfg_uarts_tx_data_reg_inst (
  .hclk    (hclk),              .hresetn (hresetn),
  .wr_en   (valid_wr_lat),      .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat),      .wr_addr (haddr_lat),
  .rd_addr (haddr),             .wdata   (hwdata),
  .wr_reg  (uarts_tx_data_reg), .rdata   (rdata[36][31:0]));

gpcfg_rd #(.CFG_ADDR (GPCFG37_ADDR)) u_gpcfg_rd_uarts_rx_data_inst  (
  .rd_en     (valid_rd),
  .rd_addr   (haddr),
  .wdata     (uarts_rx_data),
  .rdata     (rdata[37][31:0])
);

gpcfg_rd_wr_p #( .RESET_VAL (32'h0), .CFG_ADDR (GPCFG38_ADDR)) u_cfg_uarts_tx_send_reg_inst (
  .hclk    (hclk),              .hresetn (hresetn),
  .wr_en   (valid_wr_lat),      .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat),      .wr_addr (haddr_lat),
  .rd_addr (haddr),             .wdata   (hwdata),
  .wr_reg  (uarts_tx_send_reg), .rdata   (rdata[38][31:0]));


gpcfg_rd_wr #( .RESET_VAL (32'h0), .CFG_ADDR (GPCFG39_ADDR)) u_cfg_spare0_reg_inst (
  .hclk    (hclk),         .hresetn (hresetn),
  .wr_en   (valid_wr_lat), .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat), .wr_addr (haddr_lat),
  .rd_addr (haddr),        .wdata   (hwdata),
  .wr_reg  (spare0_reg),   .rdata   (rdata[39][31:0]));


gpcfg_rd_wr #( .RESET_VAL (32'h0), .CFG_ADDR (GPCFG40_ADDR)) u_cfg_spare1_reg_inst (
  .hclk    (hclk),         .hresetn (hresetn),
  .wr_en   (valid_wr_lat), .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat), .wr_addr (haddr_lat),
  .rd_addr (haddr),        .wdata   (hwdata),
  .wr_reg  (spare1_reg),   .rdata   (rdata[40][31:0]));


gpcfg_rd_wr #( .RESET_VAL (32'hFFFF_FFFF), .CFG_ADDR (GPCFG41_ADDR)) u_cfg_spare2_reg_inst (
  .hclk    (hclk),         .hresetn (hresetn),
  .wr_en   (valid_wr_lat), .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat), .wr_addr (haddr_lat),
  .rd_addr (haddr),        .wdata   (hwdata),
  .wr_reg  (spare2_reg),   .rdata   (rdata[41][31:0]));


gpcfg_rd_wr #( .RESET_VAL (32'h2423_2121), .CFG_ADDR (GPCFG42_ADDR)) u_cfg_fhe_ctl2_reg_inst (
  .hclk    (hclk),          .hresetn (hresetn),
  .wr_en   (valid_wr_lat),  .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat),  .wr_addr (haddr_lat),
  .rd_addr (haddr),         .wdata   (hwdata),
  .wr_reg  (fhe_ctl2_reg),  .rdata   (rdata[42][31:0]));

gpcfg_rd_wr #( .RESET_VAL (KEY_REG0_RST_VAL), .CFG_ADDR (GPCFG43_ADDR)) u_cfg_key_reg0_reg_inst (
  .hclk    (hclk),         .hresetn (hresetn),
  .wr_en   (valid_wr_lat), .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat), .wr_addr (haddr_lat),
  .rd_addr (haddr),        .wdata   (hwdata),
  .wr_reg  (key_reg0),     .rdata   (rdata[43][31:0]));

gpcfg_rd_wr #( .RESET_VAL (KEY_REG1_RST_VAL), .CFG_ADDR (GPCFG44_ADDR)) u_cfg_key_reg1_reg_inst (
  .hclk    (hclk),         .hresetn (hresetn),
  .wr_en   (valid_wr_lat), .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat), .wr_addr (haddr_lat),
  .rd_addr (haddr),        .wdata   (hwdata),
  .wr_reg  (key_reg1),     .rdata   (rdata[44][31:0]));

gpcfg_rd_wr #( .RESET_VAL (KEY_REG2_RST_VAL), .CFG_ADDR (GPCFG45_ADDR)) u_cfg_key_reg2_reg_inst (
  .hclk    (hclk),         .hresetn (hresetn),
  .wr_en   (valid_wr_lat), .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat), .wr_addr (haddr_lat),
  .rd_addr (haddr),        .wdata   (hwdata),
  .wr_reg  (key_reg2),     .rdata   (rdata[45][31:0]));

gpcfg_rd_wr #( .RESET_VAL (KEY_REG3_RST_VAL), .CFG_ADDR (GPCFG46_ADDR)) u_cfg_key_reg3_reg_inst (
  .hclk    (hclk),         .hresetn (hresetn),
  .wr_en   (valid_wr_lat), .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat), .wr_addr (haddr_lat),
  .rd_addr (haddr),        .wdata   (hwdata),
  .wr_reg  (key_reg3),     .rdata   (rdata[46][31:0]));

gpcfg_rd_wr #( .RESET_VAL (32'h0), .CFG_ADDR (GPCFG47_ADDR)) u_cfg_key_reg4_reg_inst (
  .hclk    (hclk),         .hresetn (hresetn),
  .wr_en   (valid_wr_lat), .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat), .wr_addr (haddr_lat),
  .rd_addr (haddr),        .wdata   (hwdata),
  .wr_reg  (key_reg4),     .rdata   (rdata[47][31:0]));

gpcfg_rd_wr #( .RESET_VAL (32'h0), .CFG_ADDR (GPCFG48_ADDR)) u_cfg_key_reg5_reg_inst (
  .hclk    (hclk),         .hresetn (hresetn),
  .wr_en   (valid_wr_lat), .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat), .wr_addr (haddr_lat),
  .rd_addr (haddr),        .wdata   (hwdata),
  .wr_reg  (key_reg5),     .rdata   (rdata[48][31:0]));

gpcfg_rd_wr #( .RESET_VAL (32'h0), .CFG_ADDR (GPCFG49_ADDR)) u_cfg_key_reg6_reg_inst (
  .hclk    (hclk),         .hresetn (hresetn),
  .wr_en   (valid_wr_lat), .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat), .wr_addr (haddr_lat),
  .rd_addr (haddr),        .wdata   (hwdata),
  .wr_reg  (key_reg6),     .rdata   (rdata[49][31:0]));

gpcfg_rd_wr #( .RESET_VAL (32'h0), .CFG_ADDR (GPCFG50_ADDR)) u_cfg_key_reg7_reg_inst (
  .hclk    (hclk),         .hresetn (hresetn),
  .wr_en   (valid_wr_lat), .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat), .wr_addr (haddr_lat),
  .rd_addr (haddr),        .wdata   (hwdata),
  .wr_reg  (key_reg7),     .rdata   (rdata[50][31:0]));


//genvar j;
//generate
//  for (j = 51; j < 51; j = j + 1) begin
//    assign rdata[i][31:0] = 32'b0;
//  end
//endgenerate


gpcfg_rd_wr #( .RESET_VAL (32'h0CC5_0302), .CFG_ADDR (GPCFG51_ADDR)) u_cfg_signature_reg_inst (
  .hclk    (hclk),          .hresetn (hresetn),
  .wr_en   (1'b0),          .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat),  .wr_addr (haddr_lat),
  .rd_addr (haddr),         .wdata   (hwdata),
  .wr_reg  (signature_reg), .rdata  (rdata[51][31:0]));

gpcfg_rd_wr #( .RESET_VAL (32'h20000CFD), .CFG_ADDR (GPCFG52_ADDR)) u_cfg_irq4_addr_reg_inst (
  .hclk    (hclk),         .hresetn (hresetn),
  .wr_en   (valid_wr_lat), .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat), .wr_addr (haddr_lat),
  .rd_addr (haddr),        .wdata   (hwdata),
  .wr_reg  (irq4_addr),    .rdata   (rdata[52][31:0]));

gpcfg_rd_wr #( .RESET_VAL (32'h20000D07), .CFG_ADDR (GPCFG53_ADDR)) u_cfg_irq5_addr_reg_inst (
  .hclk    (hclk),         .hresetn (hresetn),
  .wr_en   (valid_wr_lat), .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat), .wr_addr (haddr_lat),
  .rd_addr (haddr),        .wdata   (hwdata),
  .wr_reg  (irq5_addr),    .rdata   (rdata[53][31:0]));

gpcfg_rd_wr #( .RESET_VAL (32'h20000D11), .CFG_ADDR (GPCFG54_ADDR)) u_cfg_irq6_addr_reg_inst (
  .hclk    (hclk),         .hresetn (hresetn),
  .wr_en   (valid_wr_lat), .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat), .wr_addr (haddr_lat),
  .rd_addr (haddr),        .wdata   (hwdata),
  .wr_reg  (irq6_addr),    .rdata   (rdata[54][31:0]));

gpcfg_rd_wr #( .RESET_VAL (32'h20000D19), .CFG_ADDR (GPCFG55_ADDR)) u_cfg_irq7_addr_reg_inst (
  .hclk    (hclk),         .hresetn (hresetn),
  .wr_en   (valid_wr_lat), .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat), .wr_addr (haddr_lat),
  .rd_addr (haddr),        .wdata   (hwdata),
  .wr_reg  (irq7_addr),    .rdata   (rdata[55][31:0]));

gpcfg_rd_wr #( .RESET_VAL (32'h20000D21), .CFG_ADDR (GPCFG56_ADDR)) u_cfg_irq8_addr_reg_inst (
  .hclk    (hclk),         .hresetn (hresetn),
  .wr_en   (valid_wr_lat), .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat), .wr_addr (haddr_lat),
  .rd_addr (haddr),        .wdata   (hwdata),
  .wr_reg  (irq8_addr),    .rdata   (rdata[56][31:0]));

gpcfg_rd_wr #( .RESET_VAL (32'h20000D29), .CFG_ADDR (GPCFG57_ADDR)) u_cfg_irq9_addr_reg_inst (
  .hclk    (hclk),         .hresetn (hresetn),
  .wr_en   (valid_wr_lat), .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat), .wr_addr (haddr_lat),
  .rd_addr (haddr),        .wdata   (hwdata),
  .wr_reg  (irq9_addr),    .rdata   (rdata[57][31:0]));

gpcfg_rd_wr #( .RESET_VAL (32'h20000D31), .CFG_ADDR (GPCFG58_ADDR)) u_cfg_irq10_addr_reg_inst (
  .hclk    (hclk),         .hresetn (hresetn),
  .wr_en   (valid_wr_lat), .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat), .wr_addr (haddr_lat),
  .rd_addr (haddr),        .wdata   (hwdata),
  .wr_reg  (irq10_addr),   .rdata   (rdata[58][31:0]));

gpcfg_rd_wr #( .RESET_VAL (32'h20000D39), .CFG_ADDR (GPCFG59_ADDR)) u_cfg_irq11_addr_reg_inst (
  .hclk    (hclk),         .hresetn (hresetn),
  .wr_en   (valid_wr_lat), .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat), .wr_addr (haddr_lat),
  .rd_addr (haddr),        .wdata   (hwdata),
  .wr_reg  (irq11_addr),   .rdata   (rdata[59][31:0]));

gpcfg_rd_wr #( .RESET_VAL (32'h20000D41), .CFG_ADDR (GPCFG60_ADDR)) u_cfg_irq12_addr_reg_inst (
  .hclk    (hclk),          .hresetn (hresetn),
  .wr_en   (valid_wr_lat), .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat),  .wr_addr (haddr_lat),
  .rd_addr (haddr),         .wdata   (hwdata),
  .wr_reg  (irq12_addr),    .rdata   (rdata[60][31:0]));

gpcfg_rd_wr #( .RESET_VAL (32'h20000D49), .CFG_ADDR (GPCFG61_ADDR)) u_cfg_irq13_addr_reg_inst (
  .hclk    (hclk),         .hresetn (hresetn),
  .wr_en   (valid_wr_lat), .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat), .wr_addr (haddr_lat),
  .rd_addr (haddr),        .wdata   (hwdata),
  .wr_reg  (irq13_addr),   .rdata   (rdata[61][31:0]));

gpcfg_rd_wr #( .RESET_VAL (32'h20000D51), .CFG_ADDR (GPCFG62_ADDR)) u_cfg_irq14_addr_reg_inst (
  .hclk    (hclk),         .hresetn (hresetn),
  .wr_en   (valid_wr_lat), .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat), .wr_addr (haddr_lat),
  .rd_addr (haddr),        .wdata   (hwdata),
  .wr_reg  (irq14_addr),   .rdata   (rdata[62][31:0]));

gpcfg_rd_wr #( .RESET_VAL (32'h20000D59), .CFG_ADDR (GPCFG63_ADDR)) u_cfg_irq15_addr_reg_inst (
  .hclk    (hclk),         .hresetn (hresetn),
  .wr_en   (valid_wr_lat), .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat), .wr_addr (haddr_lat),
  .rd_addr (haddr),        .wdata   (hwdata),
  .wr_reg  (irq15_addr),   .rdata   (rdata[63][31:0]));

gpcfg_rd_wr #( .RESET_VAL (32'h000A000A), .CFG_ADDR (GPCFG66_ADDR)) u_cfg_misc1_div_reg_inst (
  .hclk    (hclk),         .hresetn (hresetn),
  .wr_en   (valid_wr_lat), .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat), .wr_addr (haddr_lat),
  .rd_addr (haddr),        .wdata   (hwdata),
  .wr_reg  (hclk_div),     .rdata   (rdata[64][31:0]));

//Cryptoleq Registers Starts here
gpcfg_rd_wr_p #( .RESET_VAL (32'h0), .CFG_ADDR (GPCFG_FHECTLP_ADDR)) u_cfg_fhe_ctl_p_reg_inst (
  .hclk    (hclk),           .hresetn (hresetn),
  .wr_en   (valid_wr_lat),   .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat),   .wr_addr (haddr_lat),
  .rd_addr (haddr),          .wdata   (hwdata),
  .wr_reg  (fhe_ctl_p_reg), .rdata   (rdata[65][31:0]));


gpcfg_rd_wr #( .RESET_VAL (32'h0006_1000), .CFG_ADDR (GPCFG_FHECTL_ADDR)) u_cfg_fhe_ctl_inst (
  .hclk    (hclk),         .hresetn (hresetn),
  .wr_en   (valid_wr_lat), .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat), .wr_addr (haddr_lat),
  .rd_addr (haddr),        .wdata   (hwdata),
  .wr_reg  (fhe_ctl_reg),  .rdata    (rdata[66][31:0]));

gpcfg_rd #(.CFG_ADDR (GPCFG_FHESTATUS_ADDR)) u_gpcfg_rd_fhe_status_inst  (
  .rd_en     (valid_rd),
  .rd_addr   (haddr),
  .wdata     ({31'b1, fhe_busy} ),
  .rdata     (rdata[67][31:0])
);

gpcfg_rd_wr #( .RESET_VAL (32'h0000_0101), .CFG_ADDR (GPCFG_FHECTL3_ADDR)) u_cfg_fhe_ctl3_inst ( // NMUL = 64
//gpcfg_rd_wr #( .RESET_VAL (32'h0000_2808), .CFG_ADDR (GPCFG_FHECTL3_ADDR)) u_cfg_fhe_ctl3_inst ( // NMUL = 32
//gpcfg_rd_wr #( .RESET_VAL (32'h0000_384A), .CFG_ADDR (GPCFG_FHECTL3_ADDR)) u_cfg_fhe_ctl3_inst ( // NMUL = 16
  .hclk    (hclk),         .hresetn (hresetn),
  .wr_en   (valid_wr_lat), .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat), .wr_addr (haddr_lat),
  .rd_addr (haddr),        .wdata   (hwdata),
  .wr_reg  (fhe_ctl3_reg), .rdata   (rdata[68][31:0]));


gpcfg_rd_wr #( .RESET_VAL (32'h10_001B), .CFG_ADDR (GPCFG_PADTESTOUT_ADDR)) u_cfg_pad20_ctl_reg_inst (
  .hclk    (hclk),          .hresetn (hresetn),
  .wr_en   (valid_wr_lat),  .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat),  .wr_addr (haddr_lat),
  .rd_addr (haddr),         .wdata   (hwdata),
  .wr_reg  (pad20_ctl_reg), .rdata   (rdata[69][31:0]));

gpcfg_rd_wr #( .RESET_VAL (32'h10_001B), .CFG_ADDR (GPCFG_PADTESTIN_ADDR)) u_cfg_pad21_ctl_reg_inst (
  .hclk    (hclk),          .hresetn (hresetn),
  .wr_en   (valid_wr_lat),  .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat),  .wr_addr (haddr_lat),
  .rd_addr (haddr),         .wdata   (hwdata),
  .wr_reg  (pad21_ctl_reg), .rdata   (rdata[70][31:0]));

assign pad22_ctl_reg = pad21_ctl_reg;
assign pad23_ctl_reg = pad21_ctl_reg;
assign pad24_ctl_reg = pad21_ctl_reg;
assign pad25_ctl_reg = pad21_ctl_reg;

command_fifo #( .RESET_VAL (32'h0), .CFG_ADDR (GPCFG_COMMNDFIFO_ADDR)) u_command_fifo_inst (
  .hclk    (hclk),          .hresetn (hresetn),
  .wr_en   (valid_wr_lat),  .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat),  .wr_addr (haddr_lat),
  .rd_addr (haddr),         .wdata   (hwdata),
  .wr_reg  (), .rdata   (rdata[71][31:0]),
  .mdmc_data     (mdmc_data_lat),
  .mdmc_done     (mdmc_done),
  .gate_utx      (gate_utx_cf),
  .dp_en         (dp_en_cf),
  .trig_ntt      (trig_ntt_cf),
  .trig_intt     (trig_intt_cf),
  .trig_mul      (trig_mul_cf),
  .trig_constmul (trig_constmul_cf),
  .trig_add      (trig_add_cf),
  .trig_sub      (trig_sub_cf),
  .trig_dma      (trig_dma_cf),
  .trig_sqr      (trig_sqr_cf),
  .trig_nmul     (trig_nmul_cf),
  .base_addr_a   (base_addr_a_cf),
  .base_addr_b   (base_addr_b_cf),
  .base_addr_r   (base_addr_r_cf)
);

gpcfg_rd_wr #( .RESET_VAL (32'h2400_0000), .CFG_ADDR (GPCFG_DMASRC_ADDR)) u_cfg_dma_src_addr_reg_inst (
  .hclk    (hclk),          .hresetn (hresetn),
  .wr_en   (valid_wr_lat),  .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat),  .wr_addr (haddr_lat),
  .rd_addr (haddr),         .wdata   (hwdata),
  .wr_reg  (dma_src_addr),  .rdata   (rdata[72][31:0]));


gpcfg_rd_wr #( .RESET_VAL (32'h2200_0000), .CFG_ADDR (GPCFG_DMADST_ADDR)) u_cfg_dma_dst_addr_reg_inst (
  .hclk    (hclk),          .hresetn (hresetn),
  .wr_en   (valid_wr_lat),  .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat),  .wr_addr (haddr_lat),
  .rd_addr (haddr),         .wdata   (hwdata),
  .wr_reg  (dma_dst_addr),  .rdata   (rdata[73][31:0]));


gpcfg_rd_wr #( .RESET_VAL (32'h1010_0010), .CFG_ADDR (GPCFG_DMACTL_ADDR)) u_cfg_dma_ctrl_reg_inst (
  .hclk    (hclk),          .hresetn (hresetn),
  .wr_en   (valid_wr_lat),  .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat),  .wr_addr (haddr_lat),
  .rd_addr (haddr),         .wdata   (hwdata),
  .wr_reg  (dma_bst_size),  .rdata   (rdata[74][31:0]));


gpcfg_rd_wr #( .RESET_VAL (32'h0008_4010), .CFG_ADDR (GPCFG_PLLCTL_ADDR)) u_cfg_pllctl_reg_inst (
  .hclk    (hclk),          .hresetn (hresetn),
  .wr_en   (valid_wr_lat),  .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat),  .wr_addr (haddr_lat),
  .rd_addr (haddr),         .wdata   (hwdata),
  .wr_reg  (pll_ctl),       .rdata   (rdata[75][31:0]));


gpcfg_rd_wr #( .RESET_VAL (32'h2200_0000), .CFG_ADDR (GPCFG_DMADST_ADDR)) u_cfg_gpctl0_addr_reg_inst (
  .hclk    (hclk),          .hresetn (hresetn),
  .wr_en   (valid_wr_lat),  .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat),  .wr_addr (haddr_lat),
  .rd_addr (haddr),         .wdata   (hwdata),
  .wr_reg  (gpctl0),  .rdata   (rdata[76][31:0]));


gpcfg_rd_wr #( .RESET_VAL (32'h0010_0010), .CFG_ADDR (GPCFG_DMACTL_ADDR)) u_cfg_gpctl1_reg_inst (
  .hclk    (hclk),          .hresetn (hresetn),
  .wr_en   (valid_wr_lat),  .rd_en   (valid_rd),
  .byte_en (wbyte_en_lat),  .wr_addr (haddr_lat),
  .rd_addr (haddr),         .wdata   (hwdata),
  .wr_reg  (gpctl1),        .rdata   (rdata[77][31:0]));





localparam INDX_START = 78;

genvar i;

generate
  for (i =0; i < NBITS/32; i =i +1) begin : cfg_fhe_n_gen
    gpcfg_rd_wr #( .RESET_VAL (32'd0), .CFG_ADDR (GPCFG_N_ADDR[0][15:0] + 4*i)) u_cfg_fhe_n_reg_inst (
      .hclk    (hclk),                     .hresetn (hresetn),
      .wr_en   (valid_wr_lat),             .rd_en   (valid_rd),
      .byte_en (wbyte_en_lat),             .wr_addr (haddr_lat),
      .rd_addr (haddr),                    .wdata   (hwdata),
      .wr_reg  (fhe_n_reg[31+32*i:32*i]),  .rdata   (rdata[INDX_START+i][31:0]));
  end
endgenerate

localparam INDX0 = INDX_START + NBITS/32;

generate
  for (i =0; i < NBITS/32; i =i +1) begin : cfg_fhe_ninv_gen
    gpcfg_rd_wr #( .RESET_VAL (32'd0), .CFG_ADDR (GPCFG_NINV_ADDR[0][15:0] + 4*i)) u_cfg_fhe_ninv_reg_inst (
      .hclk    (hclk),                       .hresetn (hresetn),
      .wr_en   (valid_wr_lat),               .rd_en   (valid_rd),
      .byte_en (wbyte_en_lat),               .wr_addr (haddr_lat),
      .rd_addr (haddr),                      .wdata   (hwdata),
      .wr_reg  (fhe_ninv_reg[31+32*i:32*i]), .rdata   (rdata[INDX0+i][31:0]));
  end
endgenerate


localparam INDX1 = INDX0 + NBITS/32;


generate
  for (i =0; i < NBITS/16; i =i +1) begin : cfg_fhe_mdk_gen
    gpcfg_rd_wr #( .RESET_VAL (32'd0), .CFG_ADDR (GPCFG_NSQ_ADDR[0][15:0] + 4*i)) u_cfg_fhe_mdk_reg_inst (
      .hclk    (hclk),                        .hresetn (hresetn),
      .wr_en   (valid_wr_lat),                .rd_en   (valid_rd),
      .byte_en (wbyte_en_lat),                .wr_addr (haddr_lat),
      .rd_addr (haddr),                       .wdata   (hwdata),
      .wr_reg  (baret_mdk_reg[31+32*i:32*i]), .rdata   (rdata[INDX1+i][31:0]));
  end
endgenerate

localparam INDX2 = INDX1 + NBITS/16;


localparam INDX3 = INDX2;
localparam INDX4 = INDX3;
localparam INDX5 = INDX4;
localparam INDX6 = INDX5;
localparam INDX7  = INDX6;
localparam INDX8  = INDX7;
localparam INDX9  = INDX8;
localparam INDX10 = INDX9;
localparam INDX11 = INDX10;
localparam INDX12 = INDX11;

generate
  for (i =0; i < NBITS/32; i =i +1) begin : cfg_dbg_data_gen
    gpcfg_rd #(.CFG_ADDR (GPCFG_DBG_ADDR[0][15:0] + 4*i)) u_gpcfg_rd_cfg_dbg_data_inst  (
      .rd_en     (valid_rd),
      .rd_addr   (haddr),
      .wdata     (dbg_data[31+32*i:32*i]),
      .rdata     (rdata[INDX12+i][31:0])
    );
  end
endgenerate

localparam INDX13 = INDX12 + NBITS/32;

localparam NUM_RDATA = INDX13-1;

gpcfg_rdata_mux #(
  .NUM_RDATA (NUM_RDATA)) u_gpcfg_rdata_mux_inst (
  .hclk      (hclk),
  .hresetn   (hresetn),
  .rdata     (rdata[0 :NUM_RDATA]),      //input  wire [31:0] 
  .valid_rd  (valid_rd),
  .hrdata    (hrdata)                    //output reg  [31:0] 
);




//----------------------------
// Logic for write byte enable
// hsize
// 0000 - byte
// 0001 - hword
// 0010 - word
//----------------------------
   always @* begin
     if (valid_wr == 1'b1) begin
       if (haddr[1:0] == 2'b00) begin
         case (hsize)
           3'b000 : wbyte_en = 4'b0001;
           3'b001 : wbyte_en = 4'b0011;
           3'b010 : wbyte_en = 4'b1111;
           default: wbyte_en = 4'b0000;
         endcase
       end
       else if((haddr[1:0] == 2'b01)) begin
         case (hsize)
           3'b000 : wbyte_en = 4'b0010;
           default: wbyte_en = 4'b0000;
         endcase
       end
       else if((haddr[1:0] == 2'b10)) begin
         case (hsize)
           3'b000 : wbyte_en = 4'b0100;
           3'b001 : wbyte_en = 4'b1100;
           default: wbyte_en = 4'b0000;
         endcase
       end
       else begin
         case (hsize)
           3'b000 : wbyte_en = 4'b1000;
           default: wbyte_en = 4'b0000;
         endcase
       end
     end
     else begin
       wbyte_en = 4'b0000;
     end
   end

//------------------------------------
// Logic to generate hresp and hready
//------------------------------------
  assign dec_err = 1'b0; 
  always @ (posedge hclk or negedge hresetn) begin
    if (hresetn == 1'b0) begin
      hready <= 1'b1;
      hresp  <= 1'b0;
    end
    else if (dec_err == 1'b1) begin
      hready <= 1'b0;
      hresp  <= 1'b1;
    end
    else begin
      hready <= 1'b1;
      hresp  <= ~hready;
    end
  end
 

//-------------------------------------------------------------------------- 
//-------------------------------------------------------------------------- 

  assign modulus         = fhe_n_reg;
  assign invmodulus      = fhe_ninv_reg;
  assign baret_mdk       = baret_mdk_reg;

  assign polysize        = fhe_ctl_reg[15:0];
  assign uarts_tx_ctl    = fhe_ctl_reg[16];
  assign dbg_data_sel    = fhe_ctl_reg[19:17];
  assign gate_mul_done   = fhe_ctl_reg[20];
  assign cm0_sw_rstn     = fhe_ctl_reg[21];
  assign cfifo_sel       = fhe_ctl_reg[22];
  assign test_en         = fhe_ctl_reg[23];

  assign base_addr_a     = cfifo_sel ? base_addr_a_cf: fhe_ctl2_reg[7:0];
  assign base_addr_b     = cfifo_sel ? base_addr_b_cf: fhe_ctl2_reg[15:8];
  assign base_addr_t     = fhe_ctl2_reg[23:16];
  assign base_addr_ra    = cfifo_sel ? base_addr_r_cf: fhe_ctl2_reg[31:24];

  assign base_addr_rb    = dp_en ? {4'h3, base_addr_ra[3:0]} : fhe_ctl_reg[31:24];  //8'h00;

  assign mdmc_throt_cnt_ntt  = fhe_ctl3_reg[7:0];
  assign mdmc_throt_cnt_mul  = fhe_ctl3_reg[15:8];
  assign mdmc_throt_cnt_add  = fhe_ctl3_reg[23:16];
  assign sel_pll             = fhe_ctl3_reg[24];
  assign dp_en               = cfifo_sel ? dp_en_cf : fhe_ctl3_reg[25];
  assign dma_cfifo_sel       = fhe_ctl3_reg[26] ? cfifo_sel : 1'b0;


  assign trig_ntt        = cfifo_sel ? trig_ntt_cf        : fhe_ctl_p_reg[0];
  assign trig_intt       = cfifo_sel ? trig_intt_cf       : fhe_ctl_p_reg[1];
  assign trig_mul        = cfifo_sel ? trig_mul_cf        : fhe_ctl_p_reg[2] | fhe_ctl_p_reg[5];
  assign trig_add        = cfifo_sel ? trig_add_cf        : fhe_ctl_p_reg[3];
  assign trig_sub        = cfifo_sel ? trig_sub_cf        : fhe_ctl_p_reg[4];
  assign trig_constmul   = cfifo_sel ? trig_constmul_cf   : fhe_ctl_p_reg[5];

  assign trig_dma        = dma_cfifo_sel ? trig_dma_cf        : fhe_ctl_p_reg[6];
  assign trig_sqr        = cfifo_sel     ? trig_sqr_cf        : fhe_ctl_p_reg[7];
  assign trig_nmul       = cfifo_sel     ? trig_nmul_cf       : fhe_ctl_p_reg[8];

  assign host_irq_clr        = fhe_ctl_p_reg[16];

  assign tot_busy_cnt_clr    = fhe_ctl_p_reg[17];

  assign busy_flag_rel = ntt_done | intt_done | pwise_mul_done | add_done | sub_done | dma_done | sqr_done | nmul_done;

  always @ (posedge hclk or negedge hresetn) begin
    if (hresetn == 1'b0) begin
      fhe_busy      <= 1'b0;
      busy_flag_set <= 16'b0;
    end
    else if (busy_flag_rel == 1'b1) begin
      fhe_busy          <= 1'b0;
      busy_flag_set <= 16'b0;
    end
    else if (trig_ntt | trig_intt | trig_mul | trig_add | trig_sub | trig_constmul | trig_dma | trig_sqr | trig_nmul) begin
      fhe_busy      <= 1'b1;
      busy_flag_set <= {trig_nmul, trig_sqr, trig_dma, trig_constmul, trig_sub, trig_add, trig_mul, trig_intt, trig_ntt};
    end
  end

  always @ (posedge hclk or negedge hresetn) begin
    if (hresetn == 1'b0) begin
      fhe_busy_d   <= 1'b0;
    end
    else begin
      fhe_busy_d  <= fhe_busy;
    end
  end

  always @ (posedge hclk or negedge hresetn) begin
    if (hresetn == 1'b0) begin
      fhe_host_irq   <= 1'b0;
    end
    else if ((fhe_busy_d == 1'b1) && (fhe_busy == 1'b0)) begin
      fhe_host_irq   <= 1'b1;
    end
    else if (host_irq_clr == 1'b1) begin
      fhe_host_irq   <= 1'b0;
    end
  end


  always @ (posedge hclk or negedge hresetn) begin
    if (hresetn == 1'b0) begin
      mdmc_data_lat   <= 32'b0;
    end
    else if (mdmc_done) begin
      mdmc_data_lat   <= mdmc_data;
    end
  end



always @* begin
  case (dbg_data_sel)
    3'b000  : dbg_data = {NBITS{1'b0}} | {base_addr_t, base_addr_ra, base_addr_b, base_addr_a, mdmc_data, tot_busy_cnt, mdmc_data_lat};
    3'b001  : dbg_data = {NBITS{1'b0}} | {pll_ctl, gpctl0, gpctl1, fhe_busy, busy_flag_set};
    3'b010  : dbg_data = {NBITS{1'b0}};
    3'b011  : dbg_data = {NBITS{1'b0}};
    3'b100  : dbg_data = {NBITS{1'b0}};
    3'b101  : dbg_data = {NBITS{1'b0}};
    3'b110  : dbg_data = {NBITS{1'b0}};
    3'b111  : dbg_data = {NBITS{1'b0}};
    default : dbg_data = {NBITS{1'b0}};
  endcase

end

assign tkey = {key_reg7, key_reg6, key_reg5, key_reg4, key_reg3, key_reg2, key_reg1, key_reg0};
//128'b

always @(negedge hresetn or posedge hclk) begin
  if (hresetn == 1'b0) begin
    tot_busy_cnt    <= 32'b0;
    cntnue_tot_cnt  <= 1'b0;
  end
  else if (tot_busy_cnt_clr) begin
    tot_busy_cnt    <= 32'b0;
  end
  else if (trig_ntt | trig_mul | trig_add | trig_sub | trig_intt | trig_constmul | trig_dma | trig_sqr | trig_nmul) begin
    cntnue_tot_cnt  <= 1'b1;
  end
  else if (mdmc_done) begin
    cntnue_tot_cnt  <= 1'b0;
  end
  else if (cntnue_tot_cnt == 1'b1) begin
    tot_busy_cnt <= tot_busy_cnt + 1'b1;
  end
end




endmodule
