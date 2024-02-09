`timescale 1 ns/1 ps
module butterfly #(
  parameter PBITS = 2,
  parameter NBITS = 256) (
  input  wire                hclk,
  input  wire                hresetn,
  input  wire                valid,
  input  wire [NBITS-1 :0]   ar,
  input  wire [NBITS-1 :0]   br,
  input  wire [NBITS-1 :0]   wr,
  output reg  [NBITS-1 :0]   xr,
  output reg  [NBITS-1 :0]   yr,
  input  wire [NBITS-1 :0]   mod,
  input  wire [2*NBITS-1 :0] baret_mdk,
  input  wire [NBITS-1+PBITS :0] mx3,
  input  wire [2:0]          mode,
  output reg                 done_p
);

wire [NBITS-1:0] tr;
wire [2*NBITS-1:0] y_nom_mul;
wire [NBITS-1:0] tr_loc;

wire [NBITS-1 :0] wr_loc;
wire [NBITS-1 :0] ar_loc;
wire done_p_loc;

wire [NBITS :0] xr_loc;
wire [NBITS :0] xr_loc_submod;
wire [NBITS :0] yr_loc;


`ifdef MOD_MUL_IL

  mod_mul_il #(
    .NBITS (NBITS),
    .PBITS (PBITS)
   ) u_mod_mul_il_inst (
    .clk      (hclk),       //input               
    .rst_n    (hresetn),    //input               
    .enable_p (~mode[1] & valid),      //input               
    .b        (br),         //input  [NBITS-1 :0] 
    .a        (wr_loc),     //input  [NBITS-1 :0] 
    .m        (mod),        //input  [NBITS-1 :0] 
    .mx3      (mx3),        //input  [NBITS-1 :0] 
    .y        (tr),         //output [NBITS-1 :0] 
    .done_p   (done_p_mul)      //output              
  );

`else

  mod_mul #(
    .NBITS (NBITS),
    .PBITS (PBITS)
   ) u_mod_mul_inst (
    .clk          (hclk),                  //input               
    .rst_n        (hresetn),               //input               
    .enable_p     (~mode[1] & valid),      //input               
    .nmul         (mode[2]),      //input               
    .b            (br),                    //input  [NBITS-1 :0] 
    .a            (wr_loc),                //input  [NBITS-1 :0] 
    .m            (mod),                   //input  [NBITS-1 :0] 
    .k            (baret_mdk[NBITS + 32 + (2*$clog2(NBITS)-1) : NBITS+32]),
    .md           (baret_mdk[NBITS+32-1   :0]),
    .y            (tr),                //output [NBITS-1 :0] 
    .y_nom_mul    (y_nom_mul),     //output [2*NBITS-1 :0] 
    .done_nom_mul (done_nom_mul),  //output              
    .done_irq_p   (done_p_mul)     //output              
  );

`endif



localparam NTTMODE = 3'b000;
localparam MULMODE = 3'b001;
localparam ADDMODE = 3'b010;
localparam SUBMODE = 3'b011;
localparam NOMMODE = 3'b100;

//mode 
//000 ntt
//001 mul
//010 add
//011 sub

reg [NBITS-1 :0] ar_lat [4:0];
reg done_p_d;


always@ (posedge hclk or negedge hresetn) begin
  if (hresetn == 1'b0) begin
    ar_lat[0] <= 0;
    ar_lat[1] <= 0;
    ar_lat[2] <= 0;
    ar_lat[3] <= 0;
    ar_lat[4] <= 0;
  end
  else begin
    ar_lat[0] <= ar;
    ar_lat[1] <= ar_lat[0];
    ar_lat[2] <= ar_lat[1];
    ar_lat[3] <= ar_lat[2];
    ar_lat[4] <= ar_lat[3];
  end  
end



assign wr_loc     =  (mode == NTTMODE) ? wr : ar;
assign ar_loc     =  (mode == NTTMODE) ? ar_lat[4] : ar;
assign tr_loc     = ((mode == NTTMODE) || (mode == MULMODE)) ? tr         : br;   //butterfly or addition/sub
assign done_p_loc = ((mode == NTTMODE) || (mode == MULMODE) || (mode == NOMMODE)) ? done_p_mul : valid;   //butterfly or addition/sub

assign xr_loc        = ar_loc + tr_loc;
assign xr_loc_submod = ar_loc + tr_loc - mod;
assign yr_loc        = ar_loc - tr_loc;

always@ (posedge hclk or negedge hresetn) begin
  if (hresetn == 1'b0) begin
    xr <= 0;
  end
  else begin
    if (done_p_loc == 1'b1) begin
      if (mode == NOMMODE) begin
        xr <= y_nom_mul[NBITS-1 :0];
      end
      if (xr_loc_submod[NBITS] == 1'b1) begin
        xr <= xr_loc[NBITS-1 :0];
      end
      else begin
        xr <= xr_loc_submod[NBITS-1 :0];
      end
    end
  end  
end

always@ (posedge hclk or negedge hresetn) begin
  if (hresetn == 1'b0) begin
    done_p <= 1'b0;
  end
  else begin
    done_p <= done_p_loc;
  end  
end




always@ (posedge hclk or negedge hresetn) begin
  if (hresetn == 1'b0) begin
    yr <= 0;
  end
  else begin
    if (done_p_loc == 1'b1) begin
      if ((mode == NTTMODE) || (mode == SUBMODE)) begin  //butterfly or multiplication
        if (yr_loc[NBITS] == 1'b1) begin
          yr <= yr_loc + mod;
        end
        else begin
          yr <= yr_loc[NBITS-1 :0];
        end
      end
      else if (mode == NOMMODE) begin
        yr <= y_nom_mul[2*NBITS-1 :NBITS];
      end
      else begin  //multiplication only
        yr <= tr_loc;
      end
    end
  end  
end


endmodule 
