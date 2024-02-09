`timescale 1 ns/1 ps

module spim_tb (
);

wire [31:0] haddr;
wire [31:0] hwdata;
wire [128:0] hrdata;
wire [2:0]  hsize;
wire [1:0]  htrans;
wire        hresp;

reg hclk_tb;
reg hresetn_tb;

reg rx_dv_tb;
reg [7:0] rx_data_tb;

reg spi_clk_tb;
reg spi_mosi_tb;
reg spi_cs_n_tb;

initial begin
  hclk_tb    = 1'b0;
  hresetn_tb = 1'b0;
  
  spi_clk_tb   = 1'b0;
  spi_mosi_tb  = 1'b0;
  spi_cs_n_tb  = 1'b1;
  
  rx_dv_tb   = 1'b0;
  rx_data_tb = 8'b0;
end



spim u_dut_inst (
  .hclk                (hclk_tb),      //input  wire        // Clock
  .hresetn             (hresetn_tb),   //input  wire        // Asynchronous reset
  .haddr               (haddr),        //output reg  [31:0] // AHB transaction address
  .hsize               ({1'b0, hsize} ),   //output wire [ 2:0] // AHB size: byte, half-word or word
  .htrans              (htrans),           //output reg  [ 1:0] // AHB transfer: sequential/non-sequential
  .hburst              (hburst),           //output reg  [ 2:0] // AHB transfer: sequential/non-sequential
  .hwdata              (hwdata),           //output reg  [31:0] // AHB write-data
  .hwrite              (hwrite),           //output reg         // AHB write control
  .hrdata              (hrdata[31:0]),     //input  wire [31:0] // AHB read-data
  .hready              (hready),       //input  wire        // AHB stall signal
  .hresp               (hresp),        //input  wire        // AHB error response
  .i_spi_clk           (spi_clk_tb),   //input  wire        
  .i_spi_mosi          (spi_mosi_tb), //input  wire [07:0] 
  .i_spi_cs_n          (spi_cs_n_tb), //input  wire [07:0] 
  .o_spi_miso          (), //input  wire [07:0] 
  .I_RX_OUT            (rx_data_tb),
  .I_RX_VLD            (rx_dv_tb),
  .O_TX_DATA           (),
  .O_TX_START          (),
  .I_BUSY              (),
  .o_status            ()
);

sram_wrap u_sram_wrap_inst (  
  .hclk          (hclk_tb),           // Clock
  .hresetn       (hresetn_tb),           // Asynchronous reset
  .hsel          (htrans[1]),           // AHB transfer: non-sequential only
  .haddr         (haddr),           // AHB transaction address
  .hsize         (hsize),           // AHB size: byte, half-word or word
  .hwdata        ({96'b0, hwdata}),           // AHB write-data
  .hwrite        (hwrite),           // AHB write control
  .hrdata        (hrdata),           // AHB read-data
  .hready        (hready),           // AHB stall signal
  .hresp         (hresp),           // AHB error response
  .sram_ctl      (16'b0)
);                



endmodule

