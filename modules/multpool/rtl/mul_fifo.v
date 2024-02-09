module mul_fifo #(
  parameter CFG_ADDR  = 16'h0,
  parameter DEPTH     = 16,
  parameter DWIDTH    = 128
  ) (
  input       hclk,
  input       hresetn,
  input       wr_en,
  input       rd_en,
  output      rd_en_out,
  output wire fifo_empty,
  input       [31:0]   rd_addr,
  input       [2*DWIDTH-1 :0] multpool_result,
  output      [3*DWIDTH-1 :0] rdata
);


localparam DEPTHSUB1 = DEPTH-1;

reg [2*DWIDTH-1:0] fifo_data [0 : DEPTH];
reg [2*DWIDTH-1:0] fifo_rdata;
reg [2*DWIDTH-1:0] fifo_rdata_lat;

reg [4:0]  rd_cntr;
reg [4:0]  wr_cntr;
reg        rd_fifo_d;
reg        wr_en_loc_d;

wire  wr_en_loc;
wire  rd_en_loc;
wire  fifo_full;

  assign wr_en_loc = wr_en;
  assign rd_en_loc = rd_en && (rd_addr[15:0] == CFG_ADDR);

  assign rdata     = {{DWIDTH{1'b0}}, fifo_rdata_lat};


assign rd_fifo = rd_en_loc;

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
        fifo_data[j]  <= {(2*DWIDTH){1'b0}};
      end
      else if(~fifo_full & wr_en_loc && (wr_cntr[3:0] == j)) begin
        fifo_data[j]  <= multpool_result;
      end
    end

  end
endgenerate

    always @* begin
      if (~fifo_empty && rd_fifo) begin
        fifo_rdata  <= fifo_data[rd_cntr[3:0]];
      end
      else begin
        fifo_rdata  <= {(2*DWIDTH/32){32'hDEADBEEF}};
      end
    end



    always @ (posedge hclk or negedge hresetn) begin
      if (hresetn == 1'b0) begin
        fifo_rdata_lat  <= {(2*DWIDTH){1'b0}};
      end
      else if(rd_fifo) begin
        fifo_rdata_lat  <= fifo_rdata;
      end
    end

    always @ (posedge hclk or negedge hresetn) begin
      if (hresetn == 1'b0) begin
        rd_fifo_d  <= 1'b0;
      end
      else begin
        rd_fifo_d    <= rd_fifo;
      end
    end




assign fifo_empty = (rd_cntr[4] == wr_cntr[4]) && (rd_cntr[3:0] == wr_cntr[3:0])? 1'b1 : 1'b0;
assign fifo_full  = (rd_cntr[4] != wr_cntr[4]) && (rd_cntr[3:0] == wr_cntr[3:0])? 1'b1 : 1'b0;

assign rd_en_out = rd_en_loc;


endmodule
