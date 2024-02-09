///////////////////////////////////////////////////////////////////////////////
// Description: SPI (Serial Peripheral Interface) Slave
//              Creates slave based on input configuration.
//              Receives a byte one bit at a time on MOSI
//              Will also push out byte data one bit at a time on MISO.  
//              Any data on input byte will be shipped out on MISO.
//              Supports multiple bytes per transaction when CS_n is kept 
//              low during the transaction.
//
// Note:        i_Clk must be at least 4x faster than i_SPI_Clk
//              MISO is tri-stated when not communicating.  Allows for multiple
//              SPI Slaves on the same interface.
//
// Parameters:  SPI_MODE, can be 0, 1, 2, or 3.  See above.
//              Can be configured in one of 4 modes:
//              Mode | Clock Polarity (CPOL/CKP) | Clock Phase (CPHA)
//               0   |             0             |        0
//               1   |             0             |        1
//               2   |             1             |        0
//               3   |             1             |        1
//              More info: https://en.wikipedia.org/wiki/Serial_Peripheral_Interface_Bus#Mode_numbers
///////////////////////////////////////////////////////////////////////////////

module SPI_Slave
  #(parameter SPI_MODE = 0)
  (
   // Control/Data Signals,
   input            i_Rst_L,    // FPGA Reset
   input            i_Clk,      // FPGA Clock
   output reg       o_RX_DV,    // Data Valid pulse (1 clock cycle)
   output reg [7:0] o_RX_Byte,  // Byte received on MOSI
   output reg       o_TX_Ready,    // Data Busy
   input            i_TX_DV,    // Data Valid pulse to register i_TX_Byte
   input  [7:0]     i_TX_Byte,  // Byte to serialize to MISO.

   // SPI Interface
   input      i_SPI_Clk,
   output     o_SPI_MISO,
   input      i_SPI_MOSI,
   input      i_SPI_CS_n
   );


  // SPI Interface (All Runs at SPI Clock Domain)
  wire w_CPOL;     // Clock polarity
  wire w_CPHA;     // Clock phase
  wire w_SPI_Clk;  // Inverted/non-inverted depending on settings
  wire w_SPI_MISO_Mux;
  
  reg [2:0] r_RX_Bit_Count;
  reg [2:0] r_TX_Bit_Count;
  reg [7:0] r_Temp_RX_Byte;
  reg [7:0] r_RX_Byte;
  reg r_RX_Done, r2_RX_Done, r3_RX_Done;
  reg r_TX_Done, r2_TX_Done, r3_TX_Done;
  reg [7:0] r_TX_Byte;
  reg r_SPI_MISO_Bit, r_Preload_MISO;
  reg flag;
