module clkdiv (
  input  wire clk,
  input  wire rst_n,
  input  wire [15:0] div,
  output wire clkdiv
);

reg [15:0] cnt;
reg        clkdiv_loc;
reg        diven;
reg        diven_d;


//No glitch free as it is only going out of the chip
chiplib_mux2 u_DONT_TOUCH_CLKMUX_inst ( 
  .a (clk),
  .b (clkdiv_loc),
  .s (diven_d),
  .y (clkdiv)
  );

always @ (posedge clk or negedge rst_n) begin
  if (rst_n == 1'b0) begin
    diven    <= 1'b0;
  end
  else begin
    if (div[15:1] == 15'b0) begin
      diven <= 1'b0;
    end
    else begin
      diven <= 1'b1;
    end
  end
end

always @ (negedge clk or negedge rst_n) begin
  if (rst_n == 1'b0) begin
    diven_d    <= 1'b0;
  end
  else begin
    diven_d <= diven;
  end
end

always @ (posedge clk or negedge rst_n) begin
  if (rst_n == 1'b0) begin
    cnt    <= 16'b1;
  end
  else begin
    if ((cnt == div) || (diven == 1'b0)) begin
      cnt <= 16'b1;
    end
    else begin
      cnt <= cnt + 1'b1;
    end
  end
end

always @ (posedge clk or negedge rst_n) begin
  if (rst_n == 1'b0) begin
    clkdiv_loc <= 1'b0;
  end
  else begin
    if (diven == 1'b0) begin
      clkdiv_loc <= 1'b0;
    end
    else if (cnt == {1'b0, div[15:1]}) begin
      clkdiv_loc <= 1'b1;
    end
    else if (cnt == div) begin
      clkdiv_loc <= 1'b0;
    end
  end
end


endmodule
