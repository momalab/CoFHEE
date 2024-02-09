module chip_core #(
  parameter NUM_PADS  = 26,
  parameter PAD_CTL_W = 9,
  parameter NBITS     = 128,
  parameter POLYDEG   = 4096,
  parameter NMUL      = 32,
  parameter NPLINE    = 4
  )(
  output wire [NUM_PADS-1  :3]  pad_in,
  input  wire [NUM_PADS-1  :0]  pad_out,
  output wire [PAD_CTL_W-1 :0]  pad_ctl[NUM_PADS-1   :3]

);


//----------------------------------------------
//localparameter,genvar and reg/wire delcaration
//----------------------------------------------

  localparam DWIDTH      = NBITS;

  localparam NUM_MASTERS = 10;
`ifdef FPGA_SYNTH
  localparam NUM_SLAVES  = 13;
`else
  localparam NUM_SLAVES  = 14;
`endif

  localparam CM0_M_ID    = 0;
  localparam UARTM_M_ID  = 1;
  localparam SPIM_M_ID   = 2;
  localparam MDMC_PORT0  = 3;  //Twiddle Factor
  localparam MDMC_PORT1  = 4;  //OPerand A
  localparam MDMC_PORT2  = 5;  //OPerand B
  localparam MDMC_PORT3  = 6;  //Result A
  localparam DMA_RD_ID   = 7;  
  localparam DMA_WR_ID   = 8;  
  localparam MDMC_PORT4  = 9;  //Result B

  localparam PRAM_S_ID        = 0;
  localparam SYSRAM_S_ID      = 1;
  localparam FHEMEM0_S_ID     = 2;
  localparam FHEMEM1_S_ID     = 3;
  localparam FHEMEM2_S_ID     = 4;
  localparam FHEMEM3_S_ID     = 5;
  localparam FHEMEM4_S_ID     = 6;
  localparam FHEMEM5_S_ID     = 7;
`ifdef FPGA_SYNTH
  localparam FHEMEM0_B_S_ID   = 8;
  localparam FHEMEM1_B_S_ID   = 9;
  localparam FHEMEM2_B_S_ID   = 10;
  localparam GPCFG_S_ID       = 11;
  localparam GPIO_S_ID        = 12;
`else
  localparam FHEMEM6_S_ID     = 8;
  localparam FHEMEM0_B_S_ID   = 9;
  localparam FHEMEM1_B_S_ID   = 10;
  localparam FHEMEM2_B_S_ID   = 11;
  localparam GPCFG_S_ID       = 12;
  localparam GPIO_S_ID        = 13;
`endif


`ifdef FPGA_SYNTH
  localparam NDPRAM = 2;
  localparam NSPRAM = 4;
`else
  localparam NDPRAM = 3;
  localparam NSPRAM = 4;