//  reg [15:0] counter_d;
  wire TX_ready_en;
  wire TX_ready_dis;

  // CPOL: Clock Polarity
  // CPOL=0 means clock idles at 0, leading edge is rising edge.
  // CPOL=1 means clock idles at 1, leading edge is falling edge.
  assign w_CPOL  = (SPI_MODE == 2) | (SPI_MODE == 3);

  // CPHA: Clock Phase
  // CPHA=0 means the "out" side changes the data on trailing edge of clock
  //              the "in" side captures data on leading edge of clock
  // CPHA=1 means the "out" side changes the data on leading edge of clock
  //              the "in" side captures data on the trailing edge of clock
  assign w_CPHA  = (SPI_MODE == 1) | (SPI_MODE == 3);

  assign w_SPI_Clk = w_CPHA ? ~i_SPI_Clk : i_SPI_Clk;



  // Purpose: Recover SPI Byte in SPI Clock Domain
  // Samples line on correct edge of SPI Clock
  always @(posedge w_SPI_Clk or posedge i_SPI_CS_n)
  begin
    if (i_SPI_CS_n)
    begin
      r_RX_Bit_Count <= 0;
      r_RX_Done      <= 1'b0;
    end
    else
    begin
      r_RX_Bit_Count <= r_RX_Bit_Count + 1;

      // Receive in LSB, shift up to MSB
      r_Temp_RX_Byte <= {r_Temp_RX_Byte[6:0], i_SPI_MOSI};
    
      if (r_RX_Bit_Count == 3'b111)
      begin
        r_RX_Done <= 1'b1;
        r_RX_Byte <= {r_Temp_RX_Byte[6:0], i_SPI_MOSI};
      end
      else if (r_RX_Bit_Count == 3'b010)
      begin
        r_RX_Done <= 1'b0;        
      end

    end // else: !if(i_SPI_CS_n)
  end // always @ (posedge w_SPI_Clk or posedge i_SPI_CS_n)

//assign TX_ready_en  = i_TX_DV;
//assign TX_ready_dis = (counter_d == 'd1000);
always @(posedge i_Clk or negedge i_Rst_L) begin
    if (~i_Rst_L) begin
        o_TX_Ready <= 'd0;
    end else if(i_TX_DV) begin
        o_TX_Ready <= 'd1;
    end else if(r2_TX_Done && flag) begin
        o_TX_Ready <= 'd0;
    end else begin
        o_TX_Ready <= o_TX_Ready;
    end
end

//always @(posedge i_Clk or negedge i_Rst_L) begin
//    if (~i_Rst_L) begin
//        counter_d <= 'd0;
//    end else if((counter_d == 'd1010)) begin
//        counter_d <= 'd0;
//    end else if((r2_TX_Done && flag) || (counter_d != 0)) begin
//        counter_d <= counter_d + 1;
//    end else begin
//        counter_d <= counter_d;
//    end
//end

always @(posedge i_Clk or negedge i_Rst_L) begin
    if (~i_Rst_L) begin
        flag <= 'd0;
    end else if((r_TX_Bit_Count == 'd6) && (i_TX_DV || o_TX_Ready)) begin
        flag <= 'd1;
    end else if(r3_TX_Done && flag) begin
        flag <= 'd0;
    end else begin
        flag <= flag;
    end
end

  // Purpose: Cross from SPI Clock Domain to main FPGA clock domain
  // Assert o_RX_DV for 1 clock cycle when o_RX_Byte has valid data.
  always @(posedge i_Clk or negedge i_Rst_L)
  begin
    if (~i_Rst_L)
    begin
      r2_RX_Done <= 1'b0;
      r3_RX_Done <= 1'b0;
      o_RX_DV    <= 1'b0;
      o_RX_Byte  <= 8'h00;
    end
    else
    begin
      // Here is where clock domains are crossed.
      // This will require timing constraint created, can set up long path.
      r2_RX_Done <= r_RX_Done;

      r3_RX_Done <= r2_RX_Done;

      if (r3_RX_Done == 1'b0 && r2_RX_Done == 1'b1) // rising edge
      begin
        o_RX_DV   <= 1'b1;  // Pulse Data Valid 1 clock cycle
        o_RX_Byte <= r_RX_Byte;
      end
      else
      begin
        o_RX_DV <= 1'b0;
      end
    end // else: !if(~i_Rst_L)
  end // always @ (posedge i_Bus_Clk)


  // Control preload signal.  Should be 1 when CS is high, but as soon as
  // first clock edge is seen it goes low.
  always @(posedge w_SPI_Clk or posedge i_SPI_CS_n)
  begin
    if (i_SPI_CS_n)
    begin
      r_Preload_MISO <= 1'b1;
    end
    else
    begin
      r_Preload_MISO <= 1'b0;
    end
  end


  // Purpose: Transmits 1 SPI Byte whenever SPI clock is toggling
  // Will transmit read data back to SW over MISO line.
  // Want to put data on the line immediately when CS goes low.
  always @(negedge w_SPI_Clk or posedge i_SPI_CS_n)
  begin
    if (i_SPI_CS_n) begin
      r_TX_Done      <= 'd0;
      r_TX_Bit_Count <= 3'b110;  // Send MSb first
      r_SPI_MISO_Bit <= r_TX_Byte[3'b111];  // Reset to MSb
    end
    else
    begin
      if(r_TX_Bit_Count == 'd0) begin
	  r_TX_Done <= 'd1;
      end else begin
	  r_TX_Done <= 'd0;
      end
      r_TX_Bit_Count <= r_TX_Bit_Count - 1;

      // Here is where data crosses clock domains from i_Clk to w_SPI_Clk
      // Can set up a timing constraint with wide margin for data path.
      r_SPI_MISO_Bit <= r_TX_Byte[r_TX_Bit_Count];

    end // else: !if(i_SPI_CS_n)
  end // always @ (negedge w_SPI_Clk or posedge i_SPI_CS_n_SW)


  // Purpose: Register TX Byte when DV pulse comes.  Keeps registed byte in 
  // this module to get serialized and sent back to master.
  always @(posedge i_Clk or negedge i_Rst_L)
  begin
    if (~i_Rst_L)
    begin
      r2_TX_Done <= 1'b0;
      r3_TX_Done <= 1'b0;
      r_TX_Byte <= 8'h00;
    end
    else
    begin
      r2_TX_Done <= r_TX_Done;
      r3_TX_Done <= r2_TX_Done;
      if (i_TX_DV)
      begin
        r_TX_Byte <= i_TX_Byte; 
      end
    end // else: !if(~i_Rst_L)
  end // always @ (posedge i_Clk or negedge i_Rst_L)

  // Preload MISO with top bit of send data when preload selector is high.
  // Otherwise just send the normal MISO data
  assign w_SPI_MISO_Mux = r_Preload_MISO ? r_TX_Byte[3'b111] : r_SPI_MISO_Bit;

  // Tri-statae MISO when CS is high.  Allows for multiple slaves to talk.
  assign o_SPI_MISO = i_SPI_CS_n ? 1'b0 : w_SPI_MISO_Mux;

endmodule // SPI_Slave
