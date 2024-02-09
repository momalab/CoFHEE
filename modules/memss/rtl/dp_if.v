`timescale 1 ns/1 ps

module sram_wrap_dp  #(
  parameter POLYDEG = 4096,
  parameter DWIDTH  = 128) (  
  // CLOCK AND RESETS ------------------
  input  wire                hclk,      // Clock
  input  wire                hresetn,   // Asynchronous reset
  // AHB-LITE MASTER PORT --------------
  input   wire               hsel,      // AHB transfer: non-sequential only
  input   wire [31:0]        haddr,     // AHB transaction address
  input   wire [ 3:0]        hsize,     // AHB size: byte, half-word or word
  input   wire [DWIDTH-1 :0] hwdata,    // AHB write-data
  input   wire               hwrite,    // AHB write control
  output  wire [DWIDTH-1 :0] hrdata,    // AHB read-data
  output  reg                hready,    // AHB stall signal
  output  reg                hresp,     // AHB error response

  input   wire               hsel_b,    // AHB transfer: non-sequential only
  input   wire [31:0]        haddr_b,   // AHB transaction address
  input   wire [ 3:0]        hsize_b,   // AHB size: byte, half-word or word
  input   wire [DWIDTH-1 :0] hwdata_b,  // AHB write-data
  input   wire               hwrite_b,  // AHB write control
  output  wire [DWIDTH-1 :0] hrdata_b   // AHB read-data
  output  reg                hready_b,  // AHB stall signal
  output  wire               hresp_b,   // AHB error response

  input   wire [16:0]        sram_ctl,
);

//----------------------------------------------
//localparameter, genvar and wire/reg declaration
//----------------------------------------------
  localparam IDLE         = 0;
  localparam READ         = 1;
  localparam WRITE        = 2;
  localparam WAIT         = 3;
  localparam ERROR        = 4;

  localparam LOG2POLYDEG  = $clog2(POLYDEG);
  localparam ADDRWIDTH    = LOG2POLYDEG + 4;

  localparam NUM_MEM      = 4;

  reg [4:0]  ahb_ps;
  reg [4:0]  ahb_ns;

  reg                  hsel_lat;
  reg                  hsel_b_lat;
  reg [ADDRWIDTH-1 :0] haddr_loc;
  reg [ADDRWIDTH-1 :0] haddr_b_loc;
  reg [3:0]            hsize_loc;
  reg [3:0]            hsize_b_loc;
  reg [31:0]           sram_rdata[NUM_MEM-1 :0];
  reg [31:0]           sram00_rdata[NUM_MEM-1 :0];
  reg [31:0]           sram10_rdata[NUM_MEM-1 :0];
  reg                  sram_sel;
  reg                  sram_b_sel;
  reg                  sram_we;
  reg                  sram_b_we;

  reg [NUM_MEM-1 :0] sram_cs_n;
  reg [NUM_MEM-1 :0] sram00_cs_n;
  reg [NUM_MEM-1 :0] sram10_cs_n;
  reg [NUM_MEM-1 :0] sram_cs_n_lat;
  reg [NUM_MEM-1 :0] sram00_cs_n_lat;
  reg [NUM_MEM-1 :0] sram10_cs_n_lat;
  reg [NUM_MEM-1 :0] sram_we_n;

  reg [NUM_MEM-1 :0] sram_b_cs_n;
  reg [NUM_MEM-1 :0] sram00_b_cs_n;
  reg [NUM_MEM-1 :0] sram10_b_cs_n;
  reg [NUM_MEM-1 :0] sram_cs_b_n_lat;
  reg [NUM_MEM-1 :0] sram00_b_cs_n_lat;
  reg [NUM_MEM-1 :0] sram10_b_cs_n_lat;
  reg [NUM_MEM-1 :0] sram_b_we_n;

  reg [31:0] haddr_lat;
  reg [31:0] haddr_b_lat;
  wire       dec_err;

  reg [DWIDTH-1 :0] hrdata_lsw;
  reg [DWIDTH-1 :0] hrdata_b_lsw;
  wire[DWIDTH-1 :0] hrdata_loc;
  wire[DWIDTH-1 :0] hrdata_b_loc;

  wire [31 :0] hwdata_sram_loc[NUM_MEM-1 :0];
  wire [31 :0] hwdata_b_sram_loc[NUM_MEM-1 :0];

  reg [3:0]  hsize_lat;
  reg [3:0]  hsize_b_lat;

  genvar  i;
  integer j;

//--------------------------
//Identify valid transaction
//--------------------------
  //assign dec_err  = hready & hsel & (haddr[31:16] != 16'h2000);
  assign dec_err  = 1'b0;
  assign valid_wr = hready & hsel &  hwrite & ~dec_err;
  assign valid_rd = hready & hsel & ~hwrite & ~dec_err;

//--------------------------
//Capture write address
//--------------------------

  always @(posedge hclk or negedge hresetn) begin 
    if (hresetn == 1'b0) begin
      haddr_lat   <= 32'b0;
      haddr_b_lat <= 32'b0;
      hsel_lat    <= 1'b0;
      hsel_b_lat  <= 1'b0;
    end
    else if (ahb_ns[WRITE] | ahb_ns[WAIT]) begin
      haddr_lat   <= haddr;
      haddr_b_lat <= haddr_b;
      hsel_lat    <= hsel;
      hsel_b_lat  <= hsel_b;
    end
  end

  always @(posedge hclk or negedge hresetn) begin 
    if (hresetn == 1'b0) begin
      hsize_lat   <= 4'b0;
      hsize_b_lat <= 4'b0;
    end
    else begin
      hsize_lat   <= hsize;
      hsize_b_lat <= hsize_b;
    end
  end




//-----------------------------------------------
// Logic for generating sram addr/control signals
//-----------------------------------------------

always@*  begin
  ahb_ns      = 5'b0_0000;
  sram_sel    = 1'b0;
  sram_b_sel  = 1'b0;
  sram_we     = 1'b0;
  sram_b_we   = 1'b0;
  haddr_loc   = 16'b0;
  haddr_b_loc = 16'b0;
  hsize_loc   = 4'b0;
  hsize_b_loc = 4'b0;
  case (1'b1)
    ahb_ps[IDLE] : begin
      if (hsel | hsel_b) begin
        if (dec_err == 1'b1) begin
          ahb_ns[ERROR] = 1'b1;
        end
        else if (hwrite | hwrite_b) begin
          ahb_ns[READ] = 1'b1;
          sram_sel     = hsel;
          sram_b_sel   = hsel_b;
          haddr_loc    = haddr[ADDRWIDTH-1 :0];
          haddr_b_loc  = haddr_b[ADDRWIDTH-1 :0];
          hsize_loc    = hsize[3:0];
          hsize_b_loc  = hsize_b[3:0];
        end
        else begin
          ahb_ns[WRITE] = 1'b1;
        end
      end
      else begin
        ahb_ns[IDLE] = 1'b1;
      end
    end //IDLE
    ahb_ps[READ] : begin
      if (hsel | hsel_b) begin
        if (dec_err == 1'b1) begin
          ahb_ns[ERROR] = 1'b1;
        end
        else if (hwrite | hwrite_b) begin
          ahb_ns[READ] = 1'b1;
          sram_sel     = hsel;
          sram_b_sel   = hsel_b;
          haddr_loc    = haddr[ADDRWIDTH-1 :0];
          haddr_b_loc  = haddr_b[ADDRWIDTH-1 :0];
          hsize_loc    = hsize[3:0];
          hsize_b_loc  = hsize_b[3:0];
        end
        else begin
          ahb_ns[WRITE] = 1'b1;
        end
      end
      else begin
        ahb_ns[IDLE] = 1'b1;
      end
    end //READ
    ahb_ps[WRITE] : begin
      sram_sel    = hsel_lat;
      sram_b_sel  = hsel_b_lat;
      sram_we     = 1'b1;
      sram_b_we   = 1'b1;
      haddr_b_loc = haddr_b_lat[ADDRWIDTH-1 :0];
      hsize_loc   = hsize_lat[3:0];
      hsize_b_loc = hsize_b_lat[3:0];
      if (hsel | hsel_b) begin
        if (dec_err == 1'b1) begin
          ahb_ns[ERROR] = 1'b1;
        end
        else if (hwrite | hwrite_b) begin
          ahb_ns[WAIT] = 1'b1;
        end
        else begin
          ahb_ns[WRITE] = 1'b1;
        end
      end
      else begin
        ahb_ns[IDLE] = 1'b1;
      end
    end //WRITE
    ahb_ps[WAIT] : begin
      sram_sel     = hsel_lat;
      sram_b_sel   = hsel_b_lat;
      haddr_loc    = haddr_lat[ADDRWIDTH-1 :0];
      haddr_b_loc  = haddr_b_lat[ADDRWIDTH-1 :0];
      hsize_loc    = hsize_lat[3:0];
      hsize_b_loc  = hsize_b_lat[3:0];
      ahb_ns[IDLE] = 1'b1;
    end //WAIT
    ahb_ps[ERROR] : begin
      ahb_ns[IDLE] = 1'b1;
    end //ERROR
    default  : begin
      sram_sel     = 1'b0;
      sram_b_sel   = 1'b0;
      sram_we      = 1'b0;
      sram_b_we    = 1'b0;
      haddr_loc    = 16'b0;
      haddr_b_loc  = 16'b0;
      ahb_ns[IDLE] = 1'b1;
    end //ERROR
  endcase
end

 
  always @ (posedge hclk or negedge hresetn) begin
    if (hresetn == 1'b0) begin
      ahb_ps <= 5'b0_0001;
    end
    else begin
      ahb_ps  <= ahb_ns;
    end
  end

//----------------------------
// hsize
// 0000 - byte
// 0001 - hword
// 0010 - word
// 1000 - 128 bit
//----------------------------
//-----------------------------------------------
// Memory Instantiation
//-----------------------------------------------

generate
  for (i=0; i<NUM_MEM; i=i+1) begin
     assign sram_cs_n[i]     =   hsize_loc[2]             ? ~sram_sel          : ((haddr_loc[3:2] == i)   ? ~sram_sel   : 1'b1);
     assign sram00_cs_n[i]   =  ~haddr_loc[ADDRWIDTH-1]   ?  sram_cs_n[i]      : 1'b1;
     assign sram10_cs_n[i]   =   haddr_loc[ADDRWIDTH-1]   ?  sram_cs_n[i]      : 1'b1;
     assign sram_we_n[i]     =   hsize_loc[2]             ? ~sram_we           : ((haddr_loc[3:2]   == i) ? ~sram_we    : 1'b1);
     assign sram_rdata[i]    =  ~sram00_cs_n_lat[i]       ?  sram00_rdata[i]   : sram10_rdata[i];

     assign sram_b_cs_n[i]   =   hsize_b_loc[2]           ? ~sram_b_sel        : ((haddr_b_loc[3:2] == i) ? ~sram_b_sel : 1'b1);
     assign sram00_b_cs_n[i] =  ~haddr_b_loc[ADDRWIDTH-1] ?  sram_b_cs_n[i]    : 1'b1;
     assign sram10_b_cs_n[i] =   haddr_b_loc[ADDRWIDTH-1] ?  sram_b_cs_n[i]    : 1'b1;
     assign sram_b_we_n[i]   =   hsize_b_loc[2]           ? ~sram_b_we         : ((haddr_b_loc[3:2] == i) ? ~sram_b_we  : 1'b1);
     assign sram_rdata_b[i]  =  ~sram00_b_cs_n_lat[i]     ?  sram00_b_rdata[i] : sram10_b_rdata[i];

     assign hrdata_loc[32*(i+1)-1   : 32*(i+1)-32] = sram_rdata[i];
     assign hrdata_b_loc[32*(i+1)-1 : 32*(i+1)-32] = sram_b_rdata[i];

     assign hwdata_sram_loc[i]     = hsize_lat[2]   ? hwdata[32*(i+1)-1   : 32*(i+1)-32] : hwdata[31:0];
     assign hwdata_b_sram_loc[i]   = hsize_b_lat[2] ? hwdata_b[32*(i+1)-1 : 32*(i+1)-32] : hwdata_b[31:0];

    `ifdef FPGA_SYNTH
     dp_ram_16x4k_blk_mem_gen_0_0 \genblk1[0].u_sram00_dp_16x2048 (
       .clka       (hclk),
       .ena        (~sram00_cs_n[i]),
       .wea        (~sram_we_n[i]),
       .addra      (haddr_loc[ADDRWIDTH-2 :4]),
       .dina       (hwdata_sram_loc[i][15:0]),
       .douta      (sram00_rdata[i][15:0]),
       .clkb       (hclk),
       .enb        (~sram00_b_cs_n[i]),   //(CENB),
       .web        (~sram_b_we_n[i]),    //(WENB),
       .addrb      (haddr_b_loc[ADDRWIDTH-2 :4]),  //(AB),
       .dinb       (hwdata_b_sram_loc[i][15:0]),  //(DB),
       .doutb      (sram00_b_rdata[i][15:0])        //(QB),    
     );

     dp_ram_16x4k_blk_mem_gen_0_0 \genblk1[0].u_sram01_dp_16x2048 (
       .clka       (hclk),
       .ena        (~sram00_cs_n[i]),
       .wea        (~sram_we_n[i]),
       .addra      (haddr_loc[ADDRWIDTH-2 :4]),
       .dina       (hwdata_sram_loc[i][31:16]),
       .douta      (sram00_rdata[i][31:16]),
       .clkb       (hclk),
       .enb        (~sram00_b_cs_n[i]),   //(CENB), (CENB),
       .web        (~sram_b_we_n[i]),   //(WENB), (WENB),
       .addrb      (haddr_b_loc[ADDRWIDTH-2 :4]),  //(AB),   (AB),
       .dinb       (hwdata_b_sram_loc[i][31:16]),  //(DB),   (DB),
       .doutb      ((sram00_b_rdata[i][31:16])       //(QB),   (QB),
     );

dp_ram_16x4k_blk_mem_gen_0_0 \genblk1[0].u_sram10_dp_16x2048 (
       .clka       (hclk),
       .ena        (~sram10_cs_n[i]),
       .wea        (~sram_we_n[i]),
       .addra      (haddr_loc[ADDRWIDTH-2 :4]),
       .dina       (hwdata_sram_loc[i][15:0]),
       .douta      (sram10_rdata[i][15:0]),
       .clkb       (hclk),
       .enb        (~sram10_b_cs_n[i),   //(CENB), (CENB),
       .web        (~sram_b_we_n[i]),   //(WENB), (WENB),
       .addrb      (haddr_b_loc[ADDRWIDTH-2 :4]),  //(AB),   (AB),
       .dinb       (hwdata_b_sram_loc[i][15:0]),  //(DB),   (DB),
       .doutb      (sram10_b_rdata[i][15:0])                       //(QB),   (QB),
     );

     dp_ram_16x4k_blk_mem_gen_0_0 \genblk1[0].u_sram11_dp_16x2048 (
       .clka       (hclk),
       .ena        (~sram10_cs_n[i]),
       .wea        (~sram_we_n[i]),
       .addra      (haddr_loc[ADDRWIDTH-2 :4]),
       .dina       (hwdata_sram_loc[i][31:16]),
       .douta      (sram10_rdata[i][31:16]),
       .clkb       (hclk),
       .enb        (~sram10_b_cs_n[i]),   //(CENB), (CENB),
       .web        (~sram_b_we_n[i]),   //(WENB), (WENB),
       .addrb      (haddr_b_loc[ADDRWIDTH-2 :4]),  //(AB),   (AB),
       .dinb       (hwdata_b_sram_loc[i][31:16]),  //(DB),   (DB),
       .doutb      (sram10_b_rdata[i][31:16])                      //(QB),   (QB),
     );




    `else
     sram_dp_16x4096 u_sram00_dp_16x4096 (
       .CLKA            (hclk),
       .CENA            (sram00_cs_n[i]),
       .WENA            (sram_we_n[i]),
       .AA              (haddr_loc[ADDRWIDTH-2 :4]),
       .DA              (hwdata_sram_loc[i][15:0]),
       .QA              (sram00_rdata[i][15:0]),
       .CLKB            (hclk),
       .CENB            (sram00_b_cs_n[i]),   //(CENB),
       .WENB            (sram_b_we_n[i]),   //(WENB),
       .AB              (haddr_b_loc[ADDRWIDTH-2 :4]),  //(AB),
       .DB              (hwdata_b_sram_loc[i][15:0]),  //(DB),
       .QB              (sram00_b_rdata[i][15:0]),       //(QB),    
       .EMAA            ({~sram_ctl[10], sram_ctl[9], sram_ctl[8]}),
       .EMAWA           (sram_ctl[12:11]),
       .EMAB            ({~sram_ctl[10], sram_ctl[9], sram_ctl[8]}),
       .EMAWB           (sram_ctl[12:11]),
       .TENA            (~sram_ctl[0]),
       .TCENA           (~sram_ctl[1]),
       .TWENA           (sram_ctl[2]),
       .TAA             ({sram_ctl[16:13], {(ADDRWIDTH-9){1'b0}}}),
       .TDA             ({7'b0, sram_ctl[14], 7'b0, sram_ctl[13]}),
       .TENB            (~sram_ctl[0]),
       .TCENB           (~sram_ctl[1]),
       .TWENB           (sram_ctl[2]),
       .TAB             ({sram_ctl[16:13], {(ADDRWIDTH-9){1'b0}}}),
       .TDB             ({7'b0, sram_ctl[14], 7'b0, sram_ctl[13]}),
       .RET1N           (~sram_ctl[3]),
       .SEA             (1'b0), //(sram_ctl[4]),
       .SIA             (2'b0), //(sram_ctl[7:6]),
       .SOA             (),
       .SEB             (1'b0), //(sram_ctl[4]),
       .SOB             (),
       .SIB             (2'b0), //(sram_ctl[7:6]),
       .CENYA           (),
       .WENYA           (),
       .AYA             (),
       .CENYB           (),
       .WENYB           (),
       .AYB             (),
       .DFTRAMBYP       (sram_ctl[5]),
       .COLLDISN        (sram_ctl[4])
     );

     sram_dp_16x4096 u_sram01_dp_16x4096 (
       .CLKA            (hclk),
       .CENA            (sram00_cs_n[i]),
       .WENA            (sram_we_n[i]),
       .AA              (haddr_loc[ADDRWIDTH-2 :4]),
       .DA              (hwdata_sram_loc[i][31:16]),
       .QA              (sram00_rdata[i][31:16]),
       .CLKB            (hclk),
       .CENB            (sram00_b_cs_n[i),   //(CENB), (CENB),
       .WENB            (sram_b_we_n[i]),   //(WENB), (WENB),
       .AB              (haddr_b_loc[ADDRWIDTH-2 :4]),  //(AB),   (AB),
       .DB              (hwdata_b_sram_loc[i][31:16]),  //(DB),   (DB),
       .QB              (sram00_b_rdata[i][31:16]),       //(QB),   (QB),
       .EMAA            ({~sram_ctl[10], sram_ctl[9], sram_ctl[8]}),
       .EMAWA           (sram_ctl[12:11]),
       .EMAB            ({~sram_ctl[10], sram_ctl[9], sram_ctl[8]}),
       .EMAWB           (sram_ctl[12:11]),
       .TENA            (~sram_ctl[0]),
       .TCENA           (~sram_ctl[1]),
       .TWENA           (sram_ctl[2]),
       .TAA             ({sram_ctl[16:13], {(ADDRWIDTH-9){1'b0}}}),
       .TDA             ({7'b0, sram_ctl[14], 7'b0, sram_ctl[13]}),
       .TENB            (~sram_ctl[0]),
       .TCENB           (~sram_ctl[1]),
       .TWENB           (sram_ctl[2]),
       .TAB             ({sram_ctl[16:13], {(ADDRWIDTH-9){1'b0}}}),
       .TDB             ({7'b0, sram_ctl[14], 7'b0, sram_ctl[13]}),
       .RET1N           (~sram_ctl[3]),
       .SEA             (1'b0), //(sram_ctl[4]),
       .SIA             (2'b0), //(sram_ctl[7:6]),
       .SOA             (),
       .SEB             (1'b0), //(sram_ctl[4]),
       .SOB             (),
       .SIB             (2'b0), //(sram_ctl[7:6]),
       .CENYA           (),
       .WENYA           (),
       .AYA             (),
       .CENYB           (),
       .WENYB           (),
       .AYB             (),
       .DFTRAMBYP       (sram_ctl[5]),
       .COLLDISN        (sram_ctl[4])
     );

sram_dp_16x4096 u_sram10_dp_16x4096 (
       .CLKA            (hclk),
       .CENA            (sram10_cs_n[i]),
       .WENA            (sram_we_n[i]),
       .AA              (haddr_loc[ADDRWIDTH-2 :4]),
       .DA              (hwdata_sram_loc[i][15:0]),
       .QA              (sram10_rdata[i][15:0]),
       .CLKB            (hclk),
       .CENB            (sram10_b_cs_n[i]),   //(CENB), (CENB),
       .WENB            (sram_b_we_n[i]),   //(WENB), (WENB),
       .AB              (haddr_b_loc[ADDRWIDTH-2 :4]),  //(AB),   (AB),
       .DB              (hwdata_b_sram_loc[i][15:0]),  //(DB),   (DB),
       .QB              (sram10_b_rdata[i][15:0]),       //(QB),   (QB),
       .EMAA            ({~sram_ctl[10], sram_ctl[9], sram_ctl[8]}),
       .EMAWA           (sram_ctl[12:11]),
       .EMAB            ({~sram_ctl[10], sram_ctl[9], sram_ctl[8]}),
       .EMAWB           (sram_ctl[12:11]),
       .TENA            (~sram_ctl[0]),
       .TCENA           (~sram_ctl[1]),
       .TWENA           (sram_ctl[2]),
       .TAA             ({sram_ctl[16:13], {(ADDRWIDTH-9){1'b0}}}),
       .TDA             ({7'b0, sram_ctl[14], 7'b0, sram_ctl[13]}),
       .TENB            (~sram_ctl[0]),
       .TCENB           (~sram_ctl[1]),
       .TWENB           (sram_ctl[2]),
       .TAB             ({sram_ctl[16:13], {(ADDRWIDTH-9){1'b0}}}),
       .TDB             ({7'b0, sram_ctl[14], 7'b0, sram_ctl[13]}),
       .RET1N           (~sram_ctl[3]),
       .SEA             (1'b0), //(sram_ctl[4]),
       .SIA             (2'b0), //(sram_ctl[7:6]),
       .SOA             (),
       .SEB             (1'b0), //(sram_ctl[4]),
       .SOB             (),
       .SIB             (2'b0), //(sram_ctl[7:6]),
       .CENYA           (),
       .WENYA           (),
       .AYA             (),
       .CENYB           (),
       .WENYB           (),
       .AYB             (),
       .DFTRAMBYP       (sram_ctl[5]),
       .COLLDISN        (sram_ctl[4])
     );

     sram_dp_16x4096 u_sram11_dp_16x4096 (
       .CLKA            (hclk),
       .CENA            (sram10_cs_n[i]),
       .WENA            (sram_we_n[i]),
       .AA              (haddr_loc[ADDRWIDTH-2 :4]),
       .DA              (hwdata_sram_loc[i][31:16]),
       .QA              (sram10_rdata[i][31:16]),
       .CLKB            (hclk),
       .CENB            (sram10_b_cs_n[i]),   //(CENB), (CENB),
       .WENB            (sram_b_we_n[i]),   //(WENB), (WENB),
       .AB              (haddr_b_loc[ADDRWIDTH-2 :4]),  //(AB),   (AB),
       .DB              (hwdata_b_sram_loc[i][31:16]),  //(DB),   (DB),
       .QB              (sram10_b_rdata[i][31:16]),       //(QB),   (QB),
       .EMAA            ({~sram_ctl[10], sram_ctl[9], sram_ctl[8]}),
       .EMAWA           (sram_ctl[12:11]),
       .EMAB            ({~sram_ctl[10], sram_ctl[9], sram_ctl[8]}),
       .EMAWB           (sram_ctl[12:11]),
       .TENA            (~sram_ctl[0]),
       .TCENA           (~sram_ctl[1]),
       .TWENA           (sram_ctl[2]),
       .TAA             ({sram_ctl[16:13], {(ADDRWIDTH-9){1'b0}}}),
       .TDA             ({7'b0, sram_ctl[14], 7'b0, sram_ctl[13]}),
       .TENB            (~sram_ctl[0]),
       .TCENB           (~sram_ctl[1]),
       .TWENB           (sram_ctl[2]),
       .TAB             ({sram_ctl[16:13], {(ADDRWIDTH-9){1'b0}}}),
       .TDB             ({7'b0, sram_ctl[14], 7'b0, sram_ctl[13]}),
       .RET1N           (~sram_ctl[3]),
       .SEA             (1'b0), //(sram_ctl[4]),
       .SIA             (2'b0), //(sram_ctl[7:6]),
       .SOA             (),
       .SEB             (1'b0), //(sram_ctl[4]),
       .SOB             (),
       .SIB             (2'b0), //(sram_ctl[7:6]),
       .CENYA           (),
       .WENYA           (),
       .AYA             (),
       .CENYB           (),
       .WENYB           (),
       .AYB             (),
       .DFTRAMBYP       (sram_ctl[5]),
       .COLLDISN        (sram_ctl[4])
     );


     
    `endif
  end


endgenerate

//-----------------------------------------------
// Read data logic
//-----------------------------------------------
   
  always @ (posedge hclk or negedge hresetn) begin
    if (hresetn == 1'b0) begin
      sram_cs_n_lat   <= {NUM_MEM{1'b1}};
      sram00_cs_n_lat <= {NUM_MEM{1'b1}};
      sram10_cs_n_lat <= {NUM_MEM{1'b1}};
    end
    else begin
      sram_cs_n_lat   <= sram_cs_n   | ~sram_we_n;
      sram00_cs_n_lat <= sram00_cs_n | ~sram_we_n;
      sram10_cs_n_lat <= sram10_cs_n | ~sram_we_n;
    end
  end

  always@* begin
      hrdata_lsw   = 128'b0;
      hrdata_b_lsw = 128'b0;
    for (j=0; j< NUM_MEM; j=j+1) begin
      hrdata_lsw[31:0]   = hrdata_lsw[31:0]   | ({32{~sram_cs_n_lat[j]}} & sram_rdata[j]);
      hrdata_b_lsw[31:0] = hrdata_b_lsw[31:0] | ({32{~sram_cs_n_lat[j]}} & sram_b_rdata[j]);
    end
  end

  assign hrdata   = hsize_lat[2]   ? hrdata_loc   : hrdata_lsw;
  assign hrdata_b = hsize_b_lat[2] ? hrdata_b_loc : hrdata_b_lsw;


//------------------------------------
// Logic to generate hresp and hready
//------------------------------------
   
  always @ (posedge hclk or negedge hresetn) begin
    if (hresetn == 1'b0) begin
      hready   <= 1'b1;
      hready_b <= 1'b1;
    end
    else if (ahb_ns[ERROR] | ahb_ns[WAIT]) begin
      hready   <= ~hsel;
      hready_b <= ~hsel_b;
    end
    else begin
      hready   <= 1'b1;
      hready_b <= 1'b1;
    end
  end

  assign hresp_b  = hresp;
  
  always @ (posedge hclk or negedge hresetn) begin
    if (hresetn == 1'b0) begin
      hresp  <= 1'b0;
    end
    else if (ahb_ns[ERROR] | ahb_ps[ERROR]) begin
      hresp  <= 1'b1;
    end
    else begin
      hresp  <= 1'b0;
    end
  end


endmodule
