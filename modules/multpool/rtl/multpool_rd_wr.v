module multpool_rd_wr #(
parameter NBITS = 128,
parameter RESET_VAL = {3*NBITS{'b0}},
parameter CFG_ADDR = 16'd0) (
  input                       hclk,
  input                       hresetn,
  input                       wr_en,
  input                       rd_en,
  output                      rd_en_out,
  input       [31:0]          wr_addr,
  input       [31:0]          rd_addr,
  input       [3*NBITS-1:0]   wdata,
  input       [2*NBITS-1:0]   multpool_result,
  output reg  [3*NBITS-1:0]   wr_reg,
  output      [3*NBITS-1:0]   rdata,
  output wire                 trigmult
);

  reg  wr_en_loc;
  wire rd_en_loc;

  always @ (posedge hclk or negedge hresetn) begin
    if (hresetn == 1'b0) begin
      wr_reg  <= RESET_VAL;
    end
    else begin
      if (wr_en == 1'b1) begin
        if (wr_addr[15:0] == CFG_ADDR) begin
          wr_reg <= wdata;
        end
      end
    end
  end

  assign rd_en_loc = rd_en & (rd_addr[15:0] == CFG_ADDR);
  assign rdata     = rd_en_loc ? (rd_addr[16] ? wr_reg : {{NBITS{1'b0}}, multpool_result}) : {3*NBITS{1'b0}};


  always @ (posedge hclk or negedge hresetn) begin
    if (hresetn == 1'b0) begin
      wr_en_loc <= 1'b0;
    end
    else begin
      if (wr_addr[15:0] == CFG_ADDR) begin
        wr_en_loc <= wr_en;
      end
      else begin
        wr_en_loc <= 1'b0;
      end
    end
  end

assign trigmult  = wr_en_loc;
assign rd_en_out = rd_en_loc;

endmodule
