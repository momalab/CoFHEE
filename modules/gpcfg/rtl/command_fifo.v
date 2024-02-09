module command_fifo #(
  parameter RESET_VAL = 32'b0,
  parameter CFG_ADDR  = 16'h0,
  parameter DEPTH     = 16
  ) (
  input                hclk,
  input                hresetn,
  input                wr_en,
  input                rd_en,
  input       [3:0]    byte_en,
  input       [31:0]   wr_addr,
  input       [31:0]   rd_addr,
  input       [31:0]   wdata,
  output reg  [31:0]   wr_reg,
  output      [31:0]   rdata,
  input       [31:0]   mdmc_data,
  input                mdmc_done,
  output  wire         gate_utx,
  output  wire         dp_en,
  output  reg          trig_ntt,
  output  reg          trig_intt,
  output  reg          trig_mul,
  output  reg          trig_constmul,
  output  reg          trig_dma,
  output  reg          trig_sqr,
  output  reg          trig_nmul,
  output  reg          trig_add,
  output  reg          trig_sub,
  output  wire [7 :0]  base_addr_a,
  output  wire [7 :0]  base_addr_b,
  output  wire [7 :0]  base_addr_r
);


localparam DEPTHSUB1 = DEPTH-1;
localparam NTTMODE  = 4'd1;
localparam INTTMODE = 4'd2;
localparam MULMODE  = 4'd3;
localparam ADDMODE  = 4'd4;
localparam SUBMODE  = 4'd5;
localparam CMULMODE = 4'd6;
localparam DMAMODE  = 4'd7;
localparam SQRMODE  = 4'd8;
localparam NMULMODE = 4'd9;

reg [31:0] fifo_data [0 : DEPTH];
reg [4:0]  rd_cntr;
reg [4:0]  wr_cntr;
reg [31:0] fifo_rdata;
reg [31:0] fifo_rdata_lat;
reg rd_fifo_d;
reg wr_en_loc_d;
reg first_write;
reg waiting;

wire wr_en_loc;
wire rd_en_loc;
wire  fifo_full;
wire  fifo_empty;

