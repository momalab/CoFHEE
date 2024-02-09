module CORTEXM0DS_wrap (
  // CLOCK AND RESETS ------------------
  input  wire        HCLK,              // Clock
  input  wire        HRESETn,           // Asynchronous reset

  // AHB-LITE MASTER PORT --------------
  output wire [31:0] HADDR,             // AHB transaction address
  output wire [ 2:0] HBURST,            // AHB burst: tied to single
  output wire        HMASTLOCK,         // AHB locked transfer (always zero)
  output wire [ 3:0] HPROT,             // AHB protection: priv; data or inst
  output wire [ 3:0] HSIZE,             // AHB size: byte, half-word or word
  output wire [ 1:0] HTRANS,            // AHB transfer: non-sequential only
  output wire [31:0] HWDATA,            // AHB write-data
  output wire        HWRITE,            // AHB write control
  input  wire [31:0] HRDATA,            // AHB read-data
  input  wire        HREADY,            // AHB stall signal
  input  wire        HRESP,             // AHB error response

  // MISCELLANEOUS ---------------------
  input  wire        NMI,               // Non-maskable interrupt input
  input  wire [15:0] IRQ,               // Interrupt request inputs
  output wire        TXEV,              // Event output (SEV executed)
  input  wire        RXEV,              // Event input
  output wire        LOCKUP,            // Core is locked-up
  output wire        SYSRESETREQ,       // System reset request

  // POWER MANAGEMENT ------------------
  output wire        SLEEPING,           // Core and NVIC sleeping
  input  wire [255:0] TKEY,
  input  wire         test_si,
  input  wire         test_se,
  output wire         test_so
);



wire [2:0] HSIZE_loc;

assign HSIZE = {1'b0, HSIZE_loc};

CORTEXM0DS  u_cortexm0_inst (
  .HCLK           (HCLK),            //input  wire         Clock
  .HRESETn        (HRESETn),         //input  wire         Asynchronous reset
  .HADDR          (HADDR),           //output wire [31:0]  AHB transaction address
  .HBURST         (HBURST),          //output wire [ 2:0]  AHB burst: tied to single
  .HMASTLOCK      (HMASTLOCK),       //output wire         AHB locked transfer (always zero)
  .HPROT          (HPROT),           //output wire [ 3:0]  AHB protection: priv; data or inst
  .HSIZE          (HSIZE_loc),           //output wire [ 2:0]  AHB size: byte, half-word or word
  .HTRANS         (HTRANS),          //output wire [ 1:0]  AHB transfer: non-sequential only
  .HWDATA         (HWDATA),          //output wire [31:0]  AHB write-data
  .HWRITE         (HWRITE),          //output wire         AHB write control
  .HRDATA         (HRDATA),          //input  wire [31:0]  AHB read-data
  .HREADY         (HREADY),          //input  wire         AHB stall signal
  .HRESP          (HRESP),           //input  wire         AHB error response
  .NMI            (NMI),             //input  wire         Non-maskable interrupt input
  .IRQ            (IRQ),             //input  wire [15:0]  Interrupt request inputs
  .TXEV           (TXEV),            //output wire         Event output (SEV executed)
  .RXEV           (RXEV),            //input  wire         Event input
  .LOCKUP         (LOCKUP),          //output wire         Core is locked-up
  .SYSRESETREQ    (SYSRESETREQ),     //output wire         System reset request
  .SLEEPING       (SLEEPING),         //output wire         Core and NVIC sleeping
  .TKEY           (TKEY)      //output wire         Core and NVIC sleeping
);

endmodule