`endif

  localparam NRAM   = NDPRAM + NSPRAM;

  //localparam MULTPOOL_S_ID  = 11;

  localparam PRAM_BASE           = 32'h0000_0000;

  localparam SYSRAM_BASE         = 32'h2000_0000;
  localparam FHEMEM0_BASE        = 32'h2100_0000;
  localparam FHEMEM1_BASE        = 32'h2200_0000;
  localparam FHEMEM2_BASE        = 32'h2300_0000;
  localparam FHEMEM3_BASE        = 32'h2400_0000;
  localparam FHEMEM4_BASE        = 32'h2500_0000;
  localparam FHEMEM5_BASE        = 32'h2600_0000;
  localparam FHEMEM6_BASE        = 32'h2700_0000;
  localparam FHEMEM0_B_BASE      = 32'h3100_0000;
  localparam FHEMEM1_B_BASE      = 32'h3200_0000;
  localparam FHEMEM2_B_BASE      = 32'h3300_0000;

  localparam WDOG_BASE           = 32'h4000_0000;
  localparam GPT_BASE            = 32'h4100_0000;
  localparam GPCFG_BASE          = 32'h4200_0000;
  localparam GPIO_BASE           = 32'h4300_0000;
  localparam UARTM_BASE          = 32'h4400_0000;
  localparam UARTS_BASE          = 32'h4500_0000;
  localparam MULTPOOL_BASE       = 32'h4600_0000;

genvar i;

wire        ext_clk;
wire        pllmode;
wire        nporeset;

wire        nporeset_sync;

wire        pllmode_sync;

reg  [7:0]  base_addr_ramem;

wire [31:0] hwdata_m0;
wire [31:0] hwdata_uartm;
wire [31:0] hwdata_dma_wr;
wire [31:0] hwdata_spim;

wire [31:0] hrdata_pram;
wire [31:0] hrdata_gpcfg;
wire [31:0] hrdata_gpio;

wire [31:0] gpcfg_reg[75:0];

wire [31:0] pll_ctl;

wire [ 1:0]       htrans_m[NUM_MASTERS-1 :0];      // AHB transfer: non-sequential only
wire [31:0]       haddr_m[NUM_MASTERS-1 :0];       // AHB transaction address
wire [ 3:0]       hsize_m[NUM_MASTERS-1 :0];       // AHB size: byte, half-word or word
wire [DWIDTH-1:0] hwdata_m[NUM_MASTERS-1 :0];      // AHB write-data
wire              hwrite_m[NUM_MASTERS-1 :0];      // AHB write control
wire [DWIDTH-1:0] hrdata_m[NUM_MASTERS-1 :0];      // AHB read-data
wire              hready_m[NUM_MASTERS-1 :0];      // AHB stall signal
wire              hresp_m[NUM_MASTERS-1 :0];       // AHB error response
wire              hsel_s[NUM_SLAVES-1 :0];         // AHB transfer: non-sequential only
wire [31:0]       haddr_s[NUM_SLAVES-1 :0];        // AHB transaction address
wire [ 3:0]       hsize_s[NUM_SLAVES-1 :0];        // AHB size: byte, half-word or word
wire              hwrite_s[NUM_SLAVES-1 :0];       // AHB write control
wire [DWIDTH-1:0] hwdata_s[NUM_SLAVES-1 :0];       // AHB write-data
wire [DWIDTH-1:0] hrdata_s[NUM_SLAVES-1 :0];       // AHB read-data
wire              hready_s[NUM_SLAVES-1 :0];       // AHB stall signal
wire              hresp_s[NUM_SLAVES-1 :0];        // AHB error response

wire        gpio_irq;
wire [3:0]  gpio_out;
wire [3:0]  gpio_in;

wire [31:0] uarts_rx_data;

wire [NBITS-1:0]    modulus;
wire [NBITS-1:0]    invmodulus;
wire [2*NBITS-1:0]  baret_mdk;
wire [15     :0]    polysize;
//wire [2048:0]  y;


wire [31:0]         haddr_mpool_wr;
wire [ 3:0]         hsize_mpool_wr;
wire [ 1:0]         htrans_mpool_wr;
wire [3*DWIDTH-1:0] hwdata_mpool_wr;
wire                hwrite_mpool_wr;
wire                hready_mpool_wr;
wire                hresp_mpool_wr;


wire [31:0]         haddr_mpool_rd;
wire [ 3:0]         hsize_mpool_rd;
wire [ 1:0]         htrans_mpool_rd;
wire [3*DWIDTH-1:0] hwdata_mpool_rd;
wire                hwrite_mpool_rd;
wire [3*DWIDTH-1:0] hrdata_mpool_rd;
wire                hready_mpool_rd;
wire                hresp_mpool_rd;


wire [7 :0]       base_addr_a;
wire [7 :0]       base_addr_b;
wire [7 :0]       base_addr_ra;
wire [7 :0]       base_addr_rb;
wire [7 :0]       base_addr_t;
wire [7 :0]       base_addr_mpool;
wire [7 :0]       mdmc_throt_cnt_ntt;
wire [7 :0]       mdmc_throt_cnt_mul;
wire [7 :0]       mdmc_throt_cnt_add;

wire [2 :0]       opmode;

wire [255:0]      TKEY;

wire  test_mode;
wire  test_si;
wire  test_so;
wire  test_se;
wire  test_clk;
wire  test_rstn;

clk_rst_ctl u_clk_rst_ctl_inst (
  .nporeset           (nporeset),
  .pllmode            (pllmode),
  .cm0_sw_rstn        (cm0_sw_rstn),
  .wdtimer_irq        (wdtimer_irq),
  .ext_clk            (ext_clk),
  .sel_pll            (sel_pll),
  .pll_ctl            (pll_ctl),
  .nporeset_sync      (nporeset_sync),
  .pllmode_sync       (pllmode_sync),
  .nporeset_sync_wdt  (nporeset_sync_wdt),
  .clkout             (clkout),
  .hclk_cm0           (hclk_cm0),
  .cm0_rstn           (cm0_rstn),
  .hclk_bus           (hclk_bus),
  .hclk_mpool         (hclk_mpool),
  .hclk_mdmc          (hclk_mdmc),
  .hclk_fhemem        (hclk_fhemem),
  .pll_dbg_clk1       (pll_dbg_clk1),
  .pll_dbg_clk2       (pll_dbg_clk2),
  .rst_nSAR           (rst_nSAR),
  .rst_nld            (rst_nld),
  .rst_nos            (rst_nos),
  .test_rstn          (test_rstn),
  .test_clk           (test_clk),
  .test_en            (test_en)
   
);


//assign hwdata_m[CM0_M_ID]
assign hwdata_m[CM0_M_ID] = {{(DWIDTH-32){1'b0}}, hwdata_m0};

CORTEXM0DS_wrap u_cortexm0_wrap_inst (
  .HCLK           (hclk_cm0),                  //input  wire         Clock
  .HRESETn        (cm0_rstn),           //input  wire         Asynchronous reset
  .HADDR          (haddr_m[CM0_M_ID]),     //output wire [31:0]  AHB transaction address
  .HBURST         (),                      //output wire [ 2:0]  AHB burst: tied to single
  .HMASTLOCK      (),                      //output wire         AHB locked transfer (always zero)
  .HPROT          (),                      //output wire [ 3:0]  AHB protection: priv; data or inst
  .HSIZE          (hsize_m[CM0_M_ID]),     //output wire [ 2:0]  AHB size: byte, half-word or word
  .HTRANS         (htrans_m[CM0_M_ID]),    //output wire [ 1:0]  AHB transfer: non-sequential only
  .HWDATA         (hwdata_m0),             //output wire [31:0]  AHB write-data
  .HWRITE         (hwrite_m[CM0_M_ID]),    //output wire         AHB write control
  .HRDATA         (hrdata_m[CM0_M_ID][31:0]), //input  wire [31:0]  AHB read-data
  .HREADY         (hready_m[CM0_M_ID]),    //input  wire         AHB stall signal
  .HRESP          (hresp_m[CM0_M_ID]),     //input  wire         AHB error response
  .NMI            (wdtimer_nmi),           //input  wire         Non-maskable interrupt input
  .IRQ            ({gpcfg_reg[39][2:0], dma_done, sub_done,     add_done,
                    pwise_mul_done,     intt_done,    ntt_done,
                    fhe_host_irq,       uarts_rx_irq, uarts_tx_irq,
                    timerC_irq, timerB_irq, timerA_irq, gpio_irq}),//input  wire [15:0]  Interrupt request inputs
  .TXEV           (txev),                  //output wire         Event output (SEV executed)
  .RXEV           (gpcfg_reg[39][10]),     //input  wire         Event input                    TODO
  .LOCKUP         (lockup),                //output wire         Core is locked-up              TODO
  .SYSRESETREQ    (sysresetreq),           //output wire         System reset request           TODO
  .SLEEPING       (sleeping),              //output wire         Core and NVIC sleeping         TODO
  .TKEY           (TKEY),
  .test_se        (test_se & test_en),
  .test_si        (test_si),
  .test_so        (test_so)
);




mdmc #(
.DWIDTH   (DWIDTH),
.NMUL     (NMUL),
.NPLINE   (NPLINE),
.POLYDEG  (POLYDEG)) u_mdmc_inst
(
  .hclk                (hclk_mdmc),            //input  wire                
  .hresetn             (nporeset_sync),   //input  wire                
  .trig_ntt            (trig_ntt),        //input  wire                
  .trig_intt           (trig_intt),       //input  wire                
  .trig_mul            (trig_mul),        //input  wire                
  .trig_constmul       (trig_constmul),   //input  wire                
  .trig_add            (trig_add),        //input  wire                
  .trig_sub            (trig_sub),        //input  wire                
  .trig_sqr            (trig_sqr),        //input  wire                
  .trig_nmul           (trig_nmul),        //input  wire                
  .dp_en               (dp_en),        //input  wire                
  .ntt_done            (ntt_done),        //output reg                 
  .intt_done           (intt_done),       //output reg                 
  .pwise_mul_done      (pwise_mul_done),       //output reg                 
  .sqr_done            (sqr_done),       //output reg                 
  .nmul_done           (nmul_done),       //output reg                 
  .add_done            (add_done),       //output reg                 
  .sub_done            (sub_done), 
  .invmodulus          (invmodulus),
  .haddr_a             (haddr_m[MDMC_PORT1]),   //output reg  [31:0]           // AHB transaction address
  .hsize_a             (hsize_m[MDMC_PORT1]),   //output wire [ 2:0]           // AHB size: byte, half-word or word
  .htrans_a            (htrans_m[MDMC_PORT1]),  //output reg  [ 1:0]           // AHB transfer: non-sequential only
  .hwdata_a            (hwdata_m[MDMC_PORT1]),  //output reg  [DWIDTH-1:0]     // AHB write-data
  .hwrite_a            (hwrite_m[MDMC_PORT1]),  //output reg                   // AHB write control
  .hrdata_a            (hrdata_m[MDMC_PORT1]),  //input  wire [DWIDTH-1:0]     // AHB read-data
  .hready_a            (hready_m[MDMC_PORT1]),  //input  wire                  // AHB stall signal
  .hresp_a             (hresp_m[MDMC_PORT1]),   //input  wire                  // AHB error response
  .haddr_t             (haddr_m[MDMC_PORT0]),         //output reg  [31:0]           // AHB transaction address
  .hsize_t             (hsize_m[MDMC_PORT0]),         //output wire [ 2:0]           // AHB size: byte, half-word or word
  .htrans_t            (htrans_m[MDMC_PORT0]),        //output reg  [ 1:0]           // AHB transfer: non-sequential only
  .hwdata_t            (hwdata_m[MDMC_PORT0]),        //output reg  [DWIDTH-1:0]     // AHB write-data
  .hwrite_t            (hwrite_m[MDMC_PORT0]),        //output reg                   // AHB write control
  .hrdata_t            (hrdata_m[MDMC_PORT0]),        //input  wire [DWIDTH-1:0]     // AHB read-data
  .hready_t            (hready_m[MDMC_PORT0]),        //input  wire                  // AHB stall signal
  .hresp_t             (hresp_m[MDMC_PORT0]),         //input  wire                  // AHB error response
  .haddr_b             (haddr_m[MDMC_PORT2]),         //output reg  [31:0]           // AHB transaction address
  .hsize_b             (hsize_m[MDMC_PORT2]),         //output wire [ 2:0]           // AHB size: byte, half-word or word
  .htrans_b            (htrans_m[MDMC_PORT2]),        //output reg  [ 1:0]           // AHB transfer: non-sequential only
  .hwdata_b            (hwdata_m[MDMC_PORT2]),        //output reg  [DWIDTH-1:0]     // AHB write-data
  .hwrite_b            (hwrite_m[MDMC_PORT2]),        //output reg                   // AHB write control
  .hrdata_b            (hrdata_m[MDMC_PORT2]),        //input  wire [DWIDTH-1:0]     // AHB read-data
  .hready_b            (hready_m[MDMC_PORT2]),        //input  wire                  // AHB stall signal
  .hresp_b             (hresp_m[MDMC_PORT2]),         //input  wire                  // AHB error response
  .haddr_ra            (haddr_m[MDMC_PORT3]),         //output reg  [31:0]           // AHB transaction address
  .hsize_ra            (hsize_m[MDMC_PORT3]),         //output wire [ 2:0]           // AHB size: byte, half-word or word
  .htrans_ra           (htrans_m[MDMC_PORT3]),        //output reg  [ 1:0]           // AHB transfer: non-sequential only
  .hwdata_ra           (hwdata_m[MDMC_PORT3]),        //output reg  [DWIDTH-1:0]     // AHB write-data
  .hwrite_ra           (hwrite_m[MDMC_PORT3]),        //output reg                   // AHB write control
  .hrdata_ra           (hrdata_m[MDMC_PORT3]),        //input  wire [DWIDTH-1:0]     // AHB read-data
  .hready_ra           (hready_m[MDMC_PORT3]),        //input  wire                  // AHB stall signal
  .hresp_ra            (hresp_m[MDMC_PORT3]),         //input  wire                  // AHB error response
  .haddr_rb            (haddr_m[MDMC_PORT4]),         //output reg  [31:0]           // AHB transaction address
  .hsize_rb            (hsize_m[MDMC_PORT4]),         //output wire [ 2:0]           // AHB size: byte, half-word or word
  .htrans_rb           (htrans_m[MDMC_PORT4]),        //output reg  [ 1:0]           // AHB transfer: non-sequential only
  .hwdata_rb           (hwdata_m[MDMC_PORT4]),        //output reg  [DWIDTH-1:0]     // AHB write-data
  .hwrite_rb           (hwrite_m[MDMC_PORT4]),        //output reg                   // AHB write control
  .hrdata_rb           (hrdata_m[MDMC_PORT4]),        //input  wire [DWIDTH-1:0]     // AHB read-data
  .hready_rb           (hready_m[MDMC_PORT4]),        //input  wire                  // AHB stall signal
  .hresp_rb            (hresp_m[MDMC_PORT4]),         //input  wire                  // AHB error response
  .haddr_mpool_wr      (haddr_mpool_wr),     //output reg  [31:0]               // AHB transaction address
  .hsize_mpool_wr      (hsize_mpool_wr),     //output wire [ 2:0]               // AHB size: byte, half-word or word
  .htrans_mpool_wr     (htrans_mpool_wr),    //output reg  [ 1:0]               // AHB transfer: non-sequential only
  .hwdata_mpool_wr     (hwdata_mpool_wr),    //output reg  [3*DWIDTH-1:0]       // AHB write-data
  .hwrite_mpool_wr     (hwrite_mpool_wr),    //output reg                       // AHB write control
  .hready_mpool_wr     (hready_mpool_wr),    //input  wire                      // AHB stall signal
  .hresp_mpool_wr      (hresp_mpool_wr),     //input  wire                                                                         // AHB error response
  .haddr_mpool_rd      (haddr_mpool_rd),     //output reg  [31:0]               // AHB transaction address
  .hsize_mpool_rd      (hsize_mpool_rd),     //output wire [ 2:0]               // AHB size: byte, half-word or word
  .htrans_mpool_rd     (htrans_mpool_rd),    //output reg  [ 1:0]               // AHB transfer: non-sequential only
  .hwrite_mpool_rd     (hwrite_mpool_rd),    //output reg                       // AHB write control
  .hrdata_mpool_rd     (hrdata_mpool_rd),    //input  wire [3*DWIDTH-1:0]       // AHB read-data
  .hready_mpool_rd     (hready_mpool_rd),    //input  wire                      // AHB stall signal
  .hresp_mpool_rd      (hresp_mpool_rd),     //input  wire                                                                         // AHB error response
  .mpool_rd_fifo_empty (mpool_rd_fifo_empty),
  .base_addr_a         (base_addr_a),     //input  wire [7 :0]         
  .base_addr_b         (base_addr_b),     //input  wire [7 :0]         
  .base_addr_ra        (base_addr_ra),     //input  wire [7 :0]         
  .base_addr_t         (base_addr_t),     //input  wire [7 :0]         
  .base_addr_rb        (base_addr_rb), //input  wire [7 :0]         
  .throt_cnt_ntt       (mdmc_throt_cnt_ntt), //input  wire [7 :0]         
  .throt_cnt_mul       (mdmc_throt_cnt_mul), //input  wire [7 :0]         
  .throt_cnt_add       (mdmc_throt_cnt_add), //input  wire [7 :0]         
  .polysize            (polysize),
  .mode                (opmode),           // 00 : Buttefly, 01 : Multiplication, 10 : Add
  .base_addr_ramem     (base_addr_ramem),
  .mpool_done          (mul_done & ~gate_mul_done)
);


assign hwdata_m[UARTM_M_ID] = {{(DWIDTH-32){1'b0}}, hwdata_uartm};

uartm u_uartm_inst (
  .hclk        (hclk_bus),                 //input  wire          // Clock
  .hresetn     (nporeset_sync),        //input  wire          // Asynchronous reset
  .haddr       (haddr_m[UARTM_M_ID]),  //output reg  [31:0]   // AHB transaction address
  .hsize       (hsize_m[UARTM_M_ID]),  //output wire [ 2:0]   // AHB size: byte, half-word or word
  .htrans      (htrans_m[UARTM_M_ID]), //output reg  [ 1:0]   // AHB transfer: non-sequential only
  .hwdata      (hwdata_uartm),         //output reg  [31:0]   // AHB write-data
  .hwrite      (hwrite_m[UARTM_M_ID]), //output reg           // AHB write control
  .hrdata      (hrdata_m[UARTM_M_ID][31:0]), //input  wire [31:0]   // AHB read-data
  .hready      (hready_m[UARTM_M_ID]), //input  wire          // AHB stall signal
  .hresp       (hresp_m[UARTM_M_ID]),  //input  wire          // AHB error response
  .uartm_baud  (gpcfg_reg[17]),        //input  wire [31:0] 
  .uartm_ctl   (gpcfg_reg[18]),        //input  wire [31:0]   //1:0 : 00 => 8 bit, 01 => 16 bit, 10 => 32 bit, 11 => 8 bit
  .TX          (uartm_tx),             //output wire          // Event output (SEV executed)
  .RX          (uartm_rx)              //input  wire          // Event input
);


assign hwdata_m[SPIM_M_ID] = {{(DWIDTH-32){1'b0}}, hwdata_spim};

spim  u_spim_inst
(
  .hclk             (hclk_bus),                   // Clock
  .hresetn          (nporeset_sync),          // Asynchronous reset
  .haddr            (haddr_m[SPIM_M_ID]),     // AHB transaction address
  .hsize            (hsize_m[SPIM_M_ID]),     // AHB size: byte, half-word or word
  .htrans           (htrans_m[SPIM_M_ID]),    // AHB transfer: sequential/non-sequential
  .hburst           (),                       // AHB transfer: sequential/non-sequential
  .hwdata           (hwdata_spim),            // AHB write-data
  .hwrite           (hwrite_m[SPIM_M_ID]),    // AHB write control
  .hrdata           (hrdata_m[SPIM_M_ID][31:0]),    // AHB read-data
  .hready           (hready_m[SPIM_M_ID]),    // AHB stall signal
  .hresp            (hresp_m[SPIM_M_ID]),     // AHB error response
  .o_status         (),
  .i_spi_clk        (spi_clk),
  .o_spi_miso       (spi_miso),
  .i_spi_mosi       (spi_mosi),
  .i_spi_cs_n       (spi_cs_n)
);

dma #( 
  .DWIDTH      (DWIDTH)
  )
  u_dma_inst (
  .hclk          (hclk_bus),                   //input  wire          // Clock
  .hresetn       (nporeset_sync),              //input  wire          // Asynchronous reset
  .haddr_1       (haddr_m[DMA_RD_ID]),         //output reg  [31:0]     // AHB transaction address
  .hsize_1       (hsize_m[DMA_RD_ID]),         //output wire [ 3:0]     // AHB size: byte_2, half-word or word
  .htrans_1      (htrans_m[DMA_RD_ID]),        //output wire [ 1:0]     // AHB transfer: sequential/non-sequential
  .hwdata_1      (hwdata_m[DMA_RD_ID]),                           //output wire [31:0]     // AHB write-data
  .hwrite_1      (hwrite_m[DMA_RD_ID]),        //output wire            // AHB write control
  .hrdata_1      (hrdata_m[DMA_RD_ID]),        //input  wire [31:0]     // AHB read-data
  .hready_1      (hready_m[DMA_RD_ID]),        //input  wire            // AHB stall signal
  .hresp_1       (hresp_m[DMA_RD_ID]),         //input  wire            // AHB error response
  .haddr_2       (haddr_m[DMA_WR_ID]),         //output reg  [31:0]     // AHB transaction address
  .hsize_2       (hsize_m[DMA_WR_ID]),         //output wire [ 3:0]     // AHB size: byte_2, half-word or word
  .htrans_2      (htrans_m[DMA_WR_ID]),        //output wire [ 1:0]     // AHB transfer: sequential/non-sequential
  .hwdata_2      (hwdata_m[DMA_WR_ID]),        //output wire [31:0]     // AHB write-data
  .hwrite_2      (hwrite_m[DMA_WR_ID]),        //output wire            // AHB write control
  .hrdata_2      (hrdata_m[DMA_WR_ID]),        //input  wire [31:0]     // AHB read-data
  .hready_2      (hready_m[DMA_WR_ID]),        //input  wire            // AHB stall signal
  .hresp_2       (hresp_m[DMA_WR_ID]),         //input  wire            // AHB error response
  .o_status      (),                           //output wire [31:0] 
  .i_dma_req     (trig_dma),      //input              
  .o_dma_done    (dma_done),      //output             
  //.i_src_addr    ({base_addr_a, 24'b0}),      //input  [31:0]      
 //.i_dst_addr    ({base_addr_b, 24'b0}),      //input  [31:0]      
  //.i_burst_size  ({19'b0, base_addr_ra, 5'b0})     //input  [31:0]      
  .i_src_addr    (dma_cfifo_sel ? {base_addr_a, 24'b0} : gpcfg_reg[73]),     /*'h2100_0000*/
  .i_dst_addr    (dma_cfifo_sel ? {base_addr_b, 24'b0} : gpcfg_reg[74]),      /*'h2600_0000*/ 
  .i_poly_deg    (polysize),      //input              
  .i_src_rev     (gpcfg_reg[75][15]),      //input              
  .i_dst_rev     (gpcfg_reg[75][31]),      //input              
  .i_addr_inc    (gpcfg_reg[75][30:16]),
  .i_burst_size  (gpcfg_reg[75][14:0]) /*'d16       */
);

ahb_ic #(
  .DWIDTH      (DWIDTH),
  .NUM_SLAVES  (NUM_SLAVES),
  .NUM_MASTERS (NUM_MASTERS),
  .SLAVE_BASE  ( {GPIO_BASE,
                  GPCFG_BASE,
                  FHEMEM2_B_BASE,
                  FHEMEM1_B_BASE,
                  FHEMEM0_B_BASE,
`ifdef FPGA_SYNTH
`else
                  FHEMEM6_BASE,
`endif
                  FHEMEM5_BASE,
                  FHEMEM4_BASE,
                  FHEMEM3_BASE,
                  FHEMEM2_BASE,
                  FHEMEM1_BASE,
                  FHEMEM0_BASE,
                  SYSRAM_BASE,
                  PRAM_BASE})
  ) u_ahb_ic_inst (  
  .hclk      (hclk_bus),          //input  wire          Clock
  .hresetn   (nporeset_sync), //input  wire          Asynchronous reset
  .htrans_m  (htrans_m),      //input   wire [ 1:0]  AHB transfer: non-sequential only
  .haddr_m   (haddr_m),       //input   wire [31:0]  AHB transaction address
  .hsize_m   (hsize_m),       //input   wire [ 2:0]  AHB size: byte, half-word or word
  .hwdata_m  (hwdata_m),      //input   wire [31:0]  AHB write-data
  .hwrite_m  (hwrite_m),      //input   wire         AHB write control
  .hrdata_m  (hrdata_m),      //output  reg  [31:0]  AHB read-data
  .hready_m  (hready_m),      //output  reg          AHB stall signal
  .hresp_m   (hresp_m),       //output  reg          AHB error response
  .hsel_s    (hsel_s),        //output  reg  [ 1:0]  AHB transfer: non-sequential only
  .haddr_s   (haddr_s),       //output  reg  [31:0]  AHB transaction address
  .hsize_s   (hsize_s),       //output  reg  [ 2:0]  AHB size: byte, half-word or word
  .hwrite_s  (hwrite_s),      //output  reg          AHB write control
  .hwdata_s  (hwdata_s),      //output  reg  [31:0]  AHB write-data
  .hrdata_s  (hrdata_s),      //input   reg  [31:0]  AHB read-data
  .hready_s  (hready_s),      //input   reg          AHB stall signal
  .hresp_s   (hresp_s)        //input   reg          AHB error response
);


