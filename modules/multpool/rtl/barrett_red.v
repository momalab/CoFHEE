//---------------------------------------------------
//Barrett Reduction:
//High level idea is : a mod m = a - m * floor(a/m) 
//Approximate 1/m to md/2^k
// a mod m = a - m * (a*md/4^k)
//         = a - m * ((a*md) >> 2*k)
//---------------------------------------------------

module barrett_red  #(
  parameter NBITS = 128,
  parameter PBITS = 0

 ) (
  input                          clk,
  input                          rst_n,
  input                          enable_p,
  input  [2*NBITS-1 :0]          a,
  input  [NBITS-1 :0]            m,
  input  [2*$clog2(NBITS)-1:0]   k,
  input  [NBITS+32-1:0]          md,
  //input  [NBITS:0]               md,
  output reg                     done,
  output reg [NBITS-1 :0]        y
);


reg  [2*NBITS-1   :0]   a_loc;
reg  [3*NBITS+32-1 :0]  y_loc;
//reg  [3*NBITS :0]       y_loc;

wire  [NBITS :0]        y_loc_shftd;

reg enable_p_d1;
reg enable_p_d2;

reg  [NBITS :0]         y_red;
reg  [NBITS+1 :0]       y_red_sub_m;

always @ (posedge clk or negedge rst_n) begin
  if (rst_n == 1'b0) begin
    a_loc <= {2*NBITS{1'b0}};
    //y_loc <= {(3*NBITS+1){1'b0}};
    y_loc <= {(3*NBITS+32){1'b0}};
  end
  else begin
    if (enable_p == 1'b1) begin
      a_loc <= a;
      y_loc <= (a*md);
    end 
  end
end

always @ (posedge clk or negedge rst_n) begin
  if (rst_n == 1'b0) begin
    enable_p_d1 <= 1'b0;
    enable_p_d2 <= 1'b0;
    done        <= 1'b0;
  end
  else begin
    enable_p_d1 <= enable_p;
    enable_p_d2 <= enable_p_d1;
    done        <= enable_p_d2;
  end
end

assign  y_loc_shftd = y_loc >> k;


always @ (posedge clk or negedge rst_n) begin
  if (rst_n == 1'b0) begin
    y_red <= {2*NBITS{1'b0}};
  end
  else if (enable_p_d1 == 1'b1) begin
    y_red <= a_loc - y_loc_shftd*m;
  end
end

assign y_red_sub_m = y_red - m;



always @ (posedge clk or negedge rst_n) begin
  if (rst_n == 1'b0) begin
    y <= {NBITS{1'b0}};
  end
  else if (enable_p_d2 == 1'b1) begin
    if (y_red_sub_m[NBITS+1] == 1'b1) begin
      y <= y_red;
    end
    else begin
      y <= y_red_sub_m;
    end
  end
end


endmodule
