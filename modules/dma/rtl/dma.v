//------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// DMA
//------------------------------------------------------------------------------------------------------------------------------------------------------------------------
module dma #(
  parameter DWIDTH  = 128) (  
  // CLOCK AND RESETS ------------------
  input  wire        hclk,              // Clock
  input  wire        hresetn,           // Asynchronous reset

  // AHB-LITE MASTER PORT1 - Read Port --------------
  output reg  [31:0]  haddr_1,             // AHB transaction address
  output wire [ 3:0]  hsize_1,             // AHB size: byte_2, half-word or word
  output wire [ 1:0]  htrans_1,            // AHB transfer: sequential/non-sequential
  output wire [ 2:0]  hburst_1,            // AHB transfer: sequential/non-sequential
  output wire [DWIDTH-1:0] hwdata_1,            // AHB write-data
  output wire         hwrite_1,            // AHB write control
  input  wire [DWIDTH-1:0] hrdata_1,            // AHB read-data
  input  wire         hready_1,            // AHB stall signal
  input  wire         hresp_1,             // AHB error response

  // AHB-LITE MASTER PORT2 - Write Port --------------
  output reg  [31:0]  haddr_2,             // AHB transaction address
  output wire [ 3:0]  hsize_2,             // AHB size: byte_2, half-word or word
  output wire [ 1:0]  htrans_2,            // AHB transfer: sequential/non-sequential
  output wire [ 2:0]  hburst_2,            // AHB transfer: sequential/non-sequential
  output wire [DWIDTH-1:0] hwdata_2,            // AHB write-data
  output wire         hwrite_2,            // AHB write control
  input  wire [DWIDTH-1:0] hrdata_2,            // AHB read-data
  input  wire         hready_2,            // AHB stall signal
  input  wire         hresp_2,             // AHB error response

  output wire [31:0]   o_status,

  //DMA Interface -IO
  input              i_dma_req,
  output             o_dma_done,
  input  [31:0]      i_src_addr,  //Keep the data available for 2 clock cycle at least.  
  input  [31:0]      i_dst_addr,  //Keep the data available for 2 clock cycle at least.
  input  [15:0]      i_poly_deg,
  input              i_src_rev,
  input              i_dst_rev,
  input  [14:0]      i_addr_inc,
  input  [14:0]      i_burst_size //Keep the data available for 2 clock cycle at least. 
);

parameter AHB_BUS_LATENCY = 1;

integer i;

reg         dma_req_d;
wire        dma_req_pe;
reg         module_en;
wire        module_ne;
reg         module_ne_d;
reg  [AHB_BUS_LATENCY:0] module_en_d;
reg  [31:0] src_addr_d;
reg  [31:0] dst_addr_d;
reg  [14:0] burst_size_d;
reg  [15:0] poly_deg_d;
reg  [14:0] addr_inc_d;
reg         src_rev_d;
reg         dst_rev_d;
wire [14:0] w_burst_size;
wire [14:0] w_addr_inc;

reg  [15:0] counter_d;
reg  [15:0] counter_2d[0:AHB_BUS_LATENCY-1];
reg  [15:0] counter;
wire        counter_en;
wire        counter_rst;


wire  [15:0] counter_rev_07b;
wire  [15:0] counter_rev_08b;
wire  [15:0] counter_rev_09b;
wire  [15:0] counter_rev_10b;
wire  [15:0] counter_rev_11b;
wire  [15:0] counter_rev_12b;
wire  [15:0] counter_rev_13b;
reg   [15:0] counter_rev;
wire  [15:0] counter_src;
wire  [15:0] counter_dst;

reg [DWIDTH-1:0] read_data_d;
reg [31:0] data_debug;

reg [31:0] w_haddr_1;
reg [31:0] w_haddr_2;

