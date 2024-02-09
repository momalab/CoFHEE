module pram (  
  // CLOCK AND RESETS ------------------
  input  wire         hclk,              // Clock
  input  wire         hresetn,           // Asynchronous reset
  // AHB-LITE MASTER PORT --------------
  input   wire        hsel,              // AHB transfer: non-sequential only
  input   wire [31:0] haddr,             // AHB transaction address
  input   wire [ 3:0] hsize,             // AHB size: byte, half-word or word
  input   wire        hwrite,            // AHB write control
  output  reg  [31:0] hrdata,            // AHB read-data
  output  reg         hready,            // AHB stall signal
  output  reg         hresp,             // AHB error response
  input   wire [31:0] sp_addr,
  input   wire [31:0] reset_addr,
  input   wire [31:0] nmi_addr,
  input   wire [31:0] fault_addr,
  input   wire [31:0] irq0_addr,
  input   wire [31:0] irq1_addr,
  input   wire [31:0] irq2_addr,
  input   wire [31:0] irq3_addr,
  input   wire [31:0] irq4_addr,
  input   wire [31:0] irq5_addr,
  input   wire [31:0] irq6_addr,
  input   wire [31:0] irq7_addr,
  input   wire [31:0] irq8_addr,
  input   wire [31:0] irq9_addr,
  input   wire [31:0] irq10_addr,
  input   wire [31:0] irq11_addr,
  input   wire [31:0] irq12_addr,
  input   wire [31:0] irq13_addr,
  input   wire [31:0] irq14_addr,
  input   wire [31:0] irq15_addr
);

//----------------------------------------------
//localparameter, genvar and wire/reg declaration
//----------------------------------------------
  localparam IDLE         = 0;
  localparam READ         = 1;
  localparam WRITE        = 2;
  localparam WAIT         = 3;
  localparam ERROR        = 4;

//----------------------------------------------
//localparameter, genva and wire/reg declaration
//----------------------------------------------
  localparam SP_ADDR     = 16'h0;
  localparam RESET_ADDR  = 16'h4;
  localparam NMI_ADDR    = 16'h8;
  localparam FAULT_ADDR  = 16'hC;
  localparam IRQ0_ADDR   = 16'h40;
  localparam IRQ1_ADDR   = 16'h44;
  localparam IRQ2_ADDR   = 16'h48;
  localparam IRQ3_ADDR   = 16'h4C;
  localparam IRQ4_ADDR   = 16'h50;
  localparam IRQ5_ADDR   = 16'h54;
  localparam IRQ6_ADDR   = 16'h58;
  localparam IRQ7_ADDR   = 16'h5c;
  localparam IRQ8_ADDR   = 16'h60;
  localparam IRQ9_ADDR   = 16'h64;
  localparam IRQ10_ADDR  = 16'h68;
  localparam IRQ11_ADDR  = 16'h6C;
  localparam IRQ12_ADDR  = 16'h70;
  localparam IRQ13_ADDR  = 16'h74;
  localparam IRQ14_ADDR  = 16'h78;
  localparam IRQ15_ADDR  = 16'h7C;


  reg [31:0] read_data;
  reg [4:0]  ahb_ps;
  reg [4:0]  ahb_ns;


//--------------------------
//Identify valid transaction
//--------------------------
  assign valid_wr = hready & hsel &  hwrite;
  assign dec_err  = (hready & hsel & (|haddr[15:8] == 1'b1)) | valid_wr;

  assign valid_rd = hready & hsel & ~hwrite & ~dec_err;

always@*  begin
  ahb_ns    = 5'b0_0000;
  case (1'b1)
    ahb_ps[IDLE] : begin
      if (hsel == 1'b1) begin
        if (dec_err == 1'b1) begin
          ahb_ns[ERROR] = 1'b1;
        end
        else begin
          ahb_ns[READ] = 1'b1;
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
        else begin
          ahb_ns[READ] = 1'b1;
        end
      end
      else begin
        ahb_ns[IDLE] = 1'b1;
      end
    end //READ
    ahb_ps[ERROR] : begin
      ahb_ns[IDLE] = 1'b1;
    end //ERROR
    default  : begin
      ahb_ns[IDLE] = 1'b1;
    end //DEFAULT
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



//------------------------------------
// Logic to generate hresp and hready
//------------------------------------
   
  always @ (posedge hclk or negedge hresetn) begin
    if (hresetn == 1'b0) begin
      hready <= 1'b1;
    end
    else if (ahb_ns[ERROR]) begin
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


  always @*  begin
    if (valid_rd) begin
      case (haddr[15:0]) //synopsys parallel_case 
        SP_ADDR  : begin
          read_data  = sp_addr;
        end
        RESET_ADDR  : begin
          read_data  = reset_addr;
        end
        NMI_ADDR  : begin
          read_data  = nmi_addr;
        end
        FAULT_ADDR  : begin
          read_data  = fault_addr;
        end
        IRQ0_ADDR  : begin
          read_data  = irq0_addr;
        end
        IRQ1_ADDR  : begin
          read_data  = irq1_addr;
        end
        IRQ2_ADDR  : begin
          read_data  = irq2_addr;
        end
        IRQ3_ADDR  : begin
          read_data  = irq3_addr;
        end
        IRQ4_ADDR  : begin
          read_data  = irq4_addr;
        end
        IRQ5_ADDR  : begin
          read_data  = irq5_addr;
        end
        IRQ6_ADDR  : begin
          read_data  = irq6_addr;
        end
        IRQ7_ADDR  : begin
          read_data  = irq7_addr;
        end
        IRQ8_ADDR  : begin
          read_data  = irq8_addr;
        end
        IRQ9_ADDR  : begin
          read_data  = irq9_addr;
        end
        IRQ10_ADDR  : begin
          read_data  = irq10_addr;
        end
        IRQ11_ADDR  : begin
          read_data  = irq11_addr;
        end
        IRQ12_ADDR  : begin
          read_data  = irq12_addr;
        end
        IRQ13_ADDR  : begin
          read_data  = irq13_addr;
        end
        IRQ14_ADDR  : begin
          read_data  = irq14_addr;
        end
        IRQ15_ADDR  : begin
          read_data  = irq15_addr;
        end
        default      : begin
          read_data  = 32'd0;
        end
      endcase
    end
    else begin
      read_data = 32'b0;
    end
  end

  always @ (posedge hclk or negedge hresetn) begin
    if (hresetn == 1'b0) begin
      hrdata  <= 32'b0;
    end
    else if (valid_rd == 1'b1) begin
      hrdata  <= read_data;
    end
    else begin
      hrdata  <= 32'b0;
    end
  end



endmodule
