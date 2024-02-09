`timescale 1 ns/1 ps
//----------------------------------------

module nom_mul #(
  parameter NBITS = 128,
  parameter PBITS = 0

 ) (
  input                 clk,
  input                 rst_n,
  input                 enable_p,
  input  [NBITS-1 :0]   a,
  input  [NBITS-1 :0]   b,
  output [2*NBITS-1 :0] y,
  output  reg           done
);

//--------------------------------------
//reg/wire declaration
//--------------------------------------

reg  [NBITS-1   :0]   a_loc;
reg  [NBITS-1   :0]   b_loc;
reg  [2*NBITS-1 :0]   y_loc;

reg  enable_p_d1;

always @ (posedge clk or negedge rst_n) begin
  if (rst_n == 1'b0) begin
    a_loc <= {NBITS{1'b0}};
    b_loc <= {NBITS{1'b0}};
  end
  else begin
      if (enable_p == 1'b1) begin
        a_loc <= a;
        b_loc <= b;
      end 
  end
end

always @ (posedge clk or negedge rst_n) begin
  if (rst_n == 1'b0) begin
    y_loc <= {2*NBITS{1'b0}};
  end
  else begin
    y_loc <= a_loc*b_loc;
  end
end

always @ (posedge clk or negedge rst_n) begin
  if (rst_n == 1'b0) begin
    done        <= 1'b0;
    enable_p_d1 <= 1'b0;
  end
  else begin
    enable_p_d1 <= enable_p;
    done        <= enable_p_d1;
  end
end



  
assign y  =  y_loc;



endmodule
