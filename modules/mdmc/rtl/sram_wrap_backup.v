module sram_wrap (  
  // CLOCK AND RESETS ------------------
  input  wire         hclk,              // Clock
  input  wire         hresetn,           // Asynchronous reset
  // AHB-LITE MASTER PORT --------------
  input   wire        hsel,            // AHB transfer: non-sequential only
  input   wire [31:0] haddr,             // AHB transaction address
  input   wire [ 2:0] hsize,             // AHB size: byte, half-word or word
  input   wire [31:0] hwdata,            // AHB write-data
  input   wire        hwrite,            // AHB write control
  output  reg  [31:0] hrdata,            // AHB read-data
  output  reg         hready,            // AHB stall signal
  output  reg         hresp              // AHB error response
);

//----------------------------------------------
//localparameter, genvar and wire/reg declaration
//----------------------------------------------
  localparam IDLE         = 0;
  localparam READ         = 1;
  localparam WRITE        = 2;
  localparam WAIT         = 3;
  localparam ERROR        = 4;

  localparam NUM_MEM      = 1;

  reg [4:0]  ahb_ps;
  reg [4:0]  ahb_ns;

  reg [13:0] sram_addr;
  reg [31:0] sram_rdata[NUM_MEM-1 :0];
  reg        sram_sel;
  reg        sram_we_n;

  reg [NUM_MEM-1 :0] sram_cs_n;
  reg [NUM_MEM-1 :0] sram_cs_n_lat;

  reg [31:0] haddr_lat;
  wire       dec_err;

  reg [3:0]  wbyte_en;
  reg [3:0]  wbyte_en_lat;

  genvar  i;
  integer j;