assign counter_rev_07b = {9'd0, counter[0], counter[1], counter[2], counter[3], counter[4], counter[5], counter[6]};
assign counter_rev_08b = {8'd0, counter[0], counter[1], counter[2], counter[3], counter[4], counter[5], counter[6], counter[7]};
assign counter_rev_09b = {7'd0, counter[0], counter[1], counter[2], counter[3], counter[4], counter[5], counter[6], counter[7], counter[8]};
assign counter_rev_10b = {6'd0, counter[0], counter[1], counter[2], counter[3], counter[4], counter[5], counter[6], counter[7], counter[8], counter[9]};
assign counter_rev_11b = {5'd0, counter[0], counter[1], counter[2], counter[3], counter[4], counter[5], counter[6], counter[7], counter[8], counter[9], counter[10]};
assign counter_rev_12b = {4'd0, counter[0], counter[1], counter[2], counter[3], counter[4], counter[5], counter[6], counter[7], counter[8], counter[9], counter[10], counter[11]};
assign counter_rev_13b = {3'd0, counter[0], counter[1], counter[2], counter[3], counter[4], counter[5], counter[6], counter[7], counter[8], counter[9], counter[10], counter[11], counter[12]};

always @(*) begin
counter_rev = 'd0;
  case(poly_deg_d) 
    16'h0080:  begin
		 counter_rev = counter_rev_07b;
               end 
    16'h0100:  begin
		 counter_rev = counter_rev_08b;
               end 
    16'h0200:  begin
		 counter_rev = counter_rev_09b;
               end 
    16'h0400:  begin
		 counter_rev = counter_rev_10b;
               end 
    16'h0800:  begin
		 counter_rev = counter_rev_11b;
               end 
    16'h1000:  begin
		 counter_rev = counter_rev_12b;
               end 
    16'h2000:  begin
		 counter_rev = counter_rev_13b;
               end 
    default  : begin
		 counter_rev = 'd0;
               end //default
  endcase
end
assign counter_src = src_rev_d ? counter_rev : counter;
assign counter_dst = dst_rev_d ? counter_rev : counter;
assign module_ne = module_en_d[AHB_BUS_LATENCY] && !module_en_d[AHB_BUS_LATENCY-1];
assign o_dma_done = module_ne_d;
//assign o_dma_done = (haddr_2 == (dst_addr_d + burst_size_d));

assign o_status = {haddr_1[31:24], haddr_2[31:24], data_debug[15:0]};
assign w_burst_size = {burst_size_d[14:4], 4'd0};
assign w_addr_inc   = {  addr_inc_d[14:4], 4'd0};


assign dma_req_pe = i_dma_req && !dma_req_d;

//Read AHB port
assign hsize_1  = 4'b0100; //16 bytes - 128 bit
assign hwrite_1 = 'd0;
assign hwdata_1 = 'd0;
assign hburst_1 = 'd0;
assign htrans_1 = {module_en, 1'd0};

//Write AHB Port
assign hsize_2  = 4'b0100; //16 bytes - 128 bit
assign hwrite_2 = 'd1;
assign hwdata_2 = read_data_d; //1 clock cycle delay of hrdata_1;
assign hburst_2 = 'd0;
assign htrans_2 = {module_en_d[AHB_BUS_LATENCY-1], 1'd0};


assign counter_rst = module_ne | dma_req_pe;
assign counter_en  = (module_en | (module_en_d != 'd0)) && (counter_d < burst_size_d + AHB_BUS_LATENCY);
always @(*) begin
  if(counter_rst) begin
    counter <= 'd0;
  end else if(counter_en) begin
    counter <= counter_d + 'd1;
  end else begin
    counter <= counter_d;
  end
end

always @(*) begin
  if(dma_req_pe) begin
    w_haddr_2 <= i_dst_addr;
  end else if(module_en_d[AHB_BUS_LATENCY-1]) begin
    w_haddr_2 <= dst_addr_d + w_addr_inc*(counter_2d[AHB_BUS_LATENCY-1]);
  end else begin
    w_haddr_2 <= haddr_2;
  end
end

always @(*) begin
  if(dma_req_pe) begin
    w_haddr_1 <= i_src_addr;
  end else if(module_en) begin
    w_haddr_1 <= src_addr_d + counter_src*w_addr_inc;
  end else begin
    w_haddr_1 <= haddr_1;
  end
end



always @(posedge hclk or negedge hresetn) begin
  if(~hresetn) begin
    for(i=0;i<AHB_BUS_LATENCY+1;i=i+1) begin  
       module_en_d[i] <= 'd0;
       counter_2d[i] <= 'd0;
    end
    counter_d <= 'd0;
    haddr_1   <= 'd0;
    haddr_2   <= 'd0;
    dma_req_d <= 'd0;
    module_ne_d <= 'd0;
    read_data_d <= 'd0;
    src_rev_d <= 'd0;
    dst_rev_d <= 'd0;
  end else begin
    for(i=1;i<AHB_BUS_LATENCY+1;i=i+1) begin  
       module_en_d[i] <= module_en_d[i-1];
       counter_2d[i] <= counter_2d[i-1];
    end
    counter_2d[0] <= counter_dst;
    module_en_d[0] <= module_en;
    counter_d <= counter;
    haddr_1   <= w_haddr_1;
    haddr_2   <= w_haddr_2;
    dma_req_d <= i_dma_req;
    module_ne_d <= module_ne;
    read_data_d <= hrdata_1;
    src_rev_d <= i_src_rev;
    dst_rev_d <= i_dst_rev;
  end
end

always @(posedge hclk or negedge hresetn) begin
  if(~hresetn) begin
    module_en <= 'd0;
  end else if(counter_d == burst_size_d - 1) begin
    module_en <= 'd0;
  end else if(dma_req_pe) begin
    module_en <= 'd1;
  end
end

always @(posedge hclk or negedge hresetn) begin
  if(~hresetn) begin
    src_addr_d <= 'd0;
    dst_addr_d <= 'd0;
    burst_size_d <= 'd0;
    addr_inc_d <= 'd0;
    poly_deg_d <= 'd0;
  end else if(dma_req_pe) begin
    src_addr_d <= i_src_addr;
    dst_addr_d <= i_dst_addr;
    burst_size_d <= i_burst_size;
    addr_inc_d <= i_addr_inc;
    poly_deg_d <= i_poly_deg;
  end else begin
    src_addr_d <= src_addr_d;
    dst_addr_d <= dst_addr_d;
    burst_size_d <= burst_size_d;
    addr_inc_d <= addr_inc_d;
    poly_deg_d <= poly_deg_d;
  end
end

always @(posedge hclk or negedge hresetn) begin
  if(~hresetn) begin
    data_debug <= 'd0;
  end else if(module_en_d[0]) begin
    data_debug <= {hrdata_1[23:0], hrdata_1[DWIDTH-1:DWIDTH-8]};
  end
end
endmodule