wire [3:0] mode;

  always @ (posedge hclk or negedge hresetn) begin
    if (hresetn == 1'b0) begin
      wr_reg  <= RESET_VAL;
    end
    else begin
      if (wr_en_loc == 1'b1) begin
        wr_reg <= wdata;
      end
    end
  end

  assign wr_en_loc = wr_en && (wr_addr[15:0] == CFG_ADDR);
  assign rd_en_loc = rd_en && (rd_addr[15:0] == CFG_ADDR);

  assign rdata     = rd_en_loc ? fifo_rdata_lat : 32'b0;


assign rd_fifo = rd_en_loc | mdmc_done | first_write;

  always @ (posedge hclk or negedge hresetn) begin
    if (hresetn == 1'b0) begin
      wr_cntr  <= 5'b0;
    end
    else if(wr_en_loc & ~fifo_full)  begin
      wr_cntr <= wr_cntr + 1'b1;
    end
  end

  always @ (posedge hclk or negedge hresetn) begin
    if (hresetn == 1'b0) begin
      rd_cntr  <= 5'b0;
    end
    else if(rd_fifo & ~fifo_empty) begin
      rd_cntr <= rd_cntr + 1'b1;
    end
  end

genvar j;
generate
  for (j = 0; j < DEPTH; j = j + 1) begin

    always @ (posedge hclk or negedge hresetn) begin
      if (hresetn == 1'b0) begin
        fifo_data[j]  <= 32'b0;
      end
      else if(~fifo_full & wr_en_loc && (wr_cntr[3:0] == j)) begin
        fifo_data[j]  <= wdata;
      end
    end

  end
endgenerate

    always @* begin
      if (~fifo_empty && rd_fifo) begin
        fifo_rdata  <= fifo_data[rd_cntr[3:0]];
      end
      else begin
        fifo_rdata  <= 32'b0;
      end
    end



    always @ (posedge hclk or negedge hresetn) begin
      if (hresetn == 1'b0) begin
        fifo_rdata_lat  <= 32'b0;
      end
      else if(rd_fifo) begin
        fifo_rdata_lat  <= fifo_rdata;
      end
    end

    always @ (posedge hclk or negedge hresetn) begin
      if (hresetn == 1'b0) begin
        rd_fifo_d  <= 1'b0;
        first_write  <= 1'b0;
      end
      else begin
        rd_fifo_d    <= rd_fifo;
        first_write  <= (wr_en_loc & fifo_empty) & ~waiting;
      end
    end

    always @ (posedge hclk or negedge hresetn) begin
      if (hresetn == 1'b0) begin
        waiting  <= 1'b0;
      end
      else if (trig_ntt | trig_intt | trig_mul | trig_add | trig_sub | trig_constmul | trig_dma | trig_nmul | trig_sqr) begin
        waiting <= 1'b1;
      end
      else if (mdmc_done) begin
        waiting <= 1'b0;
      end
    end




assign fifo_empty = (rd_cntr[4] == wr_cntr[4]) && (rd_cntr[3:0] == wr_cntr[3:0])? 1'b1 : 1'b0;
assign fifo_full  = (rd_cntr[4] != wr_cntr[4]) && (rd_cntr[3:0] == wr_cntr[3:0])? 1'b1 : 1'b0;

//operand_a_addr 7:0     
//operand_b_addr 15:8
//result_r_addr  23:16
//mode           27:24
//misc           31:28


//mode 
//0000 ntt
//0001 intt
//0010 mul
//0011 add
//0100 sub
//0101 constmul


assign base_addr_a = fifo_rdata_lat[28] ? mdmc_data[7:0] : fifo_rdata_lat[7:0];  
assign base_addr_b = fifo_rdata_lat[29] ? mdmc_data[7:0] : fifo_rdata_lat[15:8];  
assign base_addr_r = fifo_rdata_lat[23:16];  

assign mode     = fifo_rdata_lat[27:24];
assign gate_utx = fifo_rdata_lat[30];
assign dp_en    = fifo_rdata_lat[31];


always @* begin
  case (mode)
    NTTMODE : begin
      trig_ntt  <= rd_fifo_d;
      trig_intt <= 1'b0;
      trig_mul  <= 1'b0;
      trig_add  <= 1'b0;
      trig_sub  <= 1'b0;
      trig_constmul <= 1'b0;
      trig_dma  <= 1'b0;
      trig_sqr  <= 1'b0;
      trig_nmul <= 1'b0;
    end
    INTTMODE : begin
      trig_ntt  <= 1'b0;
      trig_intt <= rd_fifo_d;
      trig_mul  <= 1'b0;
      trig_add  <= 1'b0;
      trig_sub  <= 1'b0;
      trig_constmul <= 1'b0;
      trig_dma  <= 1'b0;
      trig_sqr  <= 1'b0;
      trig_nmul <= 1'b0;
    end
    MULMODE : begin
      trig_ntt  <= 1'b0;
      trig_intt <= 1'b0;
      trig_mul  <= rd_fifo_d;
      trig_add  <= 1'b0;
      trig_sub  <= 1'b0;
      trig_constmul <= 1'b0;
      trig_dma  <= 1'b0;
      trig_sqr  <= 1'b0;
      trig_nmul <= 1'b0;
    end
    ADDMODE : begin
      trig_ntt  <= 1'b0;
      trig_intt <= 1'b0;
      trig_mul  <= 1'b0;
      trig_add  <= rd_fifo_d;
      trig_sub  <= 1'b0;
      trig_constmul <= 1'b0;
      trig_dma  <= 1'b0;
      trig_sqr  <= 1'b0;
      trig_nmul <= 1'b0;
    end
    SUBMODE : begin
      trig_ntt  <= 1'b0;
      trig_intt <= 1'b0;
      trig_mul  <= 1'b0;
      trig_add  <= 1'b0;
      trig_sub  <= rd_fifo_d;
      trig_constmul <= 1'b0;
      trig_dma  <= 1'b0;
      trig_sqr  <= 1'b0;
      trig_nmul <= 1'b0;
    end
    CMULMODE : begin
      trig_ntt  <= 1'b0;
      trig_intt <= 1'b0;
      trig_mul  <= rd_fifo_d;
      trig_add  <= 1'b0;
      trig_sub  <= 1'b0;
      trig_constmul <= rd_fifo_d;
      trig_dma  <= 1'b0;
      trig_sqr  <= 1'b0;
      trig_nmul <= 1'b0;
    end
    DMAMODE : begin
      trig_ntt  <= 1'b0;
      trig_intt <= 1'b0;
      trig_mul  <= 1'b0;
      trig_add  <= 1'b0;
      trig_sub  <= 1'b0;
      trig_constmul <= 1'b0;
      trig_dma  <= rd_fifo_d;
      trig_sqr  <= 1'b0;
      trig_nmul <= 1'b0;
    end
    SQRMODE : begin
      trig_ntt  <= 1'b0;
      trig_intt <= 1'b0;
      trig_mul  <= rd_fifo_d;
      trig_add  <= 1'b0;
      trig_sub  <= 1'b0;
      trig_constmul <= 1'b0;
      trig_dma  <= 1'b0;
      trig_sqr  <= rd_fifo_d;
      trig_nmul <= 1'b0;
    end
    NMULMODE : begin
      trig_ntt  <= 1'b0;
      trig_intt <= 1'b0;
      trig_mul  <= 1'b0;
      trig_add  <= 1'b0;
      trig_sub  <= 1'b0;
      trig_constmul <= 1'b0;
      trig_dma  <= 1'b0;
      trig_sqr  <= 1'b0;
      trig_nmul <= rd_fifo_d;
    end
    default : begin
      trig_ntt  <= 1'b0;
      trig_intt <= 1'b0;
      trig_mul  <= 1'b0;
      trig_add  <= 1'b0;
      trig_sub  <= 1'b0;
      trig_constmul <= 1'b0;
      trig_dma  <= 1'b0;
      trig_sqr  <= 1'b0;
      trig_nmul <= 1'b0;
    end
  endcase
end




endmodule
