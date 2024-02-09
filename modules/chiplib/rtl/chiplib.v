module chiplib_mux2 ( 
  input  a,
  input  b,
  input  s,
  output y
  );

`ifdef FPGA_SYNTH
assign y = (s == 1'b1) ? b : a;
`else
  MX2_X4M_A9TH u_DONT_TOUCH_mux2_inst (
     .A   (a),
     .B   (b),
     .Y   (y),
     .S0  (s)
  );
`endif


endmodule

module chiplib_mux3 ( 
  input        a,
  input        b,
  input        c,
  input  [1:0] s,
  output       y
  );

`ifdef FPGA_SYNTH
assign y = (s == 2'b10) ? c : ((s == 2'b01) ? b : a);
`else
  MX2_X4M_A9TH u_DONT_TOUCH_mux2_inst0 (
     .A   (a),
     .B   (b),
     .Y   (y_int),
     .S0  (s[0])
  );

  MX2_X4M_A9TH u_DONT_TOUCH_mux2_inst1 (
     .A   (y_int),
     .B   (c),
     .Y   (y),
     .S0  (s[1])
  );
`endif

endmodule


module chiplib_mux4 ( 
  input        a,
  input        b,
  input        c,
  input        d,
  input  [1:0] s,
  output       y
  );

`ifdef FPGA_SYNTH
assign y = (s == 2'b11) ? d : ((s == 2'b10) ? c : ((s == 2'b01) ? b : a));
`else
  MX2_X4M_A9TH u_DONT_TOUCH_mux2_inst0 (
     .A   (a),
     .B   (b),
     .Y   (y_int1),
     .S0  (s[0])
  );

  MX2_X4M_A9TH u_DONT_TOUCH_mux2_inst1 (
     .A   (c),
     .B   (d),
     .Y   (y_int2),
     .S0  (s[0])
  );

  MX2_X4M_A9TH u_DONT_TOUCH_mux2_inst2 (
     .A   (y_int1),
     .B   (y_int2),
     .Y   (y),
     .S0  (s[1])
  );

`endif

endmodule

module chiplib_post_icg ( 
  input        clkin,
  input        clken,
  input        se_n,
  output       clkout
  );

    reg clkout_loc;

`ifdef FPGA_SYNTH
   always @* begin
     if (clkin == 1'b0) begin
       if (clken == 1'b1) begin
          clkout_loc <= clkin;
       end 
       else begin
         clkout_loc <= 1'b0;
       end
     end
   end

   assign clkout = clkout_loc;
`else
  POSTICG_X2B_A9TH u_DONT_TOUCH_post_icg_inst (.ECK (clkout), .CK (clkin), .E (clken), .SEN (se_n));
`endif

endmodule