//--------------------------
//Identify valid transaction
//--------------------------
  assign dec_err  = hready & hsel & (haddr[31:16] != 16'h2000);
  assign valid_wr = hready & hsel &  hwrite & ~dec_err;
  assign valid_rd = hready & hsel & ~hwrite & ~dec_err;

//--------------------------
//Capture write address
//--------------------------

  always @(posedge hclk or negedge hresetn) begin 
    if (hresetn == 1'b0) begin
      haddr_lat    <= 32'b0;
      wbyte_en_lat <= 3'b0;
    end
    else if (ahb_ns[WRITE] | ahb_ns[WAIT]) begin
      haddr_lat    <= haddr;
      wbyte_en_lat <= wbyte_en;
    end
  end


//-----------------------------------------------
// Logic for generating sram addr/control signals
//-----------------------------------------------

always@*  begin
  ahb_ns    = 5'b0_0000;
  sram_sel  = 1'b0;
  sram_we_n = 1'b1;
  sram_addr = 19'b0;
  case (1'b1)
    ahb_ps[IDLE] : begin
      if (hsel == 1'b1) begin
        if (dec_err == 1'b1) begin
          ahb_ns[ERROR] = 1'b1;
        end
        else if (hwrite == 1'b0) begin
          ahb_ns[READ] = 1'b1;
          sram_sel     = 1'b1;
          sram_addr    = haddr[15:2];
        end
        else begin
          ahb_ns[WRITE] = 1'b1;
        end
      end
      else begin
        ahb_ns[IDLE] = 1'b1;
      end
    end //IDLE
    ahb_ps[READ] : begin
      if (hsel == 1'b1) begin
        if (dec_err == 1'b1) begin
          ahb_ns[ERROR] = 1'b1;
        end
        else if (hwrite == 1'b0) begin
          ahb_ns[READ] = 1'b1;
          sram_sel     = 1'b1;
          sram_addr    = haddr[15:2];
        end
        else begin
          ahb_ns[WRITE] = 1'b1;
        end
      end
      else begin
        ahb_ns[IDLE] = 1'b1;
      end
    end //READ
    ahb_ps[WRITE] : begin
      sram_sel  = 1'b1;
      sram_we_n = 1'b0;
      sram_addr = haddr_lat[15:2];
      if (hsel == 1'b1) begin
        if (dec_err == 1'b1) begin
          ahb_ns[ERROR] = 1'b1;
        end
        else if (hwrite == 1'b0) begin
          ahb_ns[WAIT] = 1'b1;
        end
        else begin
          ahb_ns[WRITE] = 1'b1;
        end
      end
      else begin
        ahb_ns[IDLE] = 1'b1;
      end
    end //WRITE
    ahb_ps[WAIT] : begin
      sram_sel  = 1'b1;
      sram_addr = haddr_lat[15:2];
      ahb_ns[IDLE] = 1'b1;
    end //WAIT
    ahb_ps[ERROR] : begin
      ahb_ns[IDLE] = 1'b1;
    end //ERROR
    default  : begin
      sram_sel     = 1'b0;
      sram_we_n    = 1'b1;
      sram_addr    = 14'b0;
      ahb_ns[IDLE] = 1'b1;
    end //ERROR
  endcase
end

 
  always @ (posedge hclk or negedge hresetn) begin
    if (hresetn == 1'b0) begin
      ahb_ps <= 5'b0_0001;
    end
    else begin
      ahb_ps  <= ahb_ns;
    end
  end

//-----------------------------------------------
// Memory Instantiation
//-----------------------------------------------

generate
  for (i=0; i<NUM_MEM; i=i+1) begin
     //assign sram_cs_n[i] = (sram_sel & (sram_addr[13:9] == i)) ? 1'b0 : 1'b1;
     assign sram_cs_n[i] = sram_sel ? 1'b0 : 1'b1;

    `ifdef FPGA_SYNTH
      sram_sp_hsd \genblk1[0].u_sram_inst  (
        .douta(sram_rdata[i]),
        .addra(sram_addr),
        .dina(hwdata),
        .clka(hclk), 
        .ena(~sram_cs_n[i]),
        .wea(~sram_we_n)
      );
    `else
      sram_sp_hde_64k u_sram_inst (
       .CLK  (hclk),                          //Clock
       .CEN  (sram_cs_n[i]),                  //Chip Select
       //.WEN  (sram_cs_n[i] | sram_we_n),    //Write Enable
       .WEN  (sram_we_n),                     //Write Enable
       .A    (sram_addr[13:0]),               //Address input wire [9:0]
       .D    (hwdata),                        //input  data wire [31:0]
       .EMA  (3'b0),                          //Output Enable
       .EMA  (3'b0),                          //Output Enable
       .RETN (1'b1),                          //Shut down pin???
       .Q    (sram_rdata[i])                  //output data wire [31:0]
      );
    `endif
  end


endgenerate

//-----------------------------------------------
// Read data logic
//-----------------------------------------------
   
  always @ (posedge hclk or negedge hresetn) begin
    if (hresetn == 1'b0) begin
      sram_cs_n_lat <= {NUM_MEM{1'b1}};
    end
    else begin
      sram_cs_n_lat <= sram_cs_n | ~sram_we_n;
    end
  end

  always@* begin
      hrdata = 32'b0;
    for (j=0; j< NUM_MEM; j=j+1) begin
      hrdata = hrdata | ({32{~sram_cs_n_lat[j]}} & sram_rdata[j]);
    end
  end



//----------------------------
// Logic for write byte enable
// hsize
// 0000 - byte
// 0001 - hword
// 0010 - word
//----------------------------
   always @* begin
     if (valid_wr == 1'b1) begin
       if (haddr[1:0] == 2'b00) begin
         case (hsize)
           3'b000 : wbyte_en = 4'b0001;
           3'b001 : wbyte_en = 4'b0011;
           3'b010 : wbyte_en = 4'b1111;
           default: wbyte_en = 4'b0000;
         endcase
       end
       if((haddr[1:0] == 2'b01)) begin
         case (hsize)
           3'b000 : wbyte_en = 4'b0010;
           default: wbyte_en = 4'b0000;
         endcase
       end
       if((haddr[1:0] == 2'b10)) begin
         case (hsize)
           3'b000 : wbyte_en = 4'b0100;
           3'b001 : wbyte_en = 4'b1100;
           default: wbyte_en = 4'b0000;
         endcase
       end
       if((haddr[1:0] == 2'b11)) begin
         case (hsize)
           3'b000 : wbyte_en = 4'b1000;
           default: wbyte_en = 4'b0000;
         endcase
       end
     end
     else begin
       wbyte_en = 4'b0000;
     end
   end


//------------------------------------
// Logic to generate hresp and hready
//------------------------------------
   
  always @ (posedge hclk or negedge hresetn) begin
    if (hresetn == 1'b0) begin
      hready <= 1'b1;
    end
    else if (ahb_ns[ERROR] | ahb_ns[WAIT]) begin
      hready <= 1'b0;
    end
    else begin
      hready <= 1'b1;
    end
  end
  
  always @ (posedge hclk or negedge hresetn) begin
    if (hresetn == 1'b0) begin
      hresp  <= 1'b0;
    end
    else if (ahb_ns[ERROR] | ahb_ps[ERROR]) begin
      hresp  <= 1'b1;
    end
    else begin
      hresp  <= 1'b0;
    end
  end


endmodule
