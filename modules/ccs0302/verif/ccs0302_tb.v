`timescale 1 ns/1 ps

module ccs0302_tb (
);

//---------------------------------
//Local param reg/wire declaration
//---------------------------------

localparam  CLK_PERIOD   = 4.167; //24 Mhz
localparam  UART_BAUD    = 41.67; //9600 bps
localparam  SPI_BAUD     = 41.67; //9600 bps

//localparam  CLK_PERIOD   = 10; //24 Mhz
//localparam  UART_BAUD    = 100; //9600 bps
//localparam  SPI_BAUD     = 100; //9600 bps

localparam  NUM_PADS     = 26;
localparam  PAD_CTL_W    = 4;

wire [255 :0]  temp = 256'b0;
reg  [255 :0]  temp1_reg;
reg  [255 :0]  temp2_reg;
reg  [255 :0]  temp3_reg;
reg  [255 :0]  temp4_reg;

wire [NUM_PADS-1  :0] pad;
wire [NUM_PADS-1  :0] pad_in;
wire [NUM_PADS-1  :0] pad_out;
wire [PAD_CTL_W-1 :0] pad_ctl[NUM_PADS-1 :0];

reg [7:0] r_Master_TX_Byte = 0;
reg       r_Master_TX_DV   = 1'b0;
logic     r_Master_CS_n    = 1'b1;
reg       w_Master_TX_Ready;

reg       r_Master_RX_DV;
reg [7:0] r_Master_RX_Byte;


logic [7:0] dataPayload[0:255]; 
logic [7:0] dataLength;

logic [31:0] prev_w_bitwidth_spi;
logic [31:0] prev_w_burst_size_spi;
logic [31:0] prev_w_address_spi;
logic [31:0] prev_r_bitwidth_spi;
logic [31:0] prev_r_burst_size_spi;
logic [31:0] prev_r_address_spi;

logic [31:0] prev_w_bitwidth;
logic [31:0] prev_w_burst_size;
logic [31:0] prev_w_address;
logic [31:0] prev_r_bitwidth;
logic [31:0] prev_r_burst_size;
logic [31:0] prev_r_address;
  



reg     CLK; 
reg     nPORESET; 
reg     nRESET; 

reg       UART_CLK; 
reg       SPI_CLK; 
wire      r_Clkm; 
wire      CLK50M; 
reg [9:0] tx_reg  = 10'h3FF; 
reg [7:0] rx_reg  = 8'h00; 
reg [7:0] rx_reg2 = 8'h00; 
reg [2047:0] uartm_rx_tb_data = 2048'h0; 
wire uartm_rx_data;
wire uarts_rx_data;
wire unlock;
wire test_so;
wire fhe_host_irq;

integer no_of_clocks; 

reg [511:0] mem_sram [0:1023];
reg [31:0]  mem_tb   [0:16383];
reg [31:0]  mem      [0:4095];

parameter NBITS        = 128;
parameter DWIDTH       = 128;
//parameter POLYDEG      = 4096;
parameter POLYDEG      = 8192;
//parameter POLYDEG      = 128;
parameter POLYDEGPARAM = 8192;
parameter NMUL         = 1;
parameter NPLINE       = 16;


parameter SPI_MODE           = 0;     // CPOL = 0, CPHA = 1
parameter SPI_CLK_DELAY      = 20;    // 2.5 MHz
parameter CLKS_PER_HALF_BIT  = 5;     // SPI at 20MHz
parameter MASTER_CLK_DELAY   = 0.25;  // 2000 MHz
parameter SLAVE_CLK_DELAY    = 5;     // 100 MHz
  
parameter CLK_FREQ      = 50000000;
parameter BAUD_RATE     = 115200;
parameter PARITY_BIT    = "none";
parameter NO_BYTE_SEND  = 2;
parameter CALIBRATION1  = 0;
parameter CALIBRATION2  = 1;





reg [DWIDTH-1 :0] coef        [0: POLYDEG-1];
reg [DWIDTH-1 :0] coef2       [0: POLYDEG-1];
reg [DWIDTH-1 :0] ntt_of_coef [0: POLYDEG-1];
reg [DWIDTH-1 :0] twdl        [0: POLYDEG-1];
reg [DWIDTH-1 :0] fhe_res     [0: POLYDEG-1];
reg [DWIDTH-1 :0] fhe_exp_res [0: POLYDEG-1];

reg [NBITS-1 :0]    mod           = 2**NBITS-1;
reg [NBITS-1 :0]    arga          = {(NBITS/4){$random}}%mod;
reg [NBITS-1 :0]    argb          = {(NBITS/4){$random}}%mod;
reg [NBITS-1 :0]    fkf           = {(NBITS/4){$random}}%mod;
reg [NBITS-1 :0]    rand0         = {(NBITS/4){$random}}%mod;
reg [NBITS-1 :0]    rand1         = {(NBITS/4){$random}}%mod;

reg [11:0]      log2ofn        = $clog2(mod);
reg [11:0]      log2ofn2       = $clog2(mod*mod);
reg [2048:0]    r_for_egcd     = 1'b1 << log2ofn2;
reg [2047:0]    r_red_for_egcd = r_for_egcd - mod;

reg [2047:0]  scratch_pad;
integer        i;
integer        j;
integer        seed;

//Address params
`include "./ccs0302_header.v"

