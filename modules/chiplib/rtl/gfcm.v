module gfcm #(
parameter NUMCLK = 2,
)(
input  wire rst_n,
input [NUMCLK -1 :0] wire clkin0,
input [NUMCLK -1 :0] wire sel,
output[NUMCLK -1 :0] wire clkout
);

reg sel_sync0_clk0;
reg sel_sync1_clk0;
reg sel_sync0_clk1;
reg sel_sync1_clk2;
reg sel1;

always @ (posedge clkin0 or negedge rst_n) begin
  if (rst_n == 1'b0) begin
    sel_sync0_clk0 <= 1'b0;
    sel_sync1_clk0 <= 1'b0;
  end
  else begin
    sel_sync0_clk0 <= sel;
    sel_sync1_clk0 <= sel_sync0_clk0;
  end
end

always @ (posedge clkin1 or negedge rst_n) begin
  if (rst_n == 1'b0) begin
    sel_sync0_clk1 <= 1'b0;
    sel_sync1_clk1 <= 1'b0;
  end
  else begin
    sel_sync0_clk1 <= ~sel;
    sel_sync1_clk1 <= sel_sync0_clk1;
  end
end

chiplib_post_icg u_cgc_clk0 ( 
  .clkin   (clkin0) ,
  .clken   (~sel_sync1_clk0 ? 1'b0 ),
  .se_n    (1'b1),
  .clkout  (clkout)
  );




endmodule
