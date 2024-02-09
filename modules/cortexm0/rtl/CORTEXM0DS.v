//------------------------------------------------------------------------------
// The confidential and proprietary information contained in this file may
// only be used by a person authorised under and to the extent permitted
// by a subsisting licensing agreement from ARM Limited.
//
//            (C) COPYRIGHT 2010 ARM Limited.
//                ALL RIGHTS RESERVED
//
// This entire notice must be reproduced on all copies of this file
// and copies of this file may only be made by a person if such person is
// permitted to do so under the terms of a subsisting license agreement
// from ARM Limited.
//
//      SVN Information
//
//      Checked In          : 2010-08-03 19:08:25 +0100 (Tue, 03 Aug 2010)
//
//      Revision            : 144972
//
//      Release Information : AT510-MN-80001-r0p0-00rel0
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Cortex-M0 DesignStart processor macro cell level
//------------------------------------------------------------------------------

module CORTEXM0DS (
  // CLOCK AND RESETS ------------------
  input  wire        HCLK,              // Clock
  input  wire        HRESETn,           // Asynchronous reset

  // AHB-LITE MASTER PORT --------------
  output wire [31:0] HADDR,             // AHB transaction address
  output wire [ 2:0] HBURST,            // AHB burst: tied to single
  output wire        HMASTLOCK,         // AHB locked transfer (always zero)
  output wire [ 3:0] HPROT,             // AHB protection: priv; data or inst
  output wire [ 2:0] HSIZE,             // AHB size: byte, half-word or word
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
  input  wire [255:0] TKEY
);


endmodule