//Tasks
`include "./ccs0302_tasks.v"
   
//Defines
`define ARM_UD_MODEL;
`define RANDSIM;

initial $readmemh("./hex/cm0.hex", mem_sram);

//------------------------------
//Clock and Reset generation
//------------------------------

initial begin
  CLK      = 1'b0; 
  UART_CLK = 1'b0; 
  SPI_CLK  = 1'b0; 
end

always begin
  #(CLK_PERIOD/2) CLK = ~CLK; 
end

always begin
  #(UART_BAUD/2) UART_CLK = ~UART_CLK; 
end

always begin
  #(SPI_BAUD/2)  SPI_CLK  = ~SPI_CLK; 
end

assign r_Clkm                  = CLK;
assign CLK50M                  = CLK;

//------------------------------
//Pad to functionality mapping
//------------------------------
//pad0  nPORESET
//pad1  nRESET
//pad2  CLK
//pad3  UARTM_TX
//pad4  UARTM_RX
//pad5  UARTS_TX
//pad6  UARTS_RX
//pad7  GPIO0
//pad8  GPIO1
//pad9  GPIO2
//pad10 GPIO3
//------------------------------

assign pad_in[0]  = nPORESET;
assign pad_ctl[0] = 4'h3;

assign pad_in[1]  = nRESET;
assign pad_ctl[1] = 4'h3;

assign pad_in[2]  = CLK;
assign pad_ctl[2] = 4'h3;

int k;
int l;


always @* begin
  for (k=0; k<1024; k=k+1) begin
    //for (l=0; l<16; l=l+1) begin
    //  //mem[k*16+l][31:0] = mem_sram[k][32*l + 31 : 32*l];
    //end
    mem_tb[0 + k*16][31:0]  = mem_sram[k][31:0];
    mem_tb[1 + k*16][31:0]  = mem_sram[k][63:32];
    mem_tb[2 + k*16][31:0]  = mem_sram[k][95:64];
    mem_tb[3 + k*16][31:0]  = mem_sram[k][127:96];
    mem_tb[4 + k*16][31:0]  = mem_sram[k][159:128];
    mem_tb[5 + k*16][31:0]  = mem_sram[k][191:160];
    mem_tb[6 + k*16][31:0]  = mem_sram[k][223:192];
    mem_tb[7 + k*16][31:0]  = mem_sram[k][255:224];
    mem_tb[8 + k*16][31:0]  = mem_sram[k][287:256];
    mem_tb[9 + k*16][31:0]  = mem_sram[k][319:288];
    mem_tb[10 + k*16][31:0] = mem_sram[k][351:320];
    mem_tb[11 + k*16][31:0] = mem_sram[k][383:352];
    mem_tb[12 + k*16][31:0] = mem_sram[k][415:384];
    mem_tb[13 + k*16][31:0] = mem_sram[k][447:416];
    mem_tb[14 + k*16][31:0] = mem_sram[k][479:448];
    mem_tb[15 + k*16][31:0] = mem_sram[k][511:480];
  end
  mem[0:4095] = mem_tb[0:4095];
end

wire pad_ctl_3;
wire pad_ctl_4;
wire pad_ctl_5;
wire pad_ctl_6;
wire pad_ctl_7;
wire pad_ctl_8;
wire pad_ctl_9;
wire pad_ctl_10;
wire pad_ctl_11;
wire pad_ctl_12;
wire pad_ctl_13;
wire pad_ctl_14;
wire pad_ctl_15;
wire pad_ctl_16;
wire pad_ctl_17;
wire pad_ctl_18;
wire pad_ctl_19;
wire pad_ctl_20;
wire pad_ctl_21;
wire pad_ctl_22;
wire pad_ctl_23;
wire pad_ctl_24;
wire pad_ctl_25;
//wire pad_ctl_26;


initial begin
  force ccs0302_tb.pad_ctl_3  = ccs0302_tb.u_dut_inst.u_padring_inst.pad_ctl[3][0];
  force ccs0302_tb.pad_ctl_4  = ccs0302_tb.u_dut_inst.u_padring_inst.pad_ctl[4][0];
  force ccs0302_tb.pad_ctl_5  = ccs0302_tb.u_dut_inst.u_padring_inst.pad_ctl[5][0];
  force ccs0302_tb.pad_ctl_6  = ccs0302_tb.u_dut_inst.u_padring_inst.pad_ctl[6][0];
  force ccs0302_tb.pad_ctl_7  = ccs0302_tb.u_dut_inst.u_padring_inst.pad_ctl[7][0];
  force ccs0302_tb.pad_ctl_8  = ccs0302_tb.u_dut_inst.u_padring_inst.pad_ctl[8][0];
  force ccs0302_tb.pad_ctl_9  = ccs0302_tb.u_dut_inst.u_padring_inst.pad_ctl[9][0];
  force ccs0302_tb.pad_ctl_10 = ccs0302_tb.u_dut_inst.u_padring_inst.pad_ctl[10][0];
  force ccs0302_tb.pad_ctl_11 = ccs0302_tb.u_dut_inst.u_padring_inst.pad_ctl[11][0];
  force ccs0302_tb.pad_ctl_12 = ccs0302_tb.u_dut_inst.u_padring_inst.pad_ctl[12][0];
  force ccs0302_tb.pad_ctl_13 = ccs0302_tb.u_dut_inst.u_padring_inst.pad_ctl[13][0];
  force ccs0302_tb.pad_ctl_14 = ccs0302_tb.u_dut_inst.u_padring_inst.pad_ctl[14][0];
  force ccs0302_tb.pad_ctl_15 = ccs0302_tb.u_dut_inst.u_padring_inst.pad_ctl[15][0];
  force ccs0302_tb.pad_ctl_16 = ccs0302_tb.u_dut_inst.u_padring_inst.pad_ctl[16][0];
  force ccs0302_tb.pad_ctl_17 = ccs0302_tb.u_dut_inst.u_padring_inst.pad_ctl[17][0];
  force ccs0302_tb.pad_ctl_18 = ccs0302_tb.u_dut_inst.u_padring_inst.pad_ctl[18][0];
  force ccs0302_tb.pad_ctl_19 = ccs0302_tb.u_dut_inst.u_padring_inst.pad_ctl[19][0];
  force ccs0302_tb.pad_ctl_20 = ccs0302_tb.u_dut_inst.u_padring_inst.pad_ctl[20][0];
  force ccs0302_tb.pad_ctl_21 = ccs0302_tb.u_dut_inst.u_padring_inst.pad_ctl[21][0];
  force ccs0302_tb.pad_ctl_22 = ccs0302_tb.u_dut_inst.u_padring_inst.pad_ctl[22][0];
  force ccs0302_tb.pad_ctl_23 = ccs0302_tb.u_dut_inst.u_padring_inst.pad_ctl[23][0];
  force ccs0302_tb.pad_ctl_24 = ccs0302_tb.u_dut_inst.u_padring_inst.pad_ctl[24][0];
  force ccs0302_tb.pad_ctl_25 = ccs0302_tb.u_dut_inst.u_padring_inst.pad_ctl[25][0];
  //force ccs0302_tb.pad_ctl_26 = ccs0302_tb.u_dut_inst.u_padring_inst.pad_ctl[26][0];
  force ccs0302_tb.u_dut_inst.u_chip_core_inst.u_cortexm0_wrap_inst.HSIZE[2] = 1'b0;
end

assign pad_in[3]  = 1'b0;
assign pad_ctl[3] = {3'b001,pad_ctl_3};
assign uartm_rx_data = pad_out[3];

assign pad_in[4]  = tx_reg[0];
assign pad_ctl[4] = {3'b001,pad_ctl_4};

assign pad_in[5]  = 1'b0;
assign pad_ctl[5] = {3'b001,pad_ctl_5};
assign uarts_rx_data = pad_out[5];

assign pad_in[6]  = 1'b1;
assign pad_ctl[6] = {3'b001,pad_ctl_6};

assign pad_in[7]  = 1'b0;
assign pad_ctl[7] = {3'b001,pad_ctl_7};

assign pad_in[8]  = 1'b0;
assign pad_ctl[8] = {3'b001,pad_ctl_8};

assign pad_in[9]  = 1'b0;
assign pad_ctl[9] = {3'b001,pad_ctl_9};
assign fhe_host_irq = pad_out[9];

assign pad_in[10]  = 1'b0;
assign pad_ctl[10] = {3'b001,pad_ctl_10};

assign pad_in[11]  = 1'b0;
assign pad_ctl[11] = {3'b001,pad_ctl_11};

assign pad_in[12]  = 1'b0;
assign pad_ctl[12] = {3'b001,pad_ctl_12};

assign pad_in[13]  = 1'b0;
assign pad_ctl[13] = {3'b001,pad_ctl_13};

assign pad_in[14]  = 1'b0;
assign pad_ctl[14] = {3'b001,pad_ctl_14};

//assign pad_in[15]  = 1'b0;
assign pad_ctl[15] = {3'b001,pad_ctl_15};

assign pad_in[16]  = r_Master_CS_n;
assign pad_ctl[16] = {3'b001,pad_ctl_16};

//assign pad_in[17]  = 1'b0;
assign pad_ctl[17] = {3'b001,pad_ctl_17};

assign pad_in[18]  = 1'b0;
assign pad_ctl[18] = {3'b001,pad_ctl_18};

assign pad_in[19]  = 1'b0;
assign pad_ctl[19] = {3'b001,pad_ctl_19};

assign pad_in[20]  = 1'b0;
assign pad_ctl[20] = {3'b001,pad_ctl_20};
assign unlock      = pad_out[20];

assign pad_in[21]  = 1'b0;
assign pad_ctl[21] = {3'b001,pad_ctl_21};
assign test_so     = pad_out[21];

assign pad_in[22]  = 1'b0;
assign pad_ctl[22] = {3'b001,pad_ctl_22};

assign pad_in[23]  = 1'b0;
assign pad_ctl[23] = {3'b001,pad_ctl_23};

assign pad_in[24]  = 1'b0;
assign pad_ctl[24] = {3'b001,pad_ctl_24};

assign pad_in[25]  = 1'b0;
assign pad_ctl[25] = {3'b001,pad_ctl_25};

//assign pad_in[26]  = 1'b0;
//assign pad_ctl[26] = {3'b001,pad_ctl_26};


assign pad_in[19]  = 1'b0;
assign pad_ctl[19] = {3'b001,pad_ctl_19};

padring_tb #(
  .NUM_PADS  (NUM_PADS),
  .PAD_CTL_W (PAD_CTL_W) )
  u_padring_tb_inst (
  .pad       (pad),
  .pad_in    (pad_in),
  .pad_out   (pad_out),
  .pad_ctl   (pad_ctl)
);

//------------------------------
//Track number of clocks
//------------------------------
initial begin
  no_of_clocks = 0; 
end
always@(posedge CLK)  begin
  no_of_clocks = no_of_clocks +1 ; 
  //$display($time, " << Number of Clocks value         %d", no_of_clocks);
  //$display($time, " << htrans_m[0] value              %b", ccs0302_tb.u_dut_inst.u_chip_core_inst.u_ahb_ic_inst.htrans_m[0][1]);
  //$display($time, " << vlaid_trans_s_by_m[s][0] value %b", ccs0302_tb.u_dut_inst.u_chip_core_inst.u_ahb_ic_inst.vlaid_trans_s_by_m[0][0]);
  //$display($time, " << vlaid_trans_s_by_m[s][1] value %b", ccs0302_tb.u_dut_inst.u_chip_core_inst.u_ahb_ic_inst.vlaid_trans_s_by_m[1][0]);
  //$display($time, " << SLAVE_BASE[0] value            %h", ccs0302_tb.u_dut_inst.u_chip_core_inst.u_ahb_ic_inst.SLAVE_BASE[0][31:16]);
  //$display($time, " << SLAVE_BASE[1] value            %h", ccs0302_tb.u_dut_inst.u_chip_core_inst.u_ahb_ic_inst.SLAVE_BASE[1][31:16]);
  //$display($time, " << haddr_m[0]  value              %h", ccs0302_tb.u_dut_inst.u_chip_core_inst.u_ahb_ic_inst.haddr_m[0][31:16]);
  //$display($time, " << memory dump                    %h", ccs0302_tb.u_dut_inst.u_chip_core_inst.u_sram_wrap_inst.u_sram_inst.mem_sram[0]);
end

//initial begin
//@(posedge unlock);
//$display($time, " << Number of Clocks value After  unlock goes high  %d", ccs0302_tb.no_of_clocks);
//end


genvar m;
reg [31:0] mult_busy_cnt [0:NMUL];
reg [31:0] mult_busy_cnt_est [0:NMUL];
reg cntnue_cnt [0:NMUL];

reg [31:0] tot_busy_cnt;
reg cntnue_tot_cnt;

generate
  for (m=0; m<NMUL; m=m+1) begin
     always @(negedge nPORESET or posedge CLK) begin
       if (nPORESET == 1'b0) begin
         mult_busy_cnt[m] <= 0;
         cntnue_cnt[m]  <= 0;
       end
       else if (ccs0302_tb.u_dut_inst.u_chip_core_inst.u_multpool_inst.multpool_gen[m].u_butterfly_inst.u_mod_mul_inst.enable_p) begin
         cntnue_cnt[m]  <= 1'b1;
       end
       else if (ccs0302_tb.u_dut_inst.u_chip_core_inst.u_multpool_inst.multpool_gen[m].u_butterfly_inst.u_mod_mul_inst.done_irq_p) begin
         mult_busy_cnt[m] <= mult_busy_cnt[m];
         cntnue_cnt[m]  <= 1'b0;
       end
       else if (cntnue_cnt[m] == 1'b1) begin
         mult_busy_cnt[m] <= mult_busy_cnt[m] + 1'b1;
       end
     end
  end
endgenerate

always @(negedge nPORESET or posedge CLK) begin
  if (nPORESET == 1'b0) begin
    tot_busy_cnt <= 0;
    cntnue_tot_cnt  <= 0;
  end
  else if (ccs0302_tb.u_dut_inst.u_chip_core_inst.u_mdmc_inst.trig_ntt | ccs0302_tb.u_dut_inst.u_chip_core_inst.u_mdmc_inst.trig_mul | ccs0302_tb.u_dut_inst.u_chip_core_inst.u_mdmc_inst.trig_add | ccs0302_tb.u_dut_inst.u_chip_core_inst.u_mdmc_inst.trig_sub | ccs0302_tb.u_dut_inst.u_chip_core_inst.u_mdmc_inst.trig_intt | ccs0302_tb.u_dut_inst.u_chip_core_inst.u_mdmc_inst.trig_constmul) begin
    cntnue_tot_cnt  <= 1'b1;
  end
  else if (ccs0302_tb.u_dut_inst.u_chip_core_inst.u_mdmc_inst.ntt_done | ccs0302_tb.u_dut_inst.u_chip_core_inst.u_mdmc_inst.pwise_mul_done | ccs0302_tb.u_dut_inst.u_chip_core_inst.u_mdmc_inst.add_done | ccs0302_tb.u_dut_inst.u_chip_core_inst.u_mdmc_inst.sub_done | ccs0302_tb.u_dut_inst.u_chip_core_inst.u_mdmc_inst.intt_done ) begin
    tot_busy_cnt <= tot_busy_cnt;
    cntnue_tot_cnt  <= 1'b0;
  end
  else if (cntnue_tot_cnt == 1'b1) begin
    tot_busy_cnt <= tot_busy_cnt + 1'b1;
  end
end

initial begin
      prev_w_bitwidth = 'd0;
      prev_w_burst_size = 'd0;
      prev_w_address = 'd0;
      prev_r_bitwidth = 'd0;
      prev_r_burst_size = 'd0;
      prev_r_address = 'd0;
      prev_w_bitwidth_spi = 'd0;
      prev_w_burst_size_spi = 'd0;
      prev_w_address_spi = 'd0;
      prev_r_bitwidth_spi = 'd0;
      prev_r_burst_size_spi = 'd0;
      prev_r_address_spi = 'd0;
end



initial begin

#0 nPORESET  = 1'b1;
   nRESET    = 1'b1;
  repeat (10) begin
    @(posedge CLK);
  end

force ccs0302_tb.u_dut_inst.u_chip_core_inst.u_gpcfg_inst.uartm_baud_ctl_reg = 32'h9;
force ccs0302_tb.u_dut_inst.u_chip_core_inst.u_gpcfg_inst.uarts_baud_ctl_reg = 32'h9;
//force ccs0302_tb.u_dut_inst.u_chip_core_inst.u_sram_wrap_inst.genblk1[0].u_sram_inst.mem[0:1023] = mem_sram;

   nPORESET  = 1'b0;
   nRESET    = 1'b0;
//release ccs0302_tb.u_dut_inst.u_chip_core_inst.u_sram_wrap_inst.genblk1[0].u_sram_inst.mem[0:1023];

  repeat (20) begin
    @(posedge CLK);
  end

  nPORESET = 1'b1;
  nRESET   = 1'b0;

  repeat (25) begin
    @(posedge UART_CLK);
  end

    uartm_read     (.addr(GPCFG_SIGNATURE), .data(uartm_rx_tb_data[31:0]));
    $display(" << INFO: Signature Register read as : %h", uartm_rx_tb_data[31:0]);
    uartm_write    (.addr(GPCFG_HOSTIRQ_PAD_CTL),     .data(32'h12001A));
    uartm_write    (.addr(GPCFG_UARTSTX_PAD_CTL),     .data(32'h10001A));
`include "./hex/test.hex"
    $display(" << INFO: Loading done. Waiting for uart slave response.");
    uarts_rx_data_capture (.data (rx_reg2));
    $display(" << INFO: Result at memory with base address : %h", rx_reg2);
    //@(posedge fhe_host_irq);
    for (i = 0; i < POLYDEG; i++) begin
      uartm_read_128  (.addr({rx_reg2[7:0], 24'b0} + 16*i));
      fhe_res[i] = uartm_rx_tb_data[DWIDTH-1:0];
      if (fhe_res[i] != fhe_exp_res[i]) begin
        $display(" << ERROR at coeff no : %d", i);
        $display(" << ERROR Expected value : %d", fhe_exp_res[i]);
        $display(" << ERROR Returned value : %d", fhe_res[i]);
      end
      //else begin
      //  $display(" << PASSED for coeff no : %d", i);
      //  $display(" << PASSED Expected value : %d", fhe_exp_res[i]);
      //  $display(" << PASSED Returned value : %d", fhe_res[i]);
      //end
    end

    @(posedge UART_CLK);
    if (fhe_res == fhe_exp_res) begin
       $display(" << TESTCASE PASSED");
    end
    else begin
       $display(" << TESTCASE FAILED");
    end


    //@(posedge fhe_host_irq);
    //uartm_write    (.addr(GPCFG_SPIMOSI_PAD_CTL),     .data(32'h000018));
    //uartm_write    (.addr(GPCFG_CLCTLP_ADDR),     .data(CLCTLP_UPDTRNG));
    //@(posedge UART_CLK);
  
  $display(" << Total Number of cycles taken : %d", ccs0302_tb.tot_busy_cnt);
  for (k=0; k<NMUL; k=k+1) begin
    $display(" << Number of Clocks mulptiplier %d", k, " is busy : %d", ccs0302_tb.mult_busy_cnt[k], "::::Efficiency : %f", ccs0302_tb.mult_busy_cnt[k]*100/ccs0302_tb.tot_busy_cnt);
  end

    @(posedge UART_CLK);
    if (fhe_res == fhe_exp_res) begin
       $display(" << TESTCASE PASSED");
    end
    else begin
       $display(" << TESTCASE FAILED");
    end


$finish; 
end

  // Instantiate Master to drive Slave
  SPI_Master 
  #(.SPI_MODE          (SPI_MODE),
    .CLKS_PER_HALF_BIT (CLKS_PER_HALF_BIT),
    .NUM_SLAVES        (1)) SPI_Master_UUT
  (
   // Control/Data Signals,
   .i_Rst_L(nPORESET),     // Chip Reset
   .i_Clk(CLK),            // Chip Clock
   
   // TX (MOSI) Signals
   .i_TX_Byte(r_Master_TX_Byte),     // Byte to transmit on MOSI
   .i_TX_DV(r_Master_TX_DV),         // Data Valid Pulse with i_TX_Byte
   .o_TX_Ready(w_Master_TX_Ready),   // Transmit Ready for Byte
   
   // RX (MISO) Signals
   .o_RX_DV(r_Master_RX_DV),       // Data Valid pulse (1 clock cycle)
   .o_RX_Byte(r_Master_RX_Byte),   // Byte received on MISO

   // SPI Interface
   .o_SPI_Clk (pad_in[15] ),
   .o_SPI_MOSI(pad_in[17]),
   .i_SPI_MISO(pad_out[18])
   );




//------------------------------
//DUT
//------------------------------
ccs0302 #(
  .NBITS   (NBITS),
  .POLYDEG (POLYDEGPARAM),
  .NPLINE  (NPLINE),
  .NMUL    (NMUL)
 ) u_dut_inst 
  (
  .pad  (pad),
  .VDD  (1'b1),
  .DVDD (1'b1),
  .VSS  (1'b0),
  .DVSS (1'b0)
  );



endmodule


