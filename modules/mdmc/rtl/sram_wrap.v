`timescale 1 ns/1 ps

module sram_wrap  #(
  parameter POLYDEG = 4096,
  parameter DWIDTH  = 128) (  
  // CLOCK AND RESETS ------------------
  input  wire                hclk,      // Clock
  input  wire                hresetn,   // Asynchronous reset
  // AHB-LITE MASTER PORT --------------
  input   wire               hsel,      // AHB transfer: non-sequential only
  input   wire [31:0]        haddr,     // AHB transaction address
  input   wire [ 3:0]        hsize,     // AHB size: byte, half-word or word
  input   wire [DWIDTH-1 :0] hwdata,    // AHB write-data
  input   wire               hwrite,    // AHB write control
  output  wire [DWIDTH-1 :0] hrdata,    // AHB read-data
  output  reg                hready,    // AHB stall signal
  output  reg                hresp,     // AHB error response
  input   wire [16:0]        sram_ctl
);

//----------------------------------------------
//localparameter, genvar and wire/reg declaration
//----------------------------------------------
  localparam IDLE         = 0;
  localparam READ         = 1;
  localparam WRITE        = 2;
  localparam WAIT         = 3;
  localparam ERROR        = 4;

  localparam LOG2POLYDEG  = $clog2(POLYDEG);
  localparam ADDRWIDTH    = LOG2POLYDEG + 4;

  localparam NUM_MEM      = 4;

  reg [4:0]  ahb_ps;
  reg [4:0]  ahb_ns;

  reg [ADDRWIDTH-1 :0] haddr_loc;
  reg [3:0]            hsize_loc;
  reg [31:0]           sram_rdata[NUM_MEM-1 :0];
  reg                  sram_sel;
  reg                  sram_we;

  reg [NUM_MEM-1 :0] sram_cs_n;
  reg [NUM_MEM-1 :0] sram_cs_n_lat;
  reg [NUM_MEM-1 :0] sram_we_n;

  reg [31:0] haddr_lat;
  wire       dec_err;

  reg [DWIDTH-1 :0] hrdata_lsw;
  wire[DWIDTH-1 :0] hrdata_loc;

  reg [3:0]  hsize_lat;

  genvar  i;
  integer j;

//--------------------------
//Identify valid transaction
//--------------------------
  //assign dec_err  = hready & hsel & (haddr[31:16] != 16'h2000);
  assign dec_err  = 1'b0;
  assign valid_wr = hready & hsel &  hwrite & ~dec_err;
  assign valid_rd = hready & hsel & ~hwrite & ~dec_err;

//--------------------------
//Capture write address
//--------------------------

  always @(posedge hclk or negedge hresetn) begin 
    if (hresetn == 1'b0) begin
      haddr_lat <= 32'b0;
    end
    else if (ahb_ns[WRITE] | ahb_ns[WAIT]) begin
      haddr_lat <= haddr;
    end
  end

  always @(posedge hclk or negedge hresetn) begin 
    if (hresetn == 1'b0) begin
      hsize_lat <= 4'b0;
    end
    else begin
      hsize_lat <= hsize;
    end
  end




//-----------------------------------------------
// Logic for generating sram addr/control signals
//-----------------------------------------------

always@*  begin
  ahb_ns    = 5'b0_0000;
  sram_sel  = 1'b0;
  sram_we   = 1'b0;
  haddr_loc = 16'b0;
  hsize_loc = 4'b0;
  case (1'b1)
    ahb_ps[IDLE] : begin
      if (hsel == 1'b1) begin
        if (dec_err == 1'b1) begin
          ahb_ns[ERROR] = 1'b1;
        end
        else if (hwrite == 1'b0) begin
          ahb_ns[READ] = 1'b1;
          sram_sel     = 1'b1;
          haddr_loc    = haddr[ADDRWIDTH-1 :0];
          hsize_loc    = hsize[3:0];
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
          haddr_loc    = haddr[ADDRWIDTH-1 :0];
          hsize_loc    = hsize[3:0];
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
      sram_we   = 1'b1;
      haddr_loc = haddr_lat[ADDRWIDTH-1 :0];
      hsize_loc = hsize_lat[3:0];
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
      haddr_loc = haddr_lat[ADDRWIDTH-1 :0];
      hsize_loc = hsize_lat[3:0];
      ahb_ns[IDLE] = 1'b1;
    end //WAIT
    ahb_ps[ERROR] : begin
      ahb_ns[IDLE] = 1'b1;
    end //ERROR
    default  : begin
      sram_sel     = 1'b0;
      sram_we      = 1'b0;
      haddr_loc    = 16'b0;
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

//----------------------------
// hsize
// 0000 - byte
// 0001 - hword
// 0010 - word
// 1000 - 128 bit
//----------------------------
//-----------------------------------------------
// Memory Instantiation
//-----------------------------------------------

generate
  for (i=0; i<NUM_MEM; i=i+1) begin
     assign sram_cs_n[i] = hsize_loc[2] ? ~sram_sel : ((haddr_loc[3:2] == i) ? ~sram_sel : 1'b1);
     assign sram_we_n[i] = hsize_loc[2] ? ~sram_we  : ((haddr_loc[3:2] == i) ? ~sram_we  : 1'b1);
     assign hrdata_loc[32*(i+1)-1 : 32*(i+1)-32] = sram_rdata[i];

    `ifdef FPGA_SYNTH
       blk_mem_gen_0 \genblk1[0].u_sram_inst  (
         .clka(hclk),
         .ena(~sram_cs_n[i]),
         .wea(~sram_we_n[i]),
         .addra(haddr_loc[ADDRWIDTH-1 :4]),
         .dina(hsize_lat[2] ? hwdata[32*(i+1)-1 : 32*(i+1)-32] : hwdata[31:0]),
         .douta(sram_rdata[i])
      );
    `else
      spram_hd_32x8192 u_spram_inst (
       .CLK            (hclk),                          //Clock
       .CEN            (sram_cs_n[i]),                  //Chip Select
       .WEN            (sram_we_n[i]),                  //Write Enable
       .A              (haddr_loc[ADDRWIDTH-1 :4]),     //Address input wire [9:0]
       .D              (hsize_lat[2] ? hwdata[32*(i+1)-1 : 32*(i+1)-32] : hwdata[31:0]),
       .TEN            (~sram_ctl[0]),                //1'b1 : Mission mode
       .TCEN           (~sram_ctl[1]),
       .TWEN           (sram_ctl[2]),
       .RET1N          (~sram_ctl[3]),
       .SE             (sram_ctl[4]),
       .DFTRAMBYP      (sram_ctl[5]),
       .SI             (sram_ctl[7:6]),
       .EMA            ({~sram_ctl[10], sram_ctl[9], sram_ctl[8]}),
       .EMAW           (sram_ctl[12:11]),
       //.EMAS           (sram_ctl[13]),
       .TA             ({sram_ctl[16:13], {(ADDRWIDTH-8){1'b0}}}),
       .TD             ({7'b0, sram_ctl[16], 7'b0, sram_ctl[15], 7'b0, sram_ctl[14], 7'b0, sram_ctl[13]}),
       .Q              (sram_rdata[i])                  //output data wire [31:0]
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
      hrdata_lsw = 128'b0;
    for (j=0; j< NUM_MEM; j=j+1) begin
      hrdata_lsw[31:0] = hrdata_lsw[31:0] | ({32{~sram_cs_n_lat[j]}} & sram_rdata[j]);
    end
  end

  assign hrdata = hsize_lat[2] ? hrdata_loc : hrdata_lsw;


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
