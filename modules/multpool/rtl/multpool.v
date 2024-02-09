module multpool #(
parameter NBITS = 128,
parameter PBITS = 2,
parameter NMUL  = 64) (  
  // CLOCK AND RESETS ------------------
  input   wire               hclk,              // Clock
  input   wire               hresetn,           // Asynchronous reset
 // AHB-LITE MASTER PORT --------------
  input   wire               hsel_wr,           // AHB transfer: non-sequential only
  input   wire [31:0]        haddr_wr,          // AHB transaction address
  input   wire [ 3:0]        hsize_wr,          // AHB size: byte, half-word or word
  input   wire [3*NBITS-1:0] hwdata_wr,         // AHB write-data
  input   wire               hwrite_wr,         // AHB write control
  output  wire               hready_wr,         // AHB stall signal
  output  reg                hresp_wr,          // AHB error response
 // AHB-LITE MASTER PORT --------------
  input   wire               hsel_rd,           // AHB transfer: non-sequential only
  input   wire [31:0]        haddr_rd,          // AHB transaction address
  input   wire [ 3:0]        hsize_rd,          // AHB size: byte, half-word or word
  input   wire               hwrite_rd,         // AHB write control
  output  wire [3*NBITS-1:0] hrdata_rd,         // AHB read-data
  output  wire               hready_rd,         // AHB stall signal
  output  reg                hresp_rd,          // AHB error response
  input   wire [NBITS-1:0]   modulus,
  input   wire [2*NBITS-1:0] baret_mdk,
  input   wire [NBITS-1:0]   invmodulus,
  input   wire [2:0]         mode,              // 00 : Buttefly, 01 : Multiplication, 10 : Add
  output  wire               fifo_empty,
  output  wire               mul_done
);


  //`include "multpool_addr_params.v"

//----------------------------------------------
//localparameter, genvar and wire/reg declaration
//----------------------------------------------

genvar i;

localparam LOG2NMUL = $clog2(NMUL);
parameter MAX_RDATA = 1024;

reg [3*NBITS  -1:0] rdata [0: MAX_RDATA-1];

reg [3*NBITS  -1:0] oprnd[0 : NMUL-1];

wire [2*NBITS  -1:0] multpool_result[0 : NMUL-1];
wire [NMUL-1:0]   trigmult;
wire [NMUL-1:0]   rd_en_out;
wire [NMUL-1:0]   done_p_loc;
reg  [NMUL-1:0]   done_p_loc_lat;
reg  [LOG2NMUL:0] done_p_loc_cnt;

reg [31:0] haddr_lat;
reg        valid_wr_lat;
wire       dec_err;

wire  [NBITS-1+PBITS :0] mx3;

//--------------------------
//Identify valid transaction
//--------------------------
  assign hresp_wr    = 1'b0;
  assign hresp_rd    = 1'b0;
  assign hready_wr   = 1'b1;
  assign hready_rd   = 1'b1;
  assign valid_wr = hsel_wr &  hwrite_wr & hready_wr;
  assign valid_rd = hsel_rd & ~hwrite_rd & hready_rd;

//--------------------------
//Capture write address
//--------------------------

  always @(posedge hclk or negedge hresetn) begin 
    if (hresetn == 1'b0) begin
      haddr_lat    <= 32'b0;
    end
    else if (valid_wr == 1'b1) begin
      haddr_lat    <= haddr_wr;
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


localparam INDX_START = 0;

generate
  for (i =0; i < NMUL; i =i +1) begin : multpool_rd_wr_gen
    multpool_rd_wr #( .RESET_VAL ({3*NBITS{1'b0}}), .CFG_ADDR (i), .NBITS (NBITS)) u_multpool_rd_wr_inst (
      .hclk    (hclk),                     .hresetn (hresetn),
      .wr_en   (valid_wr_lat),             .rd_en   (1'b0),
      .wr_addr (haddr_lat),                .rd_addr (haddr_rd),
      .wdata   (hwdata_wr),                .trigmult(trigmult[i]),
      .wr_reg  (oprnd[i][NBITS*3-1:0]),    .rdata   (),
      .rd_en_out (rd_en_out[i]),           .multpool_result (multpool_result[i]));


    mul_fifo #(
      .CFG_ADDR (i),
      .DEPTH    (16),
      .DWIDTH   (NBITS)
      ) u_mul_fifo_inst (
      .hclk             (hclk),
      .hresetn          (hresetn),
      .wr_en            (done_p_loc[i]),
      .rd_en            (valid_rd),
      .fifo_empty       (fifo_empty),
      .rd_en_out        (rd_en_out),
      .rd_addr          (haddr_rd),
      .multpool_result  (multpool_result[i]),   //[3*DWIDTH-1 :0] 
      .rdata            (hrdata_rd) //[3*DWIDTH-1 :0]  //TODO need to change this logi
    );
  end

endgenerate



localparam NUM_RDATA = NMUL;

//multpool_rdata_mux #(
//  .NBITS     (NBITS),
//  .NUM_RDATA (NUM_RDATA)) u_multpool_rdata_mux_inst (
//  .hclk      (hclk),
//  .hresetn   (hresetn),
//  .rdata     (rdata[0 :NUM_RDATA-1]),      //input  wire [31:0] 
//  .valid_rd  (valid_rd),
//  .hrdata    (hrdata_rd)                   //output reg  [31:0] 
//);
//

generate
  for (i =0; i < NMUL; i =i +1) begin : multpool_gen
    butterfly #(
      .NBITS (NBITS)) u_butterfly_inst (
      .hclk         (hclk),
      .hresetn      (hresetn),
      .valid        (trigmult[i]),
      .ar           (oprnd[i][NBITS-1 :0]),
      .br           (oprnd[i][2*NBITS-1 :NBITS]),
      .wr           (oprnd[i][3*NBITS-1 :2*NBITS]),
      .xr           (multpool_result[i][NBITS-1 :0]),
      .yr           (multpool_result[i][2*NBITS-1 :NBITS]),
      .mod          (modulus),
      .baret_mdk    (baret_mdk),
      .mx3          (mx3),
      .mode         (mode),
      .done_p       (done_p_loc[i])
    );
  end
endgenerate


  always @(posedge hclk or negedge hresetn) begin 
    if (hresetn == 1'b0) begin
      done_p_loc_lat <= {NMUL{1'b0}};
    end
    else if (|done_p_loc & |rd_en_out) begin
      done_p_loc_lat <= (done_p_loc_lat | done_p_loc) & ~rd_en_out;
    end
    else if (|done_p_loc) begin
      done_p_loc_lat <= done_p_loc_lat | done_p_loc;
    end
    else if (|rd_en_out) begin
      done_p_loc_lat <= done_p_loc_lat & ~rd_en_out;
    end 
  end



assign mx3 = modulus + {modulus, 1'b0};

assign mul_done = |done_p_loc;

endmodule
