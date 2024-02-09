module spim_ahb (
  // CLOCK AND RESETS ------------------
  input  wire        hclk,              // Clock
  input  wire        hresetn,           // Asynchronous reset

  // AHB-LITE MASTER PORT --------------
  output reg  [31:0] haddr,             // AHB transaction address
  output wire [ 3:0] hsize,             // AHB size: byte, half-word or word
  output reg  [ 1:0] htrans,            // AHB transfer: sequential/non-sequential
  output reg  [ 2:0] hburst,            // AHB transfer: sequential/non-sequential
  output reg  [31:0] hwdata,            // AHB write-data
  output reg         hwrite,            // AHB write control
  input  wire [31:0] hrdata,            // AHB read-data
  input  wire        hready,            // AHB stall signal
  input  wire        hresp,             // AHB error response

  // SPI Interface ---------------------
  input  wire         i_rx_dv,
  input  wire [07:0]  i_rx_data,
  //
  input  wire         i_tx_ready,
  output reg          o_tx_dv,
  output reg  [07:0]  o_tx_data,

  //Debug
  output wire [31:0]   o_status,

  //Configuration registers
  output reg  [31:0]  o_write_burst, 
  output reg  [31:0]  o_write_bitwidth,
  output reg  [31:0]  o_read_burst,
  output reg  [31:0]  o_read_bitwidth
);


//-------------------------------------
//localparams, reg and wire declaration
//-------------------------------------
localparam IDLE       = 4'd0;
localparam MODE       = 4'd1; 
localparam LD_W_BITW  = 4'd2;
localparam LD_W_BSZ   = 4'd3;
localparam LD_W_ADDR  = 4'd4;
localparam LD_DATA    = 4'd5;
localparam LD_R_BITW  = 4'd6;
localparam LD_R_BSZ   = 4'd7;
localparam LD_R_ADDR  = 4'd8;
localparam RD_DATA    = 4'd9;
localparam RD_DATA2   = 4'd10;
//localparam LD_RW_BITW = 4'd11;
//localparam LD_RW_BSZ  = 4'd12;
//localparam LD_RW_ADDR = 4'd13;
//localparam LD_RW_DATA = 4'd14;
localparam WAIT       = 4'd15;

reg [31:0] haddr_write;
reg [31:0] haddr_read;
reg [31:0] write_burst;
reg [31:0] write_bitwidth;
reg [31:0] read_burst;
reg [31:0] read_bitwidth;
reg [07:0] mode;
reg [07:0] w_tx_data;
reg [31:0] w_hwdata;
reg        w_hwrite;
reg        w_tx_dv;
reg [01:0] w_htrans_write;
reg [01:0] htrans_write_d;
reg [01:0] w_htrans_write_ne;
reg [01:0] w_htrans_read;
reg [01:0] w_htrans_read_ne;
reg [01:0] htrans_read_ne_d;
reg [01:0] htrans_read_d;
reg [01:0] htrans_read_2d;
reg [01:0] w_htrans;
reg [01:0] htrans_d;
reg [02:0] w_hburst;
reg [31:0] w_haddr;

wire [31:0] w_hrdata;            // AHB read-data
reg [31:0] hrdata_d;            // AHB read-data

reg [31:0] haddr_write_d;
reg [31:0] haddr_read_d;
reg [07:0] mode_d;
reg        rx_dv_d;
reg        rx_dv_2d;
reg        rx_dv_3d;
reg        tx_dv_d;
reg        tx_dv_2d;
reg [07:0] rx_data_d;
reg        tx_ready_d;
reg        tx_ready_2d;
reg        tx_ready_ne;
reg        tx_ready_ne_d;

reg  [03:0] next_state;
reg  [03:0] curr_state_d;
reg  [01:0] read_byte_count;
reg  [01:0] read_byte_count_d;
reg  [31:0] write_byte_count;
reg  [31:0] write_byte_count_d;
reg  [31:0] write_data_count;
reg  [31:0] read_data_count;

