module gpcfg_rdata_mux #(
  parameter NUM_RDATA = 1024) (
  input  wire        hclk,              // Clock
  input  wire        hresetn,           // Asynchronous reset
  input  wire [31:0] rdata [0 :NUM_RDATA],
  input  wire        valid_rd,
  output wire [31:0] hrdata
);

reg [31:0] read_data_0;
reg [31:0] read_data_1;
reg [31:0] read_data_2;
reg [31:0] read_data_3;

reg [31:0] hrdata_loc_0;
reg [31:0] hrdata_loc_1;
reg [31:0] hrdata_loc_2;
reg [31:0] hrdata_loc_3;

localparam NRDATA_DIV4 = int'((NUM_RDATA)/4);

integer j;

always@* begin
  read_data_0  = 32'b0;
  for (j=0; j<=NRDATA_DIV4-1; j=j+1) begin
    read_data_0  = rdata[j][31:0] | read_data_0;
  end
end

always@* begin
  read_data_1  = 32'b0;
  for (j=NRDATA_DIV4; j<=2*NRDATA_DIV4-1; j=j+1) begin
    read_data_1  = rdata[j][31:0] | read_data_1;
  end
end

always@* begin
  read_data_2  = 32'b0;
  for (j=2*NRDATA_DIV4; j<=3*NRDATA_DIV4-1; j=j+1) begin
    read_data_2  = rdata[j][31:0] | read_data_2;
  end
end

always@* begin
  read_data_3  = 32'b0;
  for (j=3*NRDATA_DIV4; j<NUM_RDATA; j=j+1) begin
    read_data_3  = rdata[j][31:0] | read_data_3;
  end
end


always @ (posedge hclk or negedge hresetn) begin
  if (hresetn == 1'b0) begin
    hrdata_loc_0  <= 32'b0;
  end
  else if (valid_rd == 1'b1) begin
    hrdata_loc_0  <= read_data_0;
  end
  else begin
    hrdata_loc_0  <= 32'b0;
  end
end

always @ (posedge hclk or negedge hresetn) begin
  if (hresetn == 1'b0) begin
    hrdata_loc_1  <= 32'b0;
  end
  else if (valid_rd == 1'b1) begin
    hrdata_loc_1  <= read_data_1;
  end
  else begin
    hrdata_loc_1  <= 32'b0;
  end
end

always @ (posedge hclk or negedge hresetn) begin
  if (hresetn == 1'b0) begin
    hrdata_loc_2  <= 32'b0;
  end
  else if (valid_rd == 1'b1) begin
    hrdata_loc_2  <= read_data_2;
  end
  else begin
    hrdata_loc_2  <= 32'b0;
  end
end

always @ (posedge hclk or negedge hresetn) begin
  if (hresetn == 1'b0) begin
    hrdata_loc_3  <= 32'b0;
  end
  else if (valid_rd == 1'b1) begin
    hrdata_loc_3  <= read_data_3;
  end
  else begin
    hrdata_loc_3  <= 32'b0;
  end
end

assign hrdata = hrdata_loc_0 | hrdata_loc_1 | hrdata_loc_2 | hrdata_loc_3;



endmodule