assign hrdata_s[PRAM_S_ID] = {{(DWIDTH-32){1'b0}}, hrdata_pram};

pram u_pram_inst (  
  .hclk               (hclk_bus),                           //input   wire         Clock
  .hresetn            (nporeset_sync),                  //input   wire         Asynchronous reset
  .hsel               (hsel_s[PRAM_S_ID]),              //input   wire         AHB transfer: non-sequential only
  .haddr              (haddr_s[PRAM_S_ID]),             //input   wire [31:0]  AHB transaction address
  .hsize              (hsize_s[PRAM_S_ID]),             //input   wire [ 2:0]  AHB size: byte, half-word or word
  .hwrite             (hwrite_s[PRAM_S_ID]),            //input   wire         AHB write control
  .hrdata             (hrdata_pram),            //output  reg  [31:0]  AHB read-data
  .hready             (hready_s[PRAM_S_ID]),            //output  reg          AHB stall signal
  .hresp              (hresp_s[PRAM_S_ID]),             //output  reg          AHB error response
  .sp_addr            (gpcfg_reg[19]),
  .reset_addr         (gpcfg_reg[20]),
  .nmi_addr           (gpcfg_reg[21]),
  .fault_addr         (gpcfg_reg[22]),
  .irq0_addr          (gpcfg_reg[23]),
  .irq1_addr          (gpcfg_reg[24]),
  .irq2_addr          (gpcfg_reg[25]),
  .irq3_addr          (gpcfg_reg[26]),
  .irq4_addr          (gpcfg_reg[52]),
  .irq5_addr          (gpcfg_reg[53]),
  .irq6_addr          (gpcfg_reg[54]),
  .irq7_addr          (gpcfg_reg[55]),
  .irq8_addr          (gpcfg_reg[56]),
  .irq9_addr          (gpcfg_reg[57]),
  .irq10_addr         (gpcfg_reg[58]),
  .irq11_addr         (gpcfg_reg[59]),
  .irq12_addr         (gpcfg_reg[60]),
  .irq13_addr         (gpcfg_reg[61]),
  .irq14_addr         (gpcfg_reg[62]),
  .irq15_addr         (gpcfg_reg[63])
);

assign hrdata_s[GPCFG_S_ID] = {{(DWIDTH-32){1'b0}}, hrdata_gpcfg};

gpcfg   #(.NBITS (NBITS)) u_gpcfg_inst (
  .hclk                     (hclk_bus),                     //input   wire         Clock
  .hresetn                  (nporeset_sync),            //input   wire         Asynchronous reset
  .hsel                     (hsel_s[GPCFG_S_ID]),       //input   wire [ 1:0]  AHB transfer: non-sequential only
  .haddr                    (haddr_s[GPCFG_S_ID]),      //input   wire [31:0]  AHB transaction address
  .hsize                    (hsize_s[GPCFG_S_ID]),      //input   wire [ 2:0]  AHB size: byte, half-word or word
  .hwdata                   (hwdata_s[GPCFG_S_ID][31:0]),     //input   wire [31:0]  AHB write-data
  .hwrite                   (hwrite_s[GPCFG_S_ID]),     //input   wire         AHB write control
  .hrdata                   (hrdata_gpcfg),     //output  reg  [31:0]  AHB read-data
  .hready                   (hready_s[GPCFG_S_ID]),     //output  wire         AHB stall signal
  .hresp                    (hresp_s[GPCFG_S_ID]),      //output  wire         AHB error response
  .pad03_ctl_reg            (gpcfg_reg[0]),     //output  reg  [31:0] 
  .pad04_ctl_reg            (gpcfg_reg[1]),     //output  reg  [31:0] 
  .pad05_ctl_reg            (gpcfg_reg[2]),     //output  reg  [31:0] 
  .pad06_ctl_reg            (gpcfg_reg[3]),     //output  reg  [31:0] 
  .pad07_ctl_reg            (gpcfg_reg[4]),     //output  reg  [31:0] 
  .pad08_ctl_reg            (gpcfg_reg[5]),     //output  reg  [31:0] 
  .pad09_ctl_reg            (gpcfg_reg[6]),     //output  reg  [31:0] 
  .pad10_ctl_reg            (gpcfg_reg[7]),     //output  reg  [31:0] 
  .pad11_ctl_reg            (gpcfg_reg[8]),     //output  reg  [31:0] 
  .pad12_ctl_reg            (gpcfg_reg[9]),     //output  reg  [31:0] 
  .pad13_ctl_reg            (gpcfg_reg[10]),    //output  reg  [31:0] 
  .pad14_ctl_reg            (gpcfg_reg[11]),    //output  reg  [31:0] 
  .pad15_ctl_reg            (gpcfg_reg[12]),    //output  reg  [31:0] 
  .pad16_ctl_reg            (gpcfg_reg[13]),    //output  reg  [31:0] 
  .pad17_ctl_reg            (gpcfg_reg[14]),    //output  reg  [31:0] 
  .pad18_ctl_reg            (gpcfg_reg[15]),    //output  reg  [31:0] 
  .pad19_ctl_reg            (gpcfg_reg[16]),    //output  reg  [31:0] 
  .uartm_baud_ctl_reg       (gpcfg_reg[17]),    //output  reg  [31:0] 
  .uartm_ctl_reg            (gpcfg_reg[18]),    //output  reg  [31:0] 
  .sp_addr                  (gpcfg_reg[19]),
  .reset_addr               (gpcfg_reg[20]),
  .nmi_addr                 (gpcfg_reg[21]),
  .fault_addr               (gpcfg_reg[22]),
  .irq0_addr                (gpcfg_reg[23]),
  .irq1_addr                (gpcfg_reg[24]),
  .irq2_addr                (gpcfg_reg[25]),
  .irq3_addr                (gpcfg_reg[26]),
  .timer_ctl                (gpcfg_reg[27]),
  .timerA_cfg               (gpcfg_reg[28]),
  .timerB_cfg               (gpcfg_reg[29]),
  .timerC_cfg               (gpcfg_reg[30]),
  .wdtimer_ctl              (gpcfg_reg[31]),
  .wdtimer_cfg              (gpcfg_reg[32]),
  .wdtimer_cfg2             (gpcfg_reg[33]),
  .uarts_baud_ctl_reg       (gpcfg_reg[34]),    //output  reg  [31:0] 
  .uarts_ctl_reg            (gpcfg_reg[35]),    //output  reg  [31:0] 
  .uarts_tx_data_reg        (gpcfg_reg[36]),    //output  reg  [31:0] 
  //.gpcfg37_reg            (gpcfg_reg[37]),    //output  reg  [31:0] 
  .uarts_rx_data            (uarts_rx_data),
  .uarts_tx_send_reg        (gpcfg_reg[38]),    //output  reg  [31:0] 
  .spare0_reg               (gpcfg_reg[39]),    //output  reg  [31:0] 
  .spare1_reg               (gpcfg_reg[40]),    //output  reg  [31:0] 
  .spare2_reg               (gpcfg_reg[41]),    //output  reg  [31:0] 
  .signature_reg            (gpcfg_reg[51]),    //output  reg  [31:0] 
  .irq4_addr                (gpcfg_reg[52]),
  .irq5_addr                (gpcfg_reg[53]),
  .irq6_addr                (gpcfg_reg[54]),
  .irq7_addr                (gpcfg_reg[55]),
  .irq8_addr                (gpcfg_reg[56]),
  .irq9_addr                (gpcfg_reg[57]),
  .irq10_addr               (gpcfg_reg[58]),
  .irq11_addr               (gpcfg_reg[59]),
  .irq12_addr               (gpcfg_reg[60]),
  .irq13_addr               (gpcfg_reg[61]),
  .irq14_addr               (gpcfg_reg[62]),
  .irq15_addr               (gpcfg_reg[63]),
  .hclk_div                 (gpcfg_reg[66]),
  .pad20_ctl_reg            (gpcfg_reg[67]),    //output  reg  [31:0] 
  .pad21_ctl_reg            (gpcfg_reg[68]),    //output  reg  [31:0] 
  .pad22_ctl_reg            (gpcfg_reg[69]),    //output  reg  [31:0] 
  .pad23_ctl_reg            (gpcfg_reg[70]),    //output  reg  [31:0] 
  .pad24_ctl_reg            (gpcfg_reg[71]),    //output  reg  [31:0] 
  .pad25_ctl_reg            (gpcfg_reg[72]),    //output  reg  [31:0] 
  .dma_src_addr             (gpcfg_reg[73]),
  .dma_dst_addr             (gpcfg_reg[74]),
  .dma_bst_size             (gpcfg_reg[75]),
  .modulus                  (modulus),
  .invmodulus               (invmodulus),
  .baret_mdk                (baret_mdk),
  .polysize                 (polysize),
  .gate_utx_cf              (gate_utx_cf),
  .trig_ntt                 (trig_ntt),
  .trig_intt                (trig_intt),
  .trig_mul                 (trig_mul), 
  .trig_constmul            (trig_constmul),   //input  wire                
  .trig_add                 (trig_add), 
  .trig_sub                 (trig_sub), 
  .trig_sqr                 (trig_sqr), 
  .trig_nmul                (trig_nmul), 
  .dp_en                    (dp_en),        //input  wire                
  .trig_dma                 (trig_dma),        //input  wire                
  .ntt_done                 (ntt_done), 
  .intt_done                (intt_done),
  .pwise_mul_done           (pwise_mul_done), 
  .sqr_done                 (sqr_done),       //output reg                 
  .nmul_done                (nmul_done),       //output reg                 
  .add_done                 (add_done), 
  .sub_done                 (sub_done), 
  .dma_done                 (dma_done),       //output reg                 
  .sel_pll                  (sel_pll), 
  .uarts_tx_ctl             (uarts_tx_ctl), 
  .gate_mul_done            (gate_mul_done), 
  .cm0_sw_rstn              (cm0_sw_rstn), 
  .test_en                  (test_en), 
  .fhe_host_irq             (fhe_host_irq),
  .fhe_busy                 (fhe_busy),
  .base_addr_a              (base_addr_a),     //output  wire [7 :0]         
  .base_addr_b              (base_addr_b),     //output  wire [7 :0]         
  .base_addr_ra             (base_addr_ra),     //output  wire [7 :0]         
  .base_addr_t              (base_addr_t),     //output  wire [7 :0]         
  .base_addr_rb             (base_addr_rb),  //output  wire [7 :0]         
  .mdmc_throt_cnt_ntt       (mdmc_throt_cnt_ntt), //input  wire [7 :0]         
  .mdmc_throt_cnt_mul       (mdmc_throt_cnt_mul), //input  wire [7 :0]         
  .mdmc_throt_cnt_add       (mdmc_throt_cnt_add), //input  wire [7 :0]         
  .pll_ctl                  (pll_ctl),
  .tkey                     (TKEY),
  .mdmc_data                (32'b0 | {sub_done, add_done, pwise_mul_done, intt_done, ntt_done, base_addr_ramem}),
  .mdmc_done                (ntt_done | intt_done | pwise_mul_done | add_done | sub_done),
  .dma_cfifo_sel            (dma_cfifo_sel)

);


//assign hrdata_s[SYSRAM_S_ID] = {{(DWIDTH-32){1'b0}}, hrdata_sram_wrap};

sram_wrap_cm0 #(
  .POLYDEG (4096),
  .DWIDTH  (DWIDTH))  u_sram_wrap_cm0_inst (  
  .hclk       (hclk_bus),                    // Clock              input  wire         
  .hresetn    (nporeset_sync),           // Asynchronous reset input  wire         
  .hsel       (hsel_s[SYSRAM_S_ID]),     // AHB transfer: non-sequential only input   wire [ 1:0] 
  .haddr      (haddr_s[SYSRAM_S_ID]),    // AHB transaction address  input   wire [31:0] 
  .hsize      (hsize_s[SYSRAM_S_ID]),    // AHB size: byte, half-word or word input   wire [ 2:0] 
  .hwdata     (hwdata_s[SYSRAM_S_ID]),   // AHB write-data input   wire [31:0] 
  .hwrite     (hwrite_s[SYSRAM_S_ID]),   // AHB write control  input   wire        
  .hrdata     (hrdata_s[SYSRAM_S_ID]),        // AHB read-data      output  reg  [31:0] 
  .hready     (hready_s[SYSRAM_S_ID]),   // AHB stall signal   output  reg         
  .hresp      (hresp_s[SYSRAM_S_ID]),    // AHB error response output  reg         
  .sram_ctl   (gpcfg_reg[39][31:15])
);

generate
  for (i =0; i < NDPRAM; i =i +1) begin : sram_dp_fhe_gen
    sram_wrap_dp #(
      .POLYDEG (POLYDEG),
      .DWIDTH  (DWIDTH))  u_sram_wrap_dp_fhe_inst (  
      .hclk       (hclk_fhemem),                 // Clock                             input  wire         
      .hresetn    (nporeset_sync),        // Asynchronous reset                input  wire         
      .hsel       (hsel_s[i+FHEMEM0_S_ID]), // AHB transfer: non-sequential only input   wire [ 1:0] 
      .haddr      (haddr_s[i+FHEMEM0_S_ID]),         // AHB transaction address           input   wire [31:0] 
      .hsize      (hsize_s[i+FHEMEM0_S_ID]),         // AHB size: byte, half-word or word input   wire [ 2:0] 
      .hwdata     (hwdata_s[i+FHEMEM0_S_ID][DWIDTH-1:0]), // AHB write-data                    input   wire [31:0] 
      .hwrite     (hwrite_s[i+FHEMEM0_S_ID]),        // AHB write control                 input   wire        
      .hrdata     (hrdata_s[i+FHEMEM0_S_ID]),        // AHB read-data                     output  reg  [31:0] 
      .hready     (hready_s[i+FHEMEM0_S_ID]),        // AHB stall signal                  output  reg         
      .hresp      (hresp_s[i+FHEMEM0_S_ID]),         // AHB error response                output  reg         
      .hsel_b     (hsel_s[i+FHEMEM0_B_S_ID]),    // AHB transfer: non-sequential only
      .haddr_b    (haddr_s[i+FHEMEM0_B_S_ID]),   // AHB transaction address
      .hsize_b    (hsize_s[i+FHEMEM0_B_S_ID]),         // AHB size: byte, half-word or word input   wire [ 2:0] 
      .hwdata_b   (hwdata_s[i+FHEMEM0_B_S_ID]),  // AHB write-data
      .hwrite_b   (hwrite_s[i+FHEMEM0_B_S_ID]),        // AHB write control                 input   wire        
      .hrdata_b   (hrdata_s[i+FHEMEM0_B_S_ID]),   // AHB read-data
      .hready_b   (hready_s[i+FHEMEM0_B_S_ID]),  // AHB stall signal
      .hresp_b    (hresp_s[i+FHEMEM0_B_S_ID]),   // AHB error response
      .sram_ctl   (gpcfg_reg[39][31:15])
    );
  end
endgenerate

generate
  for (i =NDPRAM; i < NRAM; i =i +1) begin : sram_sp_fhe_gen
    sram_wrap #(
      .POLYDEG (POLYDEG),
      .DWIDTH  (DWIDTH))  u_sram_wrap_fhe_inst (  
      .hclk       (hclk_fhemem),    // Clock                             input  wire         
      .hresetn    (nporeset_sync),  // Asynchronous reset                input  wire         
      .hsel       (hsel_s[i+2]),    // AHB transfer: non-sequential only input   wire [ 1:0] 
      .haddr      (haddr_s[i+2]),   // AHB transaction address           input   wire [31:0] 
      .hsize      (hsize_s[i+2]),   // AHB size: byte, half-word or word input   wire [ 2:0] 
      .hwdata     (hwdata_s[i+2][DWIDTH-1:0]), // AHB write-data                    input   wire [31:0] 
      .hwrite     (hwrite_s[i+2]),  // AHB write control                 input   wire        
      .hrdata     (hrdata_s[i+2]),  // AHB read-data                     output  reg  [31:0] 
      .hready     (hready_s[i+2]),  // AHB stall signal                  output  reg         
      .hresp      (hresp_s[i+2]),   // AHB error response                output  reg         
      .sram_ctl   (gpcfg_reg[39][31:15])
    );
  end
endgenerate

assign hrdata_s[GPIO_S_ID] = {{(DWIDTH-32){1'b0}}, hrdata_gpio};

gpio u_gpio_inst (
	.hclk        (hclk_bus),                       //input
	.hresetn     (nporeset_sync),              //input
	.hsel        (hsel_s[GPIO_S_ID]),          //input
	.haddr       (haddr_s[GPIO_S_ID]),         //input
	.hwdata      (hwdata_s[GPIO_S_ID][31:0]),  //input
	.hwrite      (hwrite_s[GPIO_S_ID]),        //input
	.hrdata      (hrdata_gpio),                //output
	.hready      (hready_s[GPIO_S_ID]),        //output
	.hresp       (hresp_s[GPIO_S_ID]),         //output
	.intc        (gpio_irq),                   //output
	.gpio_out    (gpio_out),                   //output
	.gpio_in     (gpio_in )                    //input
	);

multpool #(
  .NBITS (NBITS),
  .PBITS (2),
  .NMUL  (NMUL)) u_multpool_inst (  
  .hclk        (hclk_mpool),
  .hresetn     (nporeset_sync),
  .hsel_rd     (htrans_mpool_rd[1]),
  .haddr_rd    (haddr_mpool_rd),
  .hsize_rd    (hsize_mpool_rd),
  .hwrite_rd   (hwrite_mpool_rd),
  .hrdata_rd   (hrdata_mpool_rd),
  .hready_rd   (hready_mpool_rd),
  .hresp_rd    (hresp_mpool_rd),
  .fifo_empty  (mpool_rd_fifo_empty),
  .hsel_wr     (htrans_mpool_wr[1]),
  .haddr_wr    (haddr_mpool_wr),
  .hsize_wr    (hsize_mpool_wr),
  .hwdata_wr   (hwdata_mpool_wr),
  .hwrite_wr   (hwrite_mpool_wr),
  .hready_wr   (hready_mpool_wr),
  .hresp_wr    (hresp_mpool_wr),
  .modulus     (modulus),
  .baret_mdk   (baret_mdk),
  .invmodulus  (invmodulus),
  .mode        (opmode),              // 00 : Buttefly, 01 : Multiplication, 10 : Add
  .mul_done    (mul_done)
);


timer u_timer_inst (
  .hclk          (hclk_bus),
  .hresetn       (nporeset_sync),
  .wdt_rstn      (nporeset_sync_wdt),
  .timerA_cfg    (gpcfg_reg[28]),
  .timerB_cfg    (gpcfg_reg[29]),
  .timerC_cfg    (gpcfg_reg[30]),
  .wdtimer_cfg   (gpcfg_reg[32]),
  .wdtimer_cfg2  (gpcfg_reg[33]),
  .timerA_en     (gpcfg_reg[27][0]),
  .timerB_en     (gpcfg_reg[27][8]),
  .timerC_en     (gpcfg_reg[27][16]),
  .wdtimer_en    (gpcfg_reg[31][0]),
  .timerA_rst    (gpcfg_reg[27][1]),
  .timerB_rst    (gpcfg_reg[27][9]),
  .timerC_rst    (gpcfg_reg[27][17]),
  .wdtimer_rst   (gpcfg_reg[31][1]),
  .pwm_val_tim0  (gpcfg_reg[40]),
  .pwm_val_tim1  (gpcfg_reg[41]),
  .timerA_irq    (timerA_irq),
  .timerB_irq    (timerB_irq),
  .timerC_irq    (timerC_irq),
  .wdtimer_irq   (wdtimer_irq),
  .wdtimer_nmi   (wdtimer_nmi),
  .pwm_out       (pwm_out)
);



uarts u_uarts_inst (
  .hclk             (hclk_bus),
  .hresetn          (nporeset_sync),
  .rx_data          (uarts_rx_data),
  .rx_irq           (uarts_rx_irq),
  .tx_data          (uarts_tx_ctl ? gpcfg_reg[36]    : (32'b0 | {dma_done, nmul_done, sqr_done, sub_done, add_done, pwise_mul_done, intt_done, ntt_done, base_addr_ramem})),
  .tx_send          (uarts_tx_ctl ? gpcfg_reg[38][0] : ~gate_utx_cf & (ntt_done | intt_done | pwise_mul_done | add_done | sub_done | dma_done | nmul_done | sqr_done)),
  .tx_irq           (uarts_tx_irq),
  .uarts_baud       (gpcfg_reg[34]),
  .uarts_ctl        (gpcfg_reg[35]),
  .TX               (uarts_tx),
  .RX               (uarts_rx)

);



//------------------------------
//Pad to functionality mapping
//------------------------------
//pad0   nPORESET
//pad1   pllmode
//pad2   hclk
//pad3   UARTM_TX
//pad4   UARTM_RX
//pad5   UARTS_TX
//pad6   UARTS_RX
//pad7   GPIO0
//pad8   GPIO1
//pad9   HOST_IRQ
//pad10  GPIO3    
//------------------------------
    //pad_in[*]
    chiplib_mux3 u_uartm_tx_pad_in_mux_inst (.a (uartm_tx),     .b (gpcfg_reg[0][24]),  .c (pwm_out),                       .s ({gpcfg_reg[0][17],  gpcfg_reg[0][16]}),  .y (pad_in[3]));  //UARTM_TX pad
    chiplib_mux3 u_uartm_rx_pad_in_mux_inst (.a (1'b0),         .b (gpcfg_reg[1][24]),  .c (1'b0),                          .s ({gpcfg_reg[1][17],  gpcfg_reg[1][16]}),  .y (pad_in[4]));  //UARTM_RX pad
    chiplib_mux3 u_uarts_tx_pad_in_mux_inst (.a (uarts_tx),     .b (gpcfg_reg[2][24]),  .c (pwm_out),                       .s ({gpcfg_reg[2][17],  gpcfg_reg[2][16]}),  .y (pad_in[5]));  //UARTS_TX pad
    chiplib_mux3 u_uarts_rx_pad_in_mux_inst (.a (uarts_tx),     .b (gpcfg_reg[3][24]),  .c (1'b0),                          .s ({gpcfg_reg[3][17],  gpcfg_reg[3][16]}),  .y (pad_in[6]));  //UARTS_RX pad
    chiplib_mux4 u_gpio0_pad_in_mux_inst    (.a (gpio_out[0]),  .b (gpcfg_reg[4][24]),  .c (pwm_out),       .d (sub_done),  .s ({gpcfg_reg[4][17],  gpcfg_reg[4][16]}),  .y (pad_in[7]));  //GPIO0    pad
    chiplib_mux4 u_gpio1_pad_in_mux_inst    (.a (gpio_out[1]),  .b (gpcfg_reg[5][24]),  .c (fhe_host_irq),  .d (uarts_tx),  .s ({gpcfg_reg[5][17],  gpcfg_reg[5][16]}),  .y (pad_in[8]));  //GPIO1    pad
    chiplib_mux4 u_gpio2_pad_in_mux_inst    (.a (gpio_out[2]),  .b (gpcfg_reg[6][24]),  .c (fhe_host_irq),  .d (1'b0),      .s ({gpcfg_reg[6][17],  gpcfg_reg[6][16]}),  .y (pad_in[9]));  //GPIO2    pad
    chiplib_mux4 u_gpio3_pad_in_mux_inst    (.a (gpio_out[3]),  .b (gpcfg_reg[7][24]),  .c (clkdiv_clk),    .d (trig_add),  .s ({gpcfg_reg[7][17],  gpcfg_reg[7][16]}),  .y (pad_in[10])); //GPIO3    pad
    chiplib_mux4 u_misc1_pad_in_mux_inst    (.a (spi_miso),     .b (gpcfg_reg[8][24]),  .c (fhe_busy),      .d (add_done),  .s ({gpcfg_reg[8][17],  gpcfg_reg[8][16]}),  .y (pad_in[11])); //GPIO3    pad
    chiplib_mux4 u_misc2_pad_in_mux_inst    (.a (ntt_done),     .b (gpcfg_reg[9][24]),  .c (fhe_busy),      .d (trig_ntt),  .s ({gpcfg_reg[9][17],  gpcfg_reg[9][16]}),  .y (pad_in[12])); //GPIO3    pad
    chiplib_mux4 u_misc3_pad_in_mux_inst    (.a (intt_done),    .b (gpcfg_reg[10][24]), .c (~fhe_busy),     .d (trig_mul),  .s ({gpcfg_reg[10][17], gpcfg_reg[10][16]}), .y (pad_in[13])); //GPIO3    pad
    chiplib_mux4 u_misc4_pad_in_mux_inst    (.a (mul_done),     .b (gpcfg_reg[11][24]), .c (~fhe_busy),     .d (trig_intt), .s ({gpcfg_reg[11][17], gpcfg_reg[11][16]}), .y (pad_in[14])); //GPIO3    pad

    assign pad_ctl[3][1:0]   = (gpcfg_reg[0][20]  == 1'b1) ? gpcfg_reg[0][1:0]  : ((gpcfg_reg[0][17:16]  == 2'b01) ? 2'b10 : ((gpcfg_reg[0][17:16]  == 2'b10) ? 2'b10 : 2'b10));
    assign pad_ctl[4][1:0]   = (gpcfg_reg[1][20]  == 1'b1) ? gpcfg_reg[1][1:0]  : ((gpcfg_reg[1][17:16]  == 2'b01) ? 2'b10 : ((gpcfg_reg[1][17:16]  == 2'b10) ? 2'b11 : 2'b11));
    assign pad_ctl[5][1:0]   = (gpcfg_reg[2][20]  == 1'b1) ? gpcfg_reg[2][1:0]  : ((gpcfg_reg[2][17:16]  == 2'b01) ? 2'b10 : ((gpcfg_reg[2][17:16]  == 2'b10) ? 2'b10 : 2'b11));
    assign pad_ctl[6][1:0]   = (gpcfg_reg[3][20]  == 1'b1) ? gpcfg_reg[3][1:0]  : ((gpcfg_reg[3][17:16]  == 2'b01) ? 2'b10 : ((gpcfg_reg[3][17:16]  == 2'b10) ? 2'b11 : 2'b11));
    assign pad_ctl[7][1:0]   = (gpcfg_reg[4][20]  == 1'b1) ? gpcfg_reg[4][1:0]  : ((gpcfg_reg[4][17:16]  == 2'b01) ? 2'b10 : ((gpcfg_reg[4][17:16]  == 2'b10) ? 2'b10 : ((gpcfg_reg[4][17:16]  == 2'b11) ? 2'b10 : 2'b11)));
    assign pad_ctl[8][1:0]   = (gpcfg_reg[5][20]  == 1'b1) ? gpcfg_reg[5][1:0]  : ((gpcfg_reg[5][17:16]  == 2'b01) ? 2'b10 : ((gpcfg_reg[5][17:16]  == 2'b10) ? 2'b10 : ((gpcfg_reg[5][17:16]  == 2'b11) ? 2'b10 : 2'b11)));
    assign pad_ctl[9][1:0]   = (gpcfg_reg[6][20]  == 1'b1) ? gpcfg_reg[6][1:0]  : ((gpcfg_reg[6][17:16]  == 2'b01) ? 2'b10 : ((gpcfg_reg[6][17:16]  == 2'b10) ? 2'b10 : ((gpcfg_reg[6][17:16]  == 2'b11) ? 2'b10 : 2'b11)));
    assign pad_ctl[10][1:0]  = (gpcfg_reg[7][20]  == 1'b1) ? gpcfg_reg[7][1:0]  : ((gpcfg_reg[7][17:16]  == 2'b01) ? 2'b10 : ((gpcfg_reg[7][17:16]  == 2'b10) ? 2'b10 : ((gpcfg_reg[7][17:16]  == 2'b11) ? 2'b10 : 2'b11)));
    assign pad_ctl[11][1:0]  = (gpcfg_reg[8][20]  == 1'b1) ? gpcfg_reg[8][1:0]  : ((gpcfg_reg[8][17:16]  == 2'b01) ? 2'b10 : ((gpcfg_reg[8][17:16]  == 2'b10) ? 2'b10 : ((gpcfg_reg[8][17:16]  == 2'b11) ? 2'b10 : 2'b11)));
    assign pad_ctl[12][1:0]  = (gpcfg_reg[9][20]  == 1'b1) ? gpcfg_reg[9][1:0]  : ((gpcfg_reg[9][17:16]  == 2'b01) ? 2'b10 : ((gpcfg_reg[9][17:16]  == 2'b10) ? 2'b10 : ((gpcfg_reg[9][17:16]  == 2'b11) ? 2'b10 : 2'b11)));
    assign pad_ctl[13][1:0]  = (gpcfg_reg[10][20] == 1'b1) ? gpcfg_reg[10][1:0] : ((gpcfg_reg[10][17:16] == 2'b01) ? 2'b10 : ((gpcfg_reg[10][17:16] == 2'b10) ? 2'b10 : ((gpcfg_reg[10][17:16] == 2'b11) ? 2'b10 : 2'b11)));
    assign pad_ctl[14][1:0]  = (gpcfg_reg[11][20] == 1'b1) ? gpcfg_reg[11][1:0] : ((gpcfg_reg[11][17:16] == 2'b01) ? 2'b10 : ((gpcfg_reg[11][17:16] == 2'b10) ? 2'b10 : ((gpcfg_reg[11][17:16] == 2'b11) ? 2'b10 : 2'b11)));
    assign pad_ctl[15][1:0]  = (gpcfg_reg[12][20] == 1'b1) ? gpcfg_reg[12][1:0] : ((gpcfg_reg[12][17:16] == 2'b01) ? 2'b10 : ((gpcfg_reg[12][17:16] == 2'b10) ? 2'b10 : ((gpcfg_reg[12][17:16] == 2'b11) ? 2'b10 : 2'b11)));
    assign pad_ctl[16][1:0]  = (gpcfg_reg[13][20] == 1'b1) ? gpcfg_reg[13][1:0] : ((gpcfg_reg[13][17:16] == 2'b01) ? 2'b10 : ((gpcfg_reg[13][17:16] == 2'b10) ? 2'b10 : ((gpcfg_reg[13][17:16] == 2'b11) ? 2'b10 : 2'b11)));
    assign pad_ctl[17][1:0]  = (gpcfg_reg[14][20] == 1'b1) ? gpcfg_reg[14][1:0] : ((gpcfg_reg[14][17:16] == 2'b01) ? 2'b10 : ((gpcfg_reg[14][17:16] == 2'b10) ? 2'b10 : ((gpcfg_reg[14][17:16] == 2'b11) ? 2'b10 : 2'b11)));
    assign pad_ctl[18][1:0]  = (gpcfg_reg[15][20] == 1'b1) ? gpcfg_reg[15][1:0] : ((gpcfg_reg[15][17:16] == 2'b01) ? 2'b10 : ((gpcfg_reg[15][17:16] == 2'b10) ? 2'b10 : ((gpcfg_reg[15][17:16] == 2'b11) ? 2'b10 : 2'b10)));
    assign pad_ctl[19][1]    = (gpcfg_reg[16][20] == 1'b1) ? gpcfg_reg[16][1]   : ((gpcfg_reg[16][17:16] == 2'b01) ? 1'b1  : ((gpcfg_reg[16][17:16] == 2'b10) ? 1'b1  : ((gpcfg_reg[16][17:16] == 2'b11) ? 1'b1  : 1'b1)));
    assign pad_ctl[20][1]    = (gpcfg_reg[17][20] == 1'b1) ? gpcfg_reg[17][1]   : ((gpcfg_reg[17][17:16] == 2'b01) ? 1'b1  : ((gpcfg_reg[17][17:16] == 2'b10) ? 1'b1  : ((gpcfg_reg[17][17:16] == 2'b11) ? 1'b1  : 1'b1)));

    assign pad_ctl[19][0]    = 1'b0;
    assign pad_ctl[20][0]    = 1'b0;

    assign pad_ctl[21][1:0]  = (gpcfg_reg[67][20] == 1'b1) ? gpcfg_reg[67][1:0] : ((gpcfg_reg[67][17:16] == 2'b01) ? 2'b10 : ((gpcfg_reg[67][17:16] == 2'b10) ? 2'b10 : ((gpcfg_reg[67][17:16] == 2'b11) ? 2'b10 : 2'b11)));
    assign pad_ctl[22][1:0]  = (gpcfg_reg[68][20] == 1'b1) ? gpcfg_reg[68][1:0] : ((gpcfg_reg[68][17:16] == 2'b01) ? 2'b10 : ((gpcfg_reg[68][17:16] == 2'b10) ? 2'b10 : ((gpcfg_reg[68][17:16] == 2'b11) ? 2'b10 : 2'b11)));
    assign pad_ctl[23][1:0]  = (gpcfg_reg[69][20] == 1'b1) ? gpcfg_reg[69][1:0] : ((gpcfg_reg[69][17:16] == 2'b01) ? 2'b10 : ((gpcfg_reg[69][17:16] == 2'b10) ? 2'b10 : ((gpcfg_reg[69][17:16] == 2'b11) ? 2'b10 : 2'b11)));
    assign pad_ctl[24][1:0]  = (gpcfg_reg[70][20] == 1'b1) ? gpcfg_reg[70][1:0] : ((gpcfg_reg[70][17:16] == 2'b01) ? 2'b10 : ((gpcfg_reg[70][17:16] == 2'b10) ? 2'b10 : ((gpcfg_reg[70][17:16] == 2'b11) ? 2'b10 : 2'b11)));
    assign pad_ctl[25][1:0]  = (gpcfg_reg[71][20] == 1'b1) ? gpcfg_reg[71][1:0] : ((gpcfg_reg[71][17:16] == 2'b01) ? 2'b10 : ((gpcfg_reg[71][17:16] == 2'b10) ? 2'b10 : ((gpcfg_reg[71][17:16] == 2'b11) ? 2'b10 : 2'b11)));

