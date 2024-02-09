
`timescale 1 ns/1 ps
module mdmc #(
parameter DWIDTH   = 32,
parameter NMUL     = 32,
parameter POLYDEG  = 2048)
(

input  wire              hclk, 
input  wire              hresetn,
input  wire              trig_ntt,
input  wire              trig_intt,
input  wire              trig_mul,
input  wire              trig_add,
input  wire              trig_sub,
output reg               ntt_done,
output reg               intt_done,
output reg               mul_done,
output reg               add_done,
output reg               sub_done,
// AHB-LITE MASTER PORT --------------
output reg  [31:0]       haddr_a,             // AHB transaction address
output wire [ 3:0]       hsize_a,             // AHB size: byte, half-word or word
output reg  [ 1:0]       htrans_a,            // AHB transfer: non-sequential only
output reg  [DWIDTH-1:0] hwdata_a,            // AHB write-data
output reg               hwrite_a,            // AHB write control
input  wire [DWIDTH-1:0] hrdata_a,            // AHB read-data
input  wire              hready_a,            // AHB stall signal
input  wire              hresp_a,             // AHB error response
// AHB-LITE MASTER PORT --------------
output reg  [31:0]       haddr_t,             // AHB transaction address
output wire [ 3:0]       hsize_t,             // AHB size: byte, half-word or word
output reg  [ 1:0]       htrans_t,            // AHB transfer: non-sequential only
output reg  [DWIDTH-1:0] hwdata_t,            // AHB write-data
output reg               hwrite_t,            // AHB write control
input  wire [DWIDTH-1:0] hrdata_t,            // AHB read-data
input  wire              hready_t,            // AHB stall signal
input  wire              hresp_t,             // AHB error response
// AHB-LITE MASTER PORT --------------
output reg  [31:0]       haddr_b,             // AHB transaction address
output wire [ 3:0]       hsize_b,             // AHB size: byte, half-word or word
output reg  [ 1:0]       htrans_b,            // AHB transfer: non-sequential only
output reg  [DWIDTH-1:0] hwdata_b,            // AHB write-data
output reg               hwrite_b,            // AHB write control
input  wire [DWIDTH-1:0] hrdata_b,            // AHB read-data
input  wire              hready_b,            // AHB stall signal
input  wire              hresp_b,             // AHB error response
// AHB-LITE MASTER PORT --------------
output reg  [31:0]       haddr_r,             // AHB transaction address
output wire [ 3:0]       hsize_r,             // AHB size: byte, half-word or word
output reg  [ 1:0]       htrans_r,            // AHB transfer: non-sequential only
output reg  [DWIDTH-1:0] hwdata_r,            // AHB write-data
output reg               hwrite_r,            // AHB write control
input  wire [DWIDTH-1:0] hrdata_r,            // AHB read-data
input  wire              hready_r,            // AHB stall signal
input  wire              hresp_r,             // AHB error response
// AHB-LITE MASTER PORT --------------
output reg  [31:0]         haddr_mpool_wr,             // AHB transaction address
output wire [ 3:0]         hsize_mpool_wr,             // AHB size: byte, half-word or word
output reg  [ 1:0]         htrans_mpool_wr,            // AHB transfer: non-sequential only
output reg  [3*DWIDTH-1:0] hwdata_mpool_wr,            // AHB write-data
output reg                 hwrite_mpool_wr,            // AHB write control
input  wire                hready_mpool_wr,            // AHB stall signal
input  wire                hresp_mpool_wr,                                                                // AHB error response
// AHB-LITE MASTER PORT --------------
output reg  [31:0]         haddr_mpool_rd,             // AHB transaction address
output wire [ 3:0]         hsize_mpool_rd,             // AHB size: byte, half-word or word
output reg  [ 1:0]         htrans_mpool_rd,            // AHB transfer: non-sequential only
output reg                 hwrite_mpool_rd,            // AHB write control
input  wire [3*DWIDTH-1:0] hrdata_mpool_rd,            // AHB read-data
input  wire                hready_mpool_rd,            // AHB stall signal
input  wire                hresp_mpool_rd,                                                                // AHB error response
input  wire [7 :0]         base_addr_a,
input  wire [7 :0]         base_addr_b,
input  wire [7 :0]         base_addr_r,
input  wire [7 :0]         base_addr_t,
input  wire [7 :0]         base_addr_mpool,
input  wire [15:0]         polysize,
output wire [2 :0]         mode
);

localparam LOG2POLYDEG     = $clog2(POLYDEG);
localparam LOG2NMUL        = $clog2(NMUL);
localparam LOG2DWIDTHDIV8  = $clog2(DWIDTH/8);

reg  [3:0]             log2polysizesub1;
reg  [LOG2POLYDEG-1:0] polysizesub1;

reg        nttvalid;
reg        mulvalid;
reg        addvalid;
reg        subvalid;
reg        nttvalid_d;
reg        mulvalid_d;
reg        addvalid_d;
reg        subvalid_d;
reg        nttvalid_2d;
reg        mulvalid_2d;
reg        addvalid_2d;
reg        subvalid_2d;

wire       ntt_valid_mpool;

reg        ntt_ld;
reg        ntt_str;
reg        ntt_ld_d;
reg        ntt_ld_2d;
reg        ntt_ld_3d;
reg        ntt_str_d;
reg        ntt_str_2d;
reg        ntt_b2b_ld_str;

reg        addmul_ld;
reg        addmul_str;
reg        addmul_ld_d;
reg        addmul_ld_2d;
reg        addmul_str_d;
reg        addmul_str_2d;



genvar    gi;


//------------------------------------------------------------------------
//NTT
//Every stage of NTT there will be odd and even coeffecients sets upon which NTT is performed
//Number of even/odd coeffecient sets in each stage          = nttcnt     = POLYDEG/2**(stage+1)  0 <= stage < LOG2POLYDEG
//Number of coeffecients in odd/even sets in a given stage   = npointdiv2 = 2**(stage+1)          0 <= stage < LOG2POLYDEG
//Butterfly inputs are these odd and even coeffecients.
//At any stage Butterfly input = A[ncnt] and A[ncnt + npointdiv2] and h will increment by 1 until it reaches Neos,
//then it will increment by bsetcnt*2*Neos, where bsetcnt is the even-odd pair sequence in that stage. 0 <= bsetcnt <= nttcnt
//There will be POLYDEG/2 butterfly each stage
//------------------------------------------------------------------------


wire [DWIDTH-1:0]   oprnda;
wire [DWIDTH-1:0]   oprndb;
wire [DWIDTH-1:0]   tfactor;
wire [3*DWIDTH-1:0] mulresult;

reg  [7 :0]         base_addr_a_loc;
reg  [7 :0]         base_addr_b_loc;
reg  [7 :0]         base_addr_r_loc;
wire [7 :0]         base_addr_t_loc;
wire [7 :0]         base_addr_mpool_loc;




reg   [LOG2NMUL :0]    ncnt_mul;
reg   [LOG2NMUL :0]    ncnt_mul_ld;

reg  [LOG2POLYDEG-1 :0] stagecnt_ld;
reg  [LOG2POLYDEG-1 :0] stagecnt_str;
reg  [LOG2POLYDEG-1 :0] ncnt_ld;
reg  [LOG2POLYDEG-1 :0] ncnt_str;
reg  [LOG2POLYDEG-1 :0] tcnt_incr_ld;
reg  [LOG2POLYDEG-1 :0] bsetcnt_ld;
reg  [LOG2POLYDEG-1 :0] bsetcnt_str;

reg                     last_set_in_stage;

reg  [LOG2POLYDEG-1 :0] tcnt_ld;

wire [LOG2POLYDEG-1 :0] npointdiv2_ld;
wire [LOG2POLYDEG-1 :0] npointdiv2_str;
wire [LOG2POLYDEG-1 :0] nttcnt;

wire [LOG2POLYDEG-1 :0] ncnt_off_ld;
wire [LOG2POLYDEG-1 :0] ncnt_off_str;

reg  [LOG2POLYDEG-1 :0] ncnt_rev_ld;
reg  [LOG2POLYDEG-1 :0] ncnt_off_rev_ld;
reg  [LOG2POLYDEG-1 :0] ncnt_rev_ld_8k;
reg  [LOG2POLYDEG-1 :0] ncnt_off_rev_ld_8k;
reg  [LOG2POLYDEG-2 :0] ncnt_rev_ld_4k;
reg  [LOG2POLYDEG-2 :0] ncnt_off_rev_ld_4k;
reg  [LOG2POLYDEG-3 :0] ncnt_rev_ld_2k;
reg  [LOG2POLYDEG-3 :0] ncnt_off_rev_ld_2k;
reg  [LOG2POLYDEG-4 :0] ncnt_rev_ld_1k;
reg  [LOG2POLYDEG-4 :0] ncnt_off_rev_ld_1k;
reg  [LOG2POLYDEG-5 :0] ncnt_rev_ld_512;
reg  [LOG2POLYDEG-5 :0] ncnt_off_rev_ld_512;
reg  [LOG2POLYDEG-6 :0] ncnt_rev_ld_256;
reg  [LOG2POLYDEG-6 :0] ncnt_off_rev_ld_256;
reg  [LOG2POLYDEG-7 :0] ncnt_rev_ld_128;
reg  [LOG2POLYDEG-7 :0] ncnt_off_rev_ld_128;

reg  [LOG2POLYDEG-1 :0] ncnt_rev_str;
reg  [LOG2POLYDEG-1 :0] ncnt_off_rev_str;
reg  [LOG2POLYDEG-1 :0] ncnt_rev_str_8k;
reg  [LOG2POLYDEG-1 :0] ncnt_off_rev_str_8k;
reg  [LOG2POLYDEG-2 :0] ncnt_rev_str_4k;
reg  [LOG2POLYDEG-2 :0] ncnt_off_rev_str_4k;
reg  [LOG2POLYDEG-3 :0] ncnt_rev_str_2k;
reg  [LOG2POLYDEG-3 :0] ncnt_off_rev_str_2k;
reg  [LOG2POLYDEG-4 :0] ncnt_rev_str_1k;
reg  [LOG2POLYDEG-4 :0] ncnt_off_rev_str_1k;
reg  [LOG2POLYDEG-5 :0] ncnt_rev_str_512;
reg  [LOG2POLYDEG-5 :0] ncnt_off_rev_str_512;
reg  [LOG2POLYDEG-6 :0] ncnt_rev_str_256;
reg  [LOG2POLYDEG-6 :0] ncnt_off_rev_str_256;
reg  [LOG2POLYDEG-7 :0] ncnt_rev_str_128;
reg  [LOG2POLYDEG-7 :0] ncnt_off_rev_str_128;




reg  ntt_mode;

assign npointdiv2_ld  = (1'b1 << stagecnt_ld);
assign npointdiv2_str = (1'b1 << stagecnt_str);

always @ (posedge hclk or negedge hresetn) begin
  if (hresetn == 1'b0) begin
    stagecnt_ld  <= {LOG2POLYDEG{1'b0}};
    ncnt_ld      <= {LOG2POLYDEG{1'b0}};   
    tcnt_ld      <= {LOG2POLYDEG{1'b0}};
    tcnt_incr_ld <= POLYDEG >> 1'b1;   
    bsetcnt_ld   <= {LOG2POLYDEG{1'b0}};
  end
  else begin
    if (nttvalid == 1'b1) begin
      if (ntt_ld_d  == 1'b1) begin
        if (ncnt_ld == (polysize - npointdiv2_ld - 1'b1)) begin
          stagecnt_ld  <= stagecnt_ld + 1'b1;
          tcnt_ld      <= {LOG2POLYDEG{1'b0}};
          tcnt_incr_ld <= tcnt_incr_ld >> 1'b1 ;
          ncnt_ld      <= {LOG2POLYDEG{1'b0}};
          bsetcnt_ld   <= {LOG2POLYDEG{1'b0}};
        end
        else if (ncnt_ld == ((bsetcnt_ld*(npointdiv2_ld << 1'b1)) + npointdiv2_ld - 1'b1)) begin
          ncnt_ld    <= ncnt_ld + npointdiv2_ld + 1'b1;
          bsetcnt_ld <= bsetcnt_ld + 1'b1;
          tcnt_ld    <= {LOG2POLYDEG{1'b0}};
        end
        else begin
          ncnt_ld <= ncnt_ld + 1'b1;
          tcnt_ld <= tcnt_ld + tcnt_incr_ld;
        end
      end
    end
    else if (mulvalid | addvalid | subvalid) begin
      ncnt_ld <= ncnt_ld + 1'b1;
    end
    else begin
      stagecnt_ld  <= {LOG2POLYDEG{1'b0}};
      tcnt_ld      <= {LOG2POLYDEG{1'b0}};
      tcnt_incr_ld <= {LOG2POLYDEG{1'b0}};   
      ncnt_ld      <= {LOG2POLYDEG{1'b0}};
      bsetcnt_ld   <= {LOG2POLYDEG{1'b0}};
    end
  end
end


always @ (posedge hclk or negedge hresetn) begin
  if (hresetn == 1'b0) begin
    stagecnt_str  <= {LOG2POLYDEG{1'b0}};
    ncnt_str      <= {LOG2POLYDEG{1'b0}};   
    bsetcnt_str   <= {LOG2POLYDEG{1'b0}};
  end
  else begin
    if (nttvalid == 1'b1) begin
      if (ntt_str_2d  == 1'b1) begin
        if (ncnt_str == (polysize - npointdiv2_str - 1'b1)) begin
          stagecnt_str  <= stagecnt_str + 1'b1;
          ncnt_str      <= {LOG2POLYDEG{1'b0}};
          bsetcnt_str   <= {LOG2POLYDEG{1'b0}};
        end
        else if (ncnt_str == ((bsetcnt_str*(npointdiv2_str << 1'b1)) + npointdiv2_str - 1'b1)) begin
          ncnt_str    <= ncnt_str + npointdiv2_str + 1'b1;
          bsetcnt_str <= bsetcnt_str + 1'b1;
        end
        else begin
          ncnt_str <= ncnt_str + 1'b1;
        end
      end
    end
    else if (mulvalid | addvalid | subvalid) begin
      ncnt_str <= ncnt_str + 1'b1;
    end
    else begin
      stagecnt_str  <= {LOG2POLYDEG{1'b0}};
      ncnt_str      <= {LOG2POLYDEG{1'b0}};
      bsetcnt_str   <= {LOG2POLYDEG{1'b0}};
    end
  end
end

assign ncnt_off_ld  = nttvalid ? (ncnt_ld  + npointdiv2_ld)  : ncnt_ld;
assign ncnt_off_str = nttvalid ? (ncnt_str + npointdiv2_str) : ncnt_str;


always @* begin 
  if (polysize[LOG2POLYDEG] == 1'b1) begin
    ncnt_rev_ld[LOG2POLYDEG-1 :0]     = ncnt_rev_ld_8k;
    ncnt_off_rev_ld[LOG2POLYDEG-1 :0] = ncnt_off_rev_ld_8k;
  end
  else if (polysize[LOG2POLYDEG-1] == 1'b1) begin
    ncnt_rev_ld[LOG2POLYDEG-1]        = 1'b0;
    ncnt_off_rev_ld[LOG2POLYDEG-1]    = 1'b0;
    ncnt_rev_ld[LOG2POLYDEG-2 :0]     = ncnt_rev_ld_4k;
    ncnt_off_rev_ld[LOG2POLYDEG-2 :0] = ncnt_off_rev_ld_4k;
  end
  else if (polysize[LOG2POLYDEG-2] == 1'b1) begin
    ncnt_rev_ld[LOG2POLYDEG-1:LOG2POLYDEG-2]     = 1'b0;
    ncnt_off_rev_ld[LOG2POLYDEG-1:LOG2POLYDEG-2] = 1'b0;
    ncnt_rev_ld[LOG2POLYDEG-3 :0]                = ncnt_rev_ld_2k;
    ncnt_off_rev_ld[LOG2POLYDEG-3 :0]            = ncnt_off_rev_ld_2k;
  end
  else if (polysize[LOG2POLYDEG-3] == 1'b1) begin
    ncnt_rev_ld[LOG2POLYDEG-1:LOG2POLYDEG-3]     = 1'b0;
    ncnt_off_rev_ld[LOG2POLYDEG-1:LOG2POLYDEG-3] = 1'b0;
    ncnt_rev_ld[LOG2POLYDEG-4 :0]                = ncnt_rev_ld_1k;
    ncnt_off_rev_ld[LOG2POLYDEG-4 :0]            = ncnt_off_rev_ld_1k;
  end
  else if (polysize[LOG2POLYDEG-4] == 1'b1) begin
    ncnt_rev_ld[LOG2POLYDEG-1:LOG2POLYDEG-4]     = 1'b0;
    ncnt_off_rev_ld[LOG2POLYDEG-1:LOG2POLYDEG-4] = 1'b0;
    ncnt_rev_ld[LOG2POLYDEG-5 :0]                = ncnt_rev_ld_512;
    ncnt_off_rev_ld[LOG2POLYDEG-5 :0]            = ncnt_off_rev_ld_512;
  end
  else if (polysize[LOG2POLYDEG-5] == 1'b1) begin
    ncnt_rev_ld[LOG2POLYDEG-1:LOG2POLYDEG-5]     = 1'b0;
    ncnt_off_rev_ld[LOG2POLYDEG-1:LOG2POLYDEG-5] = 1'b0;
    ncnt_rev_ld[LOG2POLYDEG-6 :0]                = ncnt_rev_ld_256;
    ncnt_off_rev_ld[LOG2POLYDEG-6 :0]            = ncnt_off_rev_ld_256;
  end
  else begin
    ncnt_rev_ld[LOG2POLYDEG-1:LOG2POLYDEG-6]     = 1'b0;
    ncnt_off_rev_ld[LOG2POLYDEG-1:LOG2POLYDEG-6] = 1'b0;
    ncnt_rev_ld[LOG2POLYDEG-7 :0]                = ncnt_rev_ld_128;
    ncnt_off_rev_ld[LOG2POLYDEG-7 :0]            = ncnt_off_rev_ld_128;
  end
end

generate
  for (gi=LOG2POLYDEG-1; gi >= 0; gi=gi-1) begin
    always @* begin 
      ncnt_rev_ld_8k[LOG2POLYDEG-1-gi]       = ncnt_ld[gi];
      ncnt_off_rev_ld_8k[LOG2POLYDEG-1-gi]   = ncnt_off_ld[gi];
    end
  end
endgenerate

generate
  for (gi=LOG2POLYDEG-2; gi >= 0; gi=gi-1) begin
    always @* begin 
      ncnt_rev_ld_4k[LOG2POLYDEG-2-gi]       = ncnt_ld[gi];
      ncnt_off_rev_ld_4k[LOG2POLYDEG-2-gi]   = ncnt_off_ld[gi];
    end
  end
endgenerate

generate
  for (gi=LOG2POLYDEG-3; gi >= 0; gi=gi-1) begin
    always @* begin 
      ncnt_rev_ld_2k[LOG2POLYDEG-3-gi]       = ncnt_ld[gi];
      ncnt_off_rev_ld_2k[LOG2POLYDEG-3-gi]   = ncnt_off_ld[gi];
    end
  end
endgenerate

generate
  for (gi=LOG2POLYDEG-4; gi >= 0; gi=gi-1) begin
    always @* begin 
      ncnt_rev_ld_1k[LOG2POLYDEG-4-gi]       = ncnt_ld[gi];
      ncnt_off_rev_ld_1k[LOG2POLYDEG-4-gi]   = ncnt_off_ld[gi];
    end
  end
endgenerate

generate
  for (gi=LOG2POLYDEG-5; gi >= 0; gi=gi-1) begin
    always @* begin 
      ncnt_rev_ld_512[LOG2POLYDEG-5-gi]       = ncnt_ld[gi];
      ncnt_off_rev_ld_512[LOG2POLYDEG-5-gi]   = ncnt_off_ld[gi];
    end
  end
endgenerate

generate
  for (gi=LOG2POLYDEG-6; gi >= 0; gi=gi-1) begin
    always @* begin 
      ncnt_rev_ld_256[LOG2POLYDEG-6-gi]       = ncnt_ld[gi];
      ncnt_off_rev_ld_256[LOG2POLYDEG-6-gi]   = ncnt_off_ld[gi];
    end
  end
endgenerate

generate
  for (gi=LOG2POLYDEG-7; gi >= 0; gi=gi-1) begin
    always @* begin 
      ncnt_rev_ld_128[LOG2POLYDEG-7-gi]       = ncnt_ld[gi];
      ncnt_off_rev_ld_128[LOG2POLYDEG-7-gi]   = ncnt_off_ld[gi];
    end
  end
endgenerate


always @* begin 
  if (polysize[LOG2POLYDEG] == 1'b1) begin
    ncnt_rev_str[LOG2POLYDEG-1 :0]     = ncnt_rev_str_8k;
    ncnt_off_rev_str[LOG2POLYDEG-1 :0] = ncnt_off_rev_str_8k;
  end
  else if (polysize[LOG2POLYDEG-1] == 1'b1) begin
    ncnt_rev_str[LOG2POLYDEG-1]        = 1'b0;
    ncnt_off_rev_str[LOG2POLYDEG-1]    = 1'b0;
    ncnt_rev_str[LOG2POLYDEG-2 :0]     = ncnt_rev_str_4k;
    ncnt_off_rev_str[LOG2POLYDEG-2 :0] = ncnt_off_rev_str_4k;
  end
  else if (polysize[LOG2POLYDEG-2] == 1'b1) begin
    ncnt_rev_str[LOG2POLYDEG-1:LOG2POLYDEG-2]     = 1'b0;
    ncnt_off_rev_str[LOG2POLYDEG-1:LOG2POLYDEG-2] = 1'b0;
    ncnt_rev_str[LOG2POLYDEG-3 :0]                = ncnt_rev_str_2k;
    ncnt_off_rev_str[LOG2POLYDEG-3 :0]            = ncnt_off_rev_str_2k;
  end
  else if (polysize[LOG2POLYDEG-3] == 1'b1) begin
    ncnt_rev_str[LOG2POLYDEG-1:LOG2POLYDEG-3]     = 1'b0;
    ncnt_off_rev_str[LOG2POLYDEG-1:LOG2POLYDEG-3] = 1'b0;
    ncnt_rev_str[LOG2POLYDEG-4 :0]                = ncnt_rev_str_1k;
    ncnt_off_rev_str[LOG2POLYDEG-4 :0]            = ncnt_off_rev_str_1k;
  end
  else if (polysize[LOG2POLYDEG-4] == 1'b1) begin
    ncnt_rev_str[LOG2POLYDEG-1:LOG2POLYDEG-4]     = 1'b0;
    ncnt_off_rev_str[LOG2POLYDEG-1:LOG2POLYDEG-4] = 1'b0;
    ncnt_rev_str[LOG2POLYDEG-5 :0]                = ncnt_rev_str_512;
    ncnt_off_rev_str[LOG2POLYDEG-5 :0]            = ncnt_off_rev_str_512;
  end
  else if (polysize[LOG2POLYDEG-5] == 1'b1) begin
    ncnt_rev_str[LOG2POLYDEG-1:LOG2POLYDEG-5]     = 1'b0;
    ncnt_off_rev_str[LOG2POLYDEG-1:LOG2POLYDEG-5] = 1'b0;
    ncnt_rev_str[LOG2POLYDEG-6 :0]                = ncnt_rev_str_256;
    ncnt_off_rev_str[LOG2POLYDEG-6 :0]            = ncnt_off_rev_str_256;
  end
  else begin
    ncnt_rev_str[LOG2POLYDEG-1:LOG2POLYDEG-6]     = 1'b0;
    ncnt_off_rev_str[LOG2POLYDEG-1:LOG2POLYDEG-6] = 1'b0;
    ncnt_rev_str[LOG2POLYDEG-7 :0]                = ncnt_rev_str_128;
    ncnt_off_rev_str[LOG2POLYDEG-7 :0]            = ncnt_off_rev_str_128;
  end
end

generate
  for (gi=LOG2POLYDEG-1; gi >= 0; gi=gi-1) begin
    always @* begin 
      ncnt_rev_str_8k[LOG2POLYDEG-1-gi]       = ncnt_str[gi];
      ncnt_off_rev_str_8k[LOG2POLYDEG-1-gi]   = ncnt_off_str[gi];
    end
  end
endgenerate

generate
  for (gi=LOG2POLYDEG-2; gi >= 0; gi=gi-1) begin
    always @* begin 
      ncnt_rev_str_4k[LOG2POLYDEG-2-gi]       = ncnt_str[gi];
      ncnt_off_rev_str_4k[LOG2POLYDEG-2-gi]   = ncnt_off_str[gi];
    end
  end
endgenerate

generate
  for (gi=LOG2POLYDEG-3; gi >= 0; gi=gi-1) begin
    always @* begin 
      ncnt_rev_str_2k[LOG2POLYDEG-3-gi]       = ncnt_str[gi];
      ncnt_off_rev_str_2k[LOG2POLYDEG-3-gi]   = ncnt_off_str[gi];
    end
  end
endgenerate

generate
  for (gi=LOG2POLYDEG-4; gi >= 0; gi=gi-1) begin
    always @* begin 
      ncnt_rev_str_1k[LOG2POLYDEG-4-gi]       = ncnt_str[gi];
      ncnt_off_rev_str_1k[LOG2POLYDEG-4-gi]   = ncnt_off_str[gi];
    end
  end
endgenerate

generate
  for (gi=LOG2POLYDEG-5; gi >= 0; gi=gi-1) begin
    always @* begin 
      ncnt_rev_str_512[LOG2POLYDEG-5-gi]       = ncnt_str[gi];
      ncnt_off_rev_str_512[LOG2POLYDEG-5-gi]   = ncnt_off_str[gi];
    end
  end
endgenerate

generate
  for (gi=LOG2POLYDEG-6; gi >= 0; gi=gi-1) begin
    always @* begin 
      ncnt_rev_str_256[LOG2POLYDEG-6-gi]       = ncnt_str[gi];
      ncnt_off_rev_str_256[LOG2POLYDEG-6-gi]   = ncnt_off_str[gi];
    end
  end
endgenerate

generate
  for (gi=LOG2POLYDEG-7; gi >= 0; gi=gi-1) begin
    always @* begin 
      ncnt_rev_str_128[LOG2POLYDEG-7-gi]       = ncnt_str[gi];
      ncnt_off_rev_str_128[LOG2POLYDEG-7-gi]   = ncnt_off_str[gi];
    end
  end
endgenerate



assign polysizesub1 = polysize - 1'b1;


always @* begin 
  if (polysize[LOG2POLYDEG] == 1'b1) begin
    log2polysizesub1 = LOG2POLYDEG-1;
  end
  else if (polysize[LOG2POLYDEG-1] == 1'b1) begin
    log2polysizesub1 = LOG2POLYDEG-2;
  end
  else if (polysize[LOG2POLYDEG-2] == 1'b1) begin
    log2polysizesub1 = LOG2POLYDEG-3;
  end
  else if (polysize[LOG2POLYDEG-3] == 1'b1) begin
    log2polysizesub1 = LOG2POLYDEG-4;
  end
  else if (polysize[LOG2POLYDEG-4] == 1'b1) begin
    log2polysizesub1 = LOG2POLYDEG-5;
  end
  else if (polysize[LOG2POLYDEG-5] == 1'b1) begin
    log2polysizesub1 = LOG2POLYDEG-6;
  end
  else begin
    log2polysizesub1 = LOG2POLYDEG-7;
  end
end



mdmc_ahb #(
  .DWIDTH (DWIDTH)) u_mdmc_ahb_a_inst (
  .hclk       (hclk),       //input  
  .hresetn    (hresetn),    //input  
  .haddr      (haddr_a),    //output 
  .hsize      (hsize_a),    //output 
  .htrans     (htrans_a),   //output 
  .hwdata     (hwdata_a),   //output 
  .hwrite     (hwrite_a),   //output 
  .hrdata     (hrdata_a),   //input  
  .hready     (hready_a),   //input  
  .hresp      (hresp_a),    //input  
  .base_addr  (stagecnt_ld[0] ? base_addr_r : base_addr_a),//input  
  .mdmc_rd    (ntt_ld | addmul_ld),     //input  
  .mdmc_wr    (1'b0),       //input  
  .mdmc_addr  (ntt_mode ? (32'b0 | {ncnt_rev_ld, {LOG2DWIDTHDIV8{1'b0}}}) :
                          (32'b0 | {ncnt_ld,     {LOG2DWIDTHDIV8{1'b0}}})),   //input  
  .mdmc_wdata ({DWIDTH{1'b0}}), //input  
  .mdmc_rdata (oprnda),                 //output 
  .mdmc_valid (ntt_valid_a)             //output 
);


mdmc_ahb #(
  .DWIDTH (DWIDTH)) u_mdmc_ahb_b_inst (
  .hclk       (hclk),                       //input  
  .hresetn    (hresetn),                    //input  
  .haddr      (haddr_b),                    //output 
  .hsize      (hsize_b),                    //output 
  .htrans     (htrans_b),                   //output 
  .hwdata     (hwdata_b),                   //output 
  .hwrite     (hwrite_b),                   //output 
  .hrdata     (hrdata_b),                   //input  
  .hready     (hready_b),                   //input  
  .hresp      (hresp_b),                    //input  
  .base_addr  (stagecnt_ld[0] ? base_addr_r : base_addr_b),//input  
  .mdmc_rd    (ntt_ld_d | addmul_ld),       //input   //TODO check whether gating with hready_a is needed
  .mdmc_wr    (1'b0),                       //input  
  .mdmc_addr  ( ntt_mode ? (32'b0 | {ncnt_off_rev_ld, {LOG2DWIDTHDIV8{1'b0}}}) :
                           (32'b0 | {ncnt_off_ld,     {LOG2DWIDTHDIV8{1'b0}}})),               //input  
  .mdmc_wdata ({DWIDTH{1'b0}}), //input  
  .mdmc_rdata (oprndb),         //output 
  .mdmc_valid (ntt_valid_b)     //output 
);



mdmc_ahb #(
  .DWIDTH (DWIDTH)) u_mdmc_ahb_t_inst (
  .hclk       (hclk),        //input  
  .hresetn    (hresetn),     //input  
  .haddr      (haddr_t),     //output 
  .hsize      (hsize_t),     //output 
  .htrans     (htrans_t),    //output 
  .hwdata     (hwdata_t),    //output 
  .hwrite     (hwrite_t),    //output 
  .hrdata     (hrdata_t),    //input  
  .hready     (hready_t),    //input  
  .hresp      (hresp_t),     //input  
  .base_addr  (base_addr_t), //input  
  .mdmc_rd    (ntt_ld),      //input  
  .mdmc_wr    (1'b0),        //input  
  .mdmc_addr  ((32'b0 | {tcnt_ld, {LOG2DWIDTHDIV8{1'b0}}})),   //input  
  .mdmc_wdata ({DWIDTH{1'b0}}),        //input  
  .mdmc_rdata (tfactor[DWIDTH-1:0]),   //output 
  .mdmc_valid (ntt_valid_t)            //output 
);

mdmc_ahb #(
  .DWIDTH (3*DWIDTH)) u_mdmc_ahb_mpool_wr_inst (
  .hclk       (hclk),               //input  
  .hresetn    (hresetn),            //input  
  .haddr      (haddr_mpool_wr),     //output 
  .hsize      (hsize_mpool_wr),     //output 
  .htrans     (htrans_mpool_wr),    //output 
  .hwdata     (hwdata_mpool_wr),    //output 
  .hwrite     (hwrite_mpool_wr),    //output 
  .hrdata     ({(DWIDTH*3){1'b0}}),  //input  
  .hready     (hready_mpool_wr),    //input  
  .hresp      (hresp_mpool_wr),     //input  
  .base_addr  (base_addr_mpool),    //input  
  .mdmc_rd    (1'b0),               //input  
  .mdmc_wr    (ntt_ld_3d),          //input   //TODO check whether gating with hready_a is needed
  .mdmc_addr  ((32'b0 | ncnt_mul_ld[LOG2NMUL-1 :0])),   //input  
  .mdmc_wdata ({tfactor, hrdata_b, oprnda}),   //input  
  .mdmc_rdata (),                   //output 
  .mdmc_valid ()                    //output 
);


mdmc_ahb #(
  .DWIDTH (3*DWIDTH)) u_mdmc_ahb_mpool_rd_inst (
  .hclk       (hclk),            //input  
  .hresetn    (hresetn),         //input  
  .haddr      (haddr_mpool_rd),  //output 
  .hsize      (hsize_mpool_rd),  //output 
  .htrans     (htrans_mpool_rd), //output 
  .hwdata     (),                //output 
  .hwrite     (hwrite_mpool_rd), //output 
  .hrdata     (hrdata_mpool_rd), //input  
  .hready     (hready_mpool_rd), //input  
  .hresp      (hresp_mpool_rd),  //input  
  .base_addr  (base_addr_mpool), //input  
  .mdmc_rd    (ntt_str),         //input  
  .mdmc_wr    (1'b0),            //input   //TODO check whether gating with hready_a is needed
  .mdmc_addr  ((32'b0 | ncnt_mul[LOG2NMUL-1 :0])),   //input  
  .mdmc_wdata ({(DWIDTH*3){1'b0}}),   //input  
  .mdmc_rdata (mulresult),      //output 
  .mdmc_valid (ntt_valid_mpool) //output 
);


mdmc_ahb #(
  .DWIDTH (DWIDTH)) u_mdmc_ahb_r_inst (
  .hclk       (hclk),         //input  
  .hresetn    (hresetn),      //input  
  .haddr      (haddr_r),      //output 
  .hsize      (hsize_r),      //output 
  .htrans     (htrans_r),     //output 
  .hwdata     (hwdata_r),     //output 
  .hwrite     (hwrite_r),     //output 
  .hrdata     (hrdata_r),     //input  
  .hready     (hready_r),     //input  
  .hresp      (hresp_r),      //input  
  .base_addr  (stagecnt_str[0] ? base_addr_b : base_addr_r),//input  
  .mdmc_rd    (1'b0),         //input  
  .mdmc_wr    (ntt_str_d | ntt_str_2d | addmul_str_d),     //input  
  .mdmc_addr  (ntt_mode ?
              (ntt_str_2d ? (32'b0 | {ncnt_off_rev_str, {LOG2DWIDTHDIV8{1'b0}}})   :
                            (32'b0 | {ncnt_rev_str,     {LOG2DWIDTHDIV8{1'b0}}})) :
              (ntt_str_2d ? (32'b0 | {ncnt_off_str,     {LOG2DWIDTHDIV8{1'b0}}})   :
                            (32'b0 | {ncnt_str,         {LOG2DWIDTHDIV8{1'b0}}})) ),  //input  
  .mdmc_wdata (ntt_str_2d ? hrdata_mpool_rd[DWIDTH-1:0] : mulresult[2*DWIDTH-1:DWIDTH] ), //input  
  .mdmc_rdata (),  //output 
  .mdmc_valid ()   //output 
);






  always @ (posedge hclk or negedge hresetn) begin
     if (hresetn == 1'b0) begin
       ntt_ld_d      <= 1'b0;
       ntt_ld_2d     <= 1'b0;
       ntt_ld_3d     <= 1'b0;
       ntt_str_d     <= 1'b0;
       ntt_str_2d    <= 1'b0;
       addmul_ld_d   <= 1'b0;
       addmul_ld_2d  <= 1'b0;
       addmul_str_d  <= 1'b0;
       addmul_str_2d <= 1'b0;
     end
     else begin
       ntt_ld_d      <= ntt_ld;
       ntt_ld_2d     <= ntt_ld_d;
       ntt_ld_3d     <= ntt_ld_2d;
       ntt_str_d     <= ntt_str;
       ntt_str_2d    <= ntt_str_d;
       addmul_ld_d   <= addmul_ld;
       addmul_ld_2d  <= addmul_ld_d;
       addmul_str_d  <= addmul_str;
       addmul_str_2d <= addmul_str_d;
     end
   end


always@(posedge hclk or negedge hresetn) begin
  if(hresetn == 1'b0) begin
    nttvalid_d  <= 1'b0;
    mulvalid_d  <= 1'b0;
    addvalid_d  <= 1'b0;
    subvalid_d  <= 1'b0;
    nttvalid_2d <= 1'b0;
    mulvalid_2d <= 1'b0;
    addvalid_2d <= 1'b0;
    subvalid_2d <= 1'b0;
    ntt_done    <= 1'b0;
    intt_done   <= 1'b0;
    add_done    <= 1'b0;
    mul_done    <= 1'b0;
    sub_done    <= 1'b0;
  end
  else begin
    nttvalid_d  <=  nttvalid;
    mulvalid_d  <=  mulvalid;
    addvalid_d  <=  addvalid;
    subvalid_d  <=  subvalid;
    nttvalid_2d <=  nttvalid_d;
    mulvalid_2d <=  mulvalid_d;
    addvalid_2d <=  addvalid_d;
    subvalid_2d <=  subvalid_d;
    ntt_done    <=  nttvalid_2d & ~nttvalid_d &  ntt_mode;
    intt_done   <=  nttvalid_2d & ~nttvalid_d & ~ntt_mode;
    mul_done    <=  mulvalid_2d & ~mulvalid_d;
    add_done    <=  addvalid_2d & ~addvalid_d;
    sub_done    <=  subvalid_2d & ~subvalid_d;
  end
end


always@(posedge hclk or negedge hresetn) begin
  if (hresetn == 1'b0) begin
    ntt_mode <= 1'b0;
  end
  else if(trig_ntt == 1'b1) begin
    ntt_mode <= 1'b1;
  end
  else if (ntt_done == 1'b1) begin
    ntt_mode <= 1'b0;
  end	  
end



always@(posedge hclk or negedge hresetn) begin
  if(hresetn == 1'b0) begin
    nttvalid <= 0;
  end
  else if(trig_ntt || trig_intt) begin
    nttvalid <= 1'b1;
  end
  else if((stagecnt_str == log2polysizesub1) && (ncnt_str[LOG2POLYDEG-2 :0] == (polysize - npointdiv2_str - 1))) begin  //msb of ncnt_str is used to find out odd or even stage.
    nttvalid <= 1'b0;
  end
end


always@(posedge hclk or negedge hresetn) begin
  if(hresetn == 1'b0) begin
    mulvalid <= 0;
  end
  else if(trig_mul) begin
    mulvalid <= 1'b1;
  end
  else if(ncnt_str == polysizesub1) begin
    mulvalid <= 1'b0;
  end
end

always@(posedge hclk or negedge hresetn) begin
  if (hresetn == 1'b0) begin
    addvalid <= 0;
  end
  else if(trig_add) begin
    addvalid <= 1'b1;
  end
  else if(ncnt_str == (polysizesub1)) begin
    addvalid <= 1'b0;
  end
end

always@(posedge hclk or negedge hresetn) begin
  if (hresetn == 1'b0) begin
    subvalid <= 0;
  end
  else if(trig_sub) begin
    subvalid <= 1'b1;
  end
  else if(ncnt_str == (polysizesub1)) begin
    subvalid <= 1'b0;
  end
end

always@(posedge hclk or negedge hresetn) begin
  if (hresetn == 1'b0) begin
    ncnt_mul_ld <= {(LOG2NMUL+1){1'b0}};
  end
  else begin
    if (ntt_b2b_ld_str == 1'b1) begin
      ncnt_mul_ld <= ncnt_mul - 1'b1;
    end
    else begin
      ncnt_mul_ld <= ncnt_mul;
    end
  end
end

always @ (posedge hclk or negedge hresetn) begin
  if (hresetn == 1'b0) begin
    last_set_in_stage <= 1'b0;
  end
  else begin
    if (stagecnt_str != stagecnt_ld) begin
      last_set_in_stage <= 1'b1;
    end
    else begin
      last_set_in_stage <= 1'b0;
    end
  end
end


always@(posedge hclk or negedge hresetn) begin
  if(hresetn == 1'b0) begin
    ntt_ld         <= 0;
    ntt_str        <= 0;
    ntt_b2b_ld_str <= 0;
    addmul_ld      <= 0;
    addmul_str     <= 0;
    ncnt_mul       <= {(LOG2NMUL+1){1'b0}};
  end
  else begin
    if (nttvalid == 1'b1) begin
      if (last_set_in_stage == 1'b1) begin
        ntt_ld         <= 1'b0;
        ntt_b2b_ld_str <= 1'b0;
        if (ntt_ld_3d) begin
          ntt_str  <= 1'b1;
          ncnt_mul <= ncnt_mul + 1'b1;
        end
        else if (ntt_str_d) begin
          ntt_str  <= ~(&ncnt_mul[LOG2NMUL-1 :0]);
          ncnt_mul <= ncnt_mul + 1'b1;
        end
        else begin
          ntt_str  <= 1'b0;
        end
      end
      else if ((ncnt_mul[LOG2NMUL] == 1'b1) | (ntt_b2b_ld_str == 1'b1)) begin
        ntt_b2b_ld_str <= 1'b1;
        ntt_ld <= ntt_str_d;
        if (ntt_str_d) begin
          ntt_str  <= 1'b1;
        end
        else if (ntt_str) begin
          ncnt_mul <= ncnt_mul + 1'b1;
          ntt_str  <= 1'b0;
        end
        else if (|ncnt_mul[LOG2NMUL-1:0] == 1'b0) begin
          ntt_str  <= 1'b1;
        end
        else begin
          ntt_str  <= 1'b0;
        end
      end
      else begin
        ntt_str        <= 0;
        ntt_b2b_ld_str <= 1'b0;
        if (ntt_ld_3d == 1'b1) begin
          ntt_ld   <= ~(&ncnt_mul[LOG2NMUL-1 :1]);
          ncnt_mul <= ncnt_mul + 1'b1;
        end
        else if (ntt_ld_2d == 1'b1) begin
          ntt_ld   <= 1'b0;
        end
        else if (ntt_ld_d == 1'b1) begin
          ntt_ld   <= ~(&ncnt_mul[LOG2NMUL-1 :1]);
        end
        else if (ntt_ld == 1'b1) begin
          ntt_ld   <= 1'b0;
        end
        else if ((|ncnt_mul[LOG2NMUL-1:0] == 1'b0) && ~(ntt_str_d | ntt_str_2d)) begin
          ntt_ld   <= 1'b1;
        end
        else begin
          ntt_ld  <= 1'b0;
        end
      end
    end
    else if (mulvalid | addvalid | subvalid) begin
      if ((ncnt_mul[LOG2NMUL] == 1'b1) | (ntt_b2b_ld_str == 1'b1)) begin
        ntt_b2b_ld_str <= 1'b1;
        addmul_ld  <= 0;
        if (addmul_ld_d) begin
          addmul_str <= 1'b1;
          ncnt_mul   <= ncnt_mul + 1'b1;
        end
        else if (addmul_str) begin
          addmul_str <= 1'b1;
          ncnt_mul   <= ncnt_mul + 1'b1;
        end
      end
      else begin
        addmul_str  <= 0;
        if ((|ncnt_mul[LOG2NMUL-1:0] == 1'b0) && ~(addmul_str_d)) begin
          addmul_ld <= 1'b1;
          ncnt_mul  <= ncnt_mul + 1'b1;
        end
        else if (addmul_ld_d == 1'b1) begin
          addmul_ld <= 1'b1;
          ncnt_mul  <= ncnt_mul + 1'b1;
        end
        else begin
          addmul_ld  <= 1'b0;
        end
      end
    end
    else  begin
      ntt_ld         <= 1'b0;
      ntt_str        <= 1'b0;
      ntt_b2b_ld_str <= 1'b0;
      ncnt_mul       <= {(LOG2NMUL+1){1'b0}};
    end
  end
end

assign mode = mulvalid ? 3'b001 : (nttvalid ? 3'b000 : (addvalid ? 3'b010 : (subvalid ? 3'b011 : 3'b100)));


endmodule