always @(*) begin
  next_state = IDLE;
  //next_state = curr_state_d;
  case(curr_state_d) 
    IDLE:      begin
                 if(rx_dv_2d) begin
		     next_state = MODE;
		 end else begin
		     next_state = IDLE;
		 end
               end //IDLE
    MODE:      begin
		     if(mode_d == 'd0) begin
			 next_state = LD_DATA;
		     end else if(mode_d == 'd1) begin
		         next_state = LD_W_ADDR;
		     end else if(mode_d == 'd2) begin
		         next_state = LD_W_BSZ;
		     end else if(mode_d == 'd3) begin
		         next_state = LD_W_BITW;
		     end else if(mode_d == 'd4) begin
		         next_state = RD_DATA;
		     end else if(mode_d == 'd5) begin
		         next_state = LD_R_ADDR;
		     end else if(mode_d == 'd6) begin
		         next_state = LD_R_BSZ;
		     end else if(mode_d == 'd7) begin
		         next_state = LD_R_BITW;
		     end else begin
		         next_state = IDLE;
		     end
		 end //MODE
    LD_W_BITW: begin
	       if(rx_dv_2d && (write_byte_count_d == 'd4)) begin
		     next_state = LD_W_BSZ;
		 end else begin
		     next_state = LD_W_BITW;
		 end
               end //LD_W_BITW
    LD_W_BSZ : begin
                 if(rx_dv_2d && (write_byte_count_d == 'd4)) begin
		     next_state = LD_W_ADDR;
		 end else begin
		     next_state = LD_W_BSZ;
		 end
               end //LD_W_BSZ
    LD_W_ADDR: begin
                 if(rx_dv_2d && (write_byte_count_d == 'd4)) begin
		     next_state = LD_DATA;
		 end else begin
		     next_state = LD_W_ADDR;
		 end
               end //LD_W_ADDR
    LD_DATA  : begin
                 if(rx_dv_2d && (write_data_count == o_write_bitwidth*o_write_burst/8)) begin
		     next_state = IDLE;
		 end else begin
		     next_state = LD_DATA;
		 end
               end //LOAD_DATA
    LD_R_BITW: begin
                 if(rx_dv_2d && (write_byte_count_d == 'd4)) begin
		     next_state = LD_R_BSZ;
		 end else begin
		     next_state = LD_R_BITW;
		 end
               end //LD_R_BITW
    LD_R_BSZ : begin
                 if(rx_dv_2d && (write_byte_count_d == 'd4)) begin
		     next_state = LD_R_ADDR;
		 end else begin
		     next_state = LD_R_BSZ;
		 end
               end //LD_R_BSZ
    LD_R_ADDR: begin
                 if(rx_dv_2d && (write_byte_count_d == 'd4)) begin
		     next_state = RD_DATA;
		 end else begin
		     next_state = LD_R_ADDR;
		 end
               end //LD_R_ADDR
    RD_DATA  : begin
                 if((tx_ready_ne_d) && (read_data_count == (o_read_bitwidth*o_read_burst/8-1))) begin
		     next_state = RD_DATA2;
//		 end else if(rx_dv_d && rx_data_d == 'd03) begin
//		     next_state = LD_RW_BITW;
//		 end else if(rx_dv_d && rx_data_d == 'd02) begin
//		     next_state = LD_RW_BSZ;
//		 end else if(rx_dv_d && rx_data_d == 'd01) begin
//		     next_state = LD_RW_ADDR;
//		 end else if(rx_dv_d && rx_data_d == 'd00) begin
//		     next_state = LD_RW_DATA;
		 end else begin
		     next_state = RD_DATA;
		 end
               end //READ_DATA
    RD_DATA2 : begin
                 if(tx_ready_d) begin
		     next_state = IDLE;
		 end else begin
		     next_state = RD_DATA2;
		 end
               end //READ_DATA2
//    LD_RW_BITW: begin
//                 if(rx_dv_2d && (write_byte_count_d == 'd4)) begin
//		     next_state = LD_RW_BSZ;
//		 end else begin
//		     next_state = LD_RW_BITW;
//		 end
//               end //LD_RW_BITW
//    LD_RW_BSZ : begin
//                 if(rx_dv_2d && (write_byte_count_d == 'd4)) begin
//		     next_state = LD_RW_ADDR;
//		 end else begin
//		     next_state = LD_RW_BSZ;
//		 end
//               end //LD_RW_BSZ
//    LD_RW_ADDR: begin
//                 if(rx_dv_2d && (write_byte_count_d == 'd4)) begin
//		     next_state = LD_RW_DATA;
//		 end else begin
//		     next_state = LD_RW_ADDR;
//		 end
//               end //LD_RW_ADDR
//    LD_RW_DATA  : begin
//                 if(rx_dv_2d && (write_data_count == o_write_bitwidth*o_write_burst/8)) begin
//		     if(read_data_count < o_read_bitwidth*read_burst/8) begin
//		         next_state = RD_DATA;
//		     end else if(read_data_count == o_read_bitwidth*o_read_burst/8) begin
//		         next_state = RD_DATA2;
//		     end else begin
//		         next_state = IDLE;
//		     end
//		 end else begin
//		     next_state = LD_RW_DATA;
//		 end
//               end //LOAD_RW_DATA
    default  : begin
		next_state = IDLE;
               end //default
  endcase
end

assign w_hrdata = ((htrans_d == 2'd2) && !hwrite) ? hrdata : hrdata_d;
always @(*) begin
  if(next_state != curr_state_d) begin
      write_byte_count = 'd0;
  end else if(((curr_state_d==LD_DATA)/* || (curr_state_d==LD_RW_DATA)*/) && (rx_dv_d || rx_dv_2d) && (write_byte_count_d*8 == 32)) begin
      write_byte_count = 'd0;
  end else if(rx_dv_d) begin
      write_byte_count = write_byte_count_d + 'd1;
  end else begin
      write_byte_count = write_byte_count_d;
  end
end

always @(*) begin
  if((next_state != curr_state_d) && (curr_state_d < RD_DATA)) begin
      read_byte_count = 'd0;
  end else if(/*!tx_ready_d &&*/ (curr_state_d>=RD_DATA) && (tx_dv_2d) && (read_byte_count_d*8 == 32)) begin
      read_byte_count = 'd0;
  end else if(tx_dv_2d) begin
      read_byte_count = read_byte_count_d + 'd1;
  end else begin
      read_byte_count = read_byte_count_d;
  end
end

always @(posedge hclk or negedge hresetn) begin
  if(!hresetn) begin
      write_data_count <= 'd0;
  end else if(next_state != curr_state_d) begin
      write_data_count <= 'd0;
  end else if(((curr_state_d==LD_DATA)/* || (curr_state_d==LD_RW_DATA)*/) && rx_dv_d) begin
      write_data_count <= write_data_count + 'd1;
  end
end

always @(posedge hclk or negedge hresetn) begin
  if(!hresetn) begin
      read_data_count <= 'd0;
  end else if(next_state != curr_state_d && curr_state_d < RD_DATA) begin
      read_data_count <= 'd0;
  end else if((curr_state_d>=RD_DATA) && o_tx_dv) begin
      read_data_count <= read_data_count + 'd1;
  end
end

always @(*) begin
  if(rx_dv_d && ((curr_state_d==LD_W_BITW)/* || (curr_state_d==LD_RW_BITW)*/)) begin
      write_bitwidth = {o_write_bitwidth[23:0], rx_data_d};
  end else begin
      write_bitwidth = o_write_bitwidth;
  end
end

always @(*) begin
  if(rx_dv_d && ((curr_state_d==LD_W_BSZ)/* || (curr_state_d==LD_RW_BSZ)*/)) begin
  //if(rx_dv_d && (next_state==LD_W_BSZ)) begin
      write_burst = {o_write_burst[23:0], rx_data_d};
  end else begin
      write_burst = o_write_burst;
  end
end

always @(*) begin
  if(rx_dv_d && (curr_state_d==LD_R_BITW)) begin
      read_bitwidth = {o_read_bitwidth[23:0], rx_data_d};
  end else begin
      read_bitwidth = o_read_bitwidth;
  end
end

always @(*) begin
  if(rx_dv_d && (curr_state_d==LD_R_BSZ)) begin
      read_burst = {o_read_burst[23:0], rx_data_d};
  end else begin
      read_burst = o_read_burst;
  end
end

//always @(*) begin
//  if(rx_dv_d && ((curr_state_d==LD_R_ADDR)||(curr_state_d==LD_W_ADDR))) begin
//      haddr_write = {haddr_write_d[23:0], rx_data_d};
//  end else if(((curr_state_d==RD_DATA)||(curr_state_d==LD_DATA)) && (rx_dv_d || o_tx_dv)) begin
//      haddr_write = haddr_write_d + write_data_count;
//  end else begin
//      haddr_write = haddr_write_d;
//  end
//end

always @(*) begin
  if(rx_dv_d && (curr_state_d==LD_R_ADDR)) begin
      haddr_read = {haddr_read_d[23:0], rx_data_d};
  end else if(w_htrans_read_ne) begin
  //end else if((curr_state_d>=RD_DATA) && o_tx_dv && (read_byte_count*8 == 32)) begin
      haddr_read = haddr_read_d + 'd4;
  end else begin
      haddr_read = haddr_read_d;
  end
end

always @(*) begin
  if(rx_dv_d && ((curr_state_d==LD_W_ADDR)/* || (curr_state_d==LD_RW_ADDR)*/)) begin
  //if(rx_dv_d && (curr_state_d==LD_W_ADDR)) begin 
      haddr_write = {haddr_write_d[23:0], rx_data_d};
  end else if(w_htrans_write_ne) begin
  //end else if(((curr_state_d==LD_DATA) || (curr_state_d==LD_RW_DATA)) && rx_dv_d && (write_byte_count*8 == 32)) begin
  //end else if(((curr_state_d==RD_DATA)||(curr_state_d==LD_DATA)) && (write_byte_count_d < o_write_burst)) begin
      haddr_write = haddr_write_d + 'd4;
  end else begin
      haddr_write = haddr_write_d;
  end
end

always @(*) begin
      w_hburst = hburst;
end

always @(*) begin
      if(!tx_ready_d && tx_ready_2d) begin
         tx_ready_ne = 'd1;
      end else begin
         tx_ready_ne = 'd0;
      end
end

always @(*) begin
      if(!w_htrans_write && htrans_write_d) begin
         w_htrans_write_ne = 'd1;
      end else begin
         w_htrans_write_ne = 'd0;
      end
end

always @(*) begin
      if(!w_htrans_read && htrans_read_d) begin
         w_htrans_read_ne = 'd1;
      end else begin
         w_htrans_read_ne = 'd0;
      end
end

always @(*) begin
      if(!w_htrans_read) begin
         w_htrans = w_htrans_write;
      end else begin
         w_htrans = w_htrans_read;
      end
end

always @(*) begin
  if(htrans_write_d && htrans && !hready && hwrite) begin
      w_htrans_write = 'd2;
  end else if(((curr_state_d==LD_DATA)/* || (curr_state_d==LD_RW_DATA)*/ || (curr_state_d==LD_DATA)/* || (curr_state_d==LD_RW_DATA)*/) && (write_byte_count*8 == 32)) begin
      w_htrans_write = 'd2;
  end else begin
      w_htrans_write = 'd0;
  end
end

always @(*) begin
  if(htrans_read_d && htrans && !hready && !hwrite) begin
      w_htrans_read = 'd2;
  end else if(!i_tx_ready && !tx_ready_d && !htrans_read_d && !htrans_read_2d   && !tx_dv_d && !o_tx_dv && (read_data_count < o_read_bitwidth*o_read_burst/8) && (((curr_state_d>=RD_DATA) && /*(curr_state_d!=next_state) &&*/ (read_byte_count*8 == 0)) || (read_byte_count*8 == 32))) begin
      w_htrans_read = 'd2;
  end else begin
      w_htrans_read = 'd0;
  end
end

always @(*) begin
      if(w_htrans_write) begin
         w_haddr = haddr_write_d;
      end else begin
         w_haddr = haddr_read_d;
      end
end

//always @(*) begin
//  if((curr_state_d==LD_DATA) || (curr_state_d==LD_RW_DATA)) begin
//      w_haddr = haddr_write_d;
//  end else if((curr_state_d==RD_DATA)) begin
//      w_haddr = haddr_read_d;
//  end else begin
//      w_haddr = 'd0;
//  end
//end

always @(*) begin
      if(w_htrans_write) begin
         w_hwrite = (curr_state_d == LD_DATA)/* || (curr_state_d == LD_RW_DATA)*/;
      end else begin
         w_hwrite = 'd0;
      end
end

//always @(*) begin
//  if((curr_state_d==LD_DATA)) begin
//      w_hwrite = 'd1;
//  end else begin
//      w_hwrite = 'd0;
//  end
//end

always @(*) begin
  if((htrans_read_ne_d) ||  (tx_ready_ne_d && (curr_state_d >= RD_DATA) && (read_byte_count != 4) && (read_byte_count != 0) && (read_data_count < read_burst*read_bitwidth/8))) begin
      w_tx_dv = 'd1;
  end else begin
      w_tx_dv = 'd0;
  end
end

always @(*) begin
  if(read_byte_count == 0 && tx_dv_d) begin
      w_tx_data = hrdata_d[07:00];
  end else if (read_byte_count == 1 && tx_dv_d) begin
      w_tx_data = hrdata_d[15:08];
  end else if (read_byte_count == 2 && tx_dv_d) begin
      w_tx_data = hrdata_d[23:16];
  end else if (read_byte_count == 3 && tx_dv_d) begin
      w_tx_data = hrdata_d[31:24];
  end else begin
      w_tx_data = o_tx_data;
  end
end

always @(*) begin
  if(rx_dv_d && ((curr_state_d==LD_DATA)/* || (curr_state_d==LD_RW_DATA)*/)) begin
      w_hwdata = {rx_data_d, hwdata[31:08]};
  end else begin
      w_hwdata = hwdata;
  end
end

always @(*) begin
  if(curr_state_d == IDLE && rx_dv_2d) begin
      mode = rx_data_d;
  end else begin
      mode = mode_d;
  end
end
    
always @(posedge hclk or negedge hresetn) begin
  if(!hresetn) begin
      curr_state_d <= IDLE;
      haddr_write_d <= 'd0;
      haddr_read_d <= 'd0;
      haddr <= 'd0;
      o_write_burst <= 'd0;
      o_write_bitwidth <= 'd0;
      o_read_burst <= 'd0;
      o_read_bitwidth <= 'd0;
      o_tx_dv <= 'd0;
      o_tx_data <= 'd0;
      mode_d <= 'd0;
      write_byte_count_d <= 'd0;
      read_byte_count_d <= 'd0;
      rx_dv_d <= 'd0;
      rx_dv_2d <= 'd0;
      rx_dv_3d <= 'd0;
      rx_data_d <= 'd0;
      tx_dv_2d <= 'd0;
      hwdata <= 'd0;
      hwrite <= 'd0;
      htrans <= 'd0;
      htrans_d <= 'd0;
      htrans_read_d <= 'd0;
      htrans_read_2d <= 'd0;
      htrans_write_d <= 'd0;
      hburst <= 'd0;
      htrans_read_ne_d <= 'd0;
      tx_ready_d <= 'd0;
      tx_ready_2d <= 'd0;
      tx_ready_ne_d <= 'd0;
      hrdata_d <= 'd0;
  end else begin
      curr_state_d <= next_state;
      haddr_write_d <= haddr_write;
      haddr_read_d <= haddr_read;
      haddr <= w_haddr;
      o_write_burst     <= write_burst     ;
      o_write_bitwidth <= write_bitwidth ;
      o_read_burst      <= read_burst      ;
      o_read_bitwidth  <= read_bitwidth  ;
      tx_dv_d <= w_tx_dv;
      o_tx_dv <= tx_dv_d;
      tx_dv_2d <= o_tx_dv;
      //o_tx_dv <= w_htrans_read_ne;
      o_tx_data <= w_tx_data;
      mode_d <= mode;
      write_byte_count_d <= write_byte_count;
      read_byte_count_d <= read_byte_count;
      rx_dv_d <= i_rx_dv;
      rx_dv_2d <= rx_dv_d;
      rx_dv_3d <= rx_dv_2d;
      rx_data_d <= i_rx_data;
      hwdata <= w_hwdata;
      hwrite <= w_hwrite;
      htrans <= w_htrans;
      htrans_d <= htrans;
      htrans_read_d <= w_htrans_read;
      htrans_read_2d <= htrans_read_d;
      htrans_write_d <= w_htrans_write;
      hburst <= w_hburst;
      htrans_read_ne_d <= w_htrans_read_ne;
      tx_ready_d <= i_tx_ready;
      tx_ready_2d <= tx_ready_d;
      tx_ready_ne_d <= tx_ready_ne;
      hrdata_d <= w_hrdata;
  end
end

assign hsize  = 4'b0010; //4 bytes - 32 bit

assign o_status = (mode_d < 4) ? {i_rx_data, haddr[07:0], write_data_count[03:0],write_byte_count[03:0], mode_d[03:0], curr_state_d} : {i_rx_data, haddr[07:0], o_tx_data, mode_d[03:0]/*4bits*/, curr_state_d/*4bits*/};
//assign o_status = hrdata;

endmodule