generate
  for (i=3; i<NUM_PADS-6; i=i+1) begin
    assign pad_ctl[i][PAD_CTL_W-1:2] = gpcfg_reg[i-3][PAD_CTL_W-1:2];
  end
endgenerate

generate
  for (i=NUM_PADS-5; i<NUM_PADS; i=i+1) begin
    assign pad_ctl[i][PAD_CTL_W-1:2] = gpcfg_reg[67+i-(NUM_PADS-5)][PAD_CTL_W-1:2];
  end
endgenerate




    assign nporeset    = pad_out[0]; 
    assign pllmode     = pad_out[1]; 

    `ifdef FPGA_SYNTH
       clk_div u_clk_div4_inst ( 
         .CLK_IN1(pad_out[2]),
         .CLK_OUT1(ext_clk)
       );
    `else
      assign ext_clk        = pad_out[2]; 
    `endif

    chiplib_mux3 u_uartm_rx_mux_inst (.a (pad_out[4]), .b (1'b1), .c (pad_out[5]),                   .s ({gpcfg_reg[1][17], gpcfg_reg[1][16]}), .y(uartm_rx));  //UARTM_RX pad
    chiplib_mux4 u_uarts_rx_mux_inst (.a (pad_out[6]), .b (1'b1), .c (pad_out[3]), .d (pad_out[5]),  .s ({gpcfg_reg[3][17], gpcfg_reg[3][16]}), .y(uarts_rx));  //UARTS_RX pad

    assign gpio_in[0]  = pad_out[7];      //GPIO0    pad
    assign gpio_in[1]  = pad_out[8];      //GPIO1    pad
    assign gpio_in[2]  = pad_out[9];      //GPIO2    pad
    assign gpio_in[3]  = pad_out[10];     //GPIO3    pad

    assign spi_clk     = pad_out[15];
    assign spi_cs_n    = pad_out[16];
    assign spi_mosi    = pad_out[17];

    assign test_rstn   = pad_out[22];
    assign test_clk    = pad_out[23];
    assign test_se     = pad_out[24];
    assign test_si     = pad_out[25];

    assign rst_nSAR   = pad_out[22];
    assign rst_nld    = pad_out[23];
    assign rst_nos    = pad_out[25];


 assign pad_in[15] = 1'b1;
 assign pad_in[16] = 1'b1;
 assign pad_in[17] = 1'b1;
 assign pad_in[18] = spi_miso;
 assign pad_in[19] = pllmode_sync;
 assign pad_in[20] = nporeset_sync;
 assign pad_in[21] = test_so;


`ifdef FPGA_SYNTH
   assign hclk_buf = clkout;
`else
  BUF_X4B_A9TH u_DONT_TOUCH_clk_buf_hclk_inst (.A (clkout), .Y(hclk_buf));

  chiplib_mux3 u_dbg_clk_mux_inst ( 
    .a   (hclk_buf),          //input        
    .b   (pll_dbg_clk1),      //input        
    .c   (pll_dbg_clk2),      //input        
    .s   (gpcfg_reg[66][17:16]), //input  [1:0] 
    .y   (dbg_clk_out)        //output       
  );
  
  clkdiv u_clkdiv_clk_inst (.clk (dbg_clk_out), .rst_n (nporeset_sync), .div(gpcfg_reg[66][15:0]), .clkdiv(clkdiv_clk));
`endif



endmodule
