//------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//This Block sits as master on the bus matrix. Idea is user can access any memory region of the device through a simple uart interface.
//Which can be used for memory loading and debug.
//The code have 2 part, Rx and Tx. Rx will wait for the start bit - i.e RX line should go from 1 to 0.
//Once the Start bit is detected, it will kick off the counter and resets after reaching half of the baud count (uart_baud_rate/bus_clock_rate)
//After this expiry counter will run again and resets after reaching baud count. And this will be repeated Num_data_bits times + 1 (for stop bit)
//and at every counter expiry it will sample the RX data. As the counter expiry happens around in mid way of the data bit period,
//the data will be stable by then. No need to over sample it.
//
//Expected Sequence of Rx is - Read or write operation preamble - For read : "4D", For Write : "34"
//Next 4 transfer will be  Address Trans 1: lower byte of address, Trans 2 : first byte, Trans 3 : Second byte and Trans 4 : Upper byte of the address
//If it is a write, next 4 transfer will be write data. Trans 1: lower byte of wdata, Trans 2 : first byte, Trans 3 : Second byte and Trans 4 : Upper byte of the wdata
//------------------------------------------------------------------------------------------------------------------------------------------------------------------------
module spim 
(
  // CLOCK AND RESETS ------------------
  input  wire        hclk,              // Clock
  input  wire        hresetn,           // Asynchronous reset

  // AHB-LITE MASTER PORT --------------
  output wire [31:0] haddr,             // AHB transaction address
  output wire [ 3:0] hsize,             // AHB size: byte, half-word or word
  output wire [ 1:0] htrans,            // AHB transfer: sequential/non-sequential
  output wire [ 2:0] hburst,            // AHB transfer: sequential/non-sequential
  output wire [31:0] hwdata,            // AHB write-data
  output wire        hwrite,            // AHB write control
  input  wire [31:0] hrdata,            // AHB read-data
  input  wire        hready,            // AHB stall signal
  input  wire        hresp,             // AHB error response

  output wire [31:0]   o_status,
  
  //SPI Interface -IO

  input              i_spi_clk,
  output             o_spi_miso,
  input              i_spi_mosi,
  input              i_spi_cs_n
);

//Parameters
parameter SPI_MODE = 0;
parameter CLKS_PER_HALF_BIT = 2;

// TX (MOSI) Signals
wire [7:0]  w_TX_Byte;
//reg  [7:0]  r_TX_Byte2;
wire          w_TX_DV;
wire          w_TX_Ready;
// RX (MISO) Signals
wire          w_RX_DV;
reg           r_RX_DV;
reg           r_TX_busy;
//wire          w_RX_DV2;
wire [7:0]    w_RX_Byte;

reg [15:0] counter_d;
wire       counter_en;
wire       counter_rst;

//assign w_RX_DV2 = (counter_d == 'd10000);

//assign counter_rst = (counter_d == 'd10001);
//assign counter_en  = w_RX_DV || (counter_d != 'd0);
//always @(posedge hclk) begin
//  if(~hresetn) begin
//    counter_d <= 'd0;
//  end else if(counter_rst) begin
//     counter_d <= 'd0;
//  end else if(counter_en) begin
//     counter_d <= counter_d + 'd1;
//  end else begin
//     counter_d <= counter_d;
//  end
//end

//always @(posedge hclk) begin
//  if(~hresetn) begin
//    r_TX_Byte2 <= 'd0;
//  end else if(counter_d == 'd9990) begin
//     r_TX_Byte2 <= w_RX_Byte;
//  end else begin
//     r_TX_Byte2 <= r_TX_Byte2;
//  end
//end

always @(posedge hclk) begin
  if(~hresetn) begin
    r_RX_DV <= 'd0;
  end else begin
     r_RX_DV <= w_RX_DV;
  end
end

always @(posedge hclk) begin
  if(~hresetn) begin
    r_TX_busy <= 'd0;
  end else if(w_TX_DV) begin
     r_TX_busy <= 'd1;
  end else if(w_RX_DV) begin
     r_TX_busy <= 'd0;
  end
end

spim_ahb u_spim_ahb_inst (
  .hclk             (hclk),            //input  wire         // Clock
  .hresetn          (hresetn),         //input  wire         // Asynchronous reset
  .haddr            (haddr),           //output reg  [31:0]  // AHB transaction address
  .hsize            (hsize),           //output wire [ 2:0]  // AHB size: byte, half-word or word
  .htrans           (htrans),          //output reg  [ 1:0]  // AHB transfer: non-sequential/sequential
  .hburst           (hburst),          //output reg  [ 2:0]  // AHB Transfer
  .hwdata           (hwdata),          //output reg  [31:0]  // AHB write-data
  .hwrite           (hwrite),          //output reg          // AHB write control
  .hrdata           (hrdata),          //input  wire [31:0]  // AHB read-data
  .hready           (hready),          //input  wire         // AHB stall signal
  .hresp            (hresp),           //input  wire         // AHB error response
  .o_status         (o_status),
  //SPI Interface
  .i_rx_dv          (w_RX_DV),
  .i_rx_data        (w_RX_Byte),
  //.i_rx_dv          (I_RX_VLD),
  //.i_rx_data        (I_RX_OUT),
  //
  .i_tx_ready       (w_TX_Ready),
  .o_tx_dv          (w_TX_DV),
  .o_tx_data        (w_TX_Byte)
);

//    SPI_SLAVE u_spi_slave(
//        .CLK      (hclk),
//        .RST      (~hresetn),
//        .SCLK     (i_spi_clk),
//        .CS_N     (i_spi_cs_n),
//        .MOSI     (i_spi_mosi),
//        .MISO     (o_spi_miso),
//        .DIN      (w_TX_Byte),
//        .DIN_VLD  (w_TX_DV),
//        .READY    (w_TX_Ready),
//        .DOUT     (w_RX_Byte),
//        .DOUT_VLD (w_RX_DV)
//    );
// Instantiate UUT
  SPI_Slave #(.SPI_MODE(SPI_MODE)) SPI_Slave_UUT
  (
   // Control/Data Signals,
   .i_Rst_L(hresetn),       // FPGA Reset
   .i_Clk(hclk),            // FPGA Clock
   .o_RX_DV(w_RX_DV),       // Data Valid pulse (1 clock cycle)
   .o_RX_Byte(w_RX_Byte),   // Byte received on MOSI
   .i_TX_DV(w_TX_DV),       // Data Valid pulse
   .i_TX_Byte(w_TX_Byte),   // Byte to serialize to MISO (set up for loopback)
   .o_TX_Ready (w_TX_Ready),

   // SPI Interface
   .i_SPI_Clk(i_spi_clk),
   .o_SPI_MISO(o_spi_miso),
   .i_SPI_MOSI(i_spi_mosi),
   .i_SPI_CS_n(i_spi_cs_n)
   );

endmodule
