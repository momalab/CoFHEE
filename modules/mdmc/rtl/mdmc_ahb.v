module mdmc_ahb #(
  parameter DWIDTH  = 32) (
  // CLOCK AND RESETS ------------------
  input  wire        hclk,              // Clock
  input  wire        hresetn,           // Asynchronous reset

  // AHB-LITE MASTER PORT --------------
  output reg  [31 :0]       haddr,             // AHB transaction address
  output wire [ 3:0]        hsize,             // AHB size: byte, half-word or word
  output reg  [ 1:0]        htrans,            // AHB transfer: non-sequential only
  output reg  [DWIDTH-1 :0] hwdata,            // AHB write-data
  output reg                hwrite,            // AHB write control
  input  wire [DWIDTH-1 :0] hrdata,            // AHB read-data
  input  wire               hready,            // AHB stall signal
  input  wire               hresp,             // AHB error response

  input  wire [7        :0] base_addr,            // AHB read-data

  // MISCELLANEOUS ---------------------
  input  wire               mdmc_rd,
  input  wire               mdmc_wr,
  input  wire [31       :0] mdmc_addr,
  input  wire [DWIDTH-1 :0] mdmc_wdata,
  output reg  [DWIDTH-1 :0] mdmc_rdata,
  output wire               mdmc_valid
);


reg         read_trans;

//-------------------------------------
//localparams, reg and wire declaration
//-------------------------------------

 //AHB Master Signal generation
  
 always @* begin
   if (mdmc_wr == 1'b1) begin
     hwrite = 1'b1;
   end
   else begin
     hwrite = 1'b0;
   end
 end
 
 always @* begin
   if (mdmc_rd | mdmc_wr) begin
     haddr = {base_addr, mdmc_addr[23:0]};
   end
   else begin
     haddr = 32'b0;
   end
 end
  
 always @ (posedge hclk or negedge hresetn) begin
   if (hresetn == 1'b0) begin
     hwdata <= {DWIDTH{1'b0}};
   end
   else begin
     if (mdmc_wr) begin
       hwdata <= mdmc_wdata;
     end
     else if (hready) begin
       hwdata <= {DWIDTH{1'b0}};
     end
   end
 end
 
 always @* begin
   if (mdmc_rd | mdmc_wr) begin
     htrans = 2'b10;
   end
   else begin
     htrans = 2'b0;
   end
 end

 localparam HSIZE_VAL = $clog2(DWIDTH/8);

 assign hsize  = HSIZE_VAL[3:0]; 
 
 //Capture Read transaction and Read Data from bus
   always @ (posedge hclk or negedge hresetn) begin
     if (hresetn == 1'b0) begin
       read_trans <= 1'b0;
     end
     else begin
       if ((htrans[1] == 1'b1) && (hwrite == 1'b0) && (hready == 1'b1)) begin
           read_trans <= 1'b1;
       end
       else if (hready == 1'b1) begin
         read_trans <= 1'b0;
       end
     end
   end


   always @* begin
     if (read_trans & hready) begin
       mdmc_rdata  = hrdata;
     end
     else begin
       mdmc_rdata  = {DWIDTH{1'b0}};
     end
   end

   assign mdmc_valid = read_trans & hready;

endmodule
