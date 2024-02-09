/**********************************************************************************
    This module is part of the project CoPHEE.
    CoPHEE: A co-processor for partially homomorphic encrypted encryption
    Copyright (C) 2019  Michail Maniatakos
    New York University Abu Dhabi, wp.nyu.edu/momalab/

    If find any of our work useful, please cite our publication:
      M. Nabeel, M. Ashraf, E. Chielle, N.G. Tsoutsos, and M. Maniatakos.
      "CoPHEE: Co-processor for Partially Homomorphic Encrypted Execution". 
      In: IEEE Hardware-Oriented Security and Trust (HOST). 

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
**********************************************************************************/


/**********************************************************************************
    This module is part of the project CoPHEE.
    CoPHEE: A co-processor for partially homomorphic encrypted encryption
    Copyright (C) 2019  Michail Maniatakos
    New York University Abu Dhabi, wp.nyu.edu/momalab/

    If find any of our work useful, please cite our publication:
      M. Nabeel, M. Ashraf, E. Chielle, N.G. Tsoutsos, and M. Maniatakos.
      "CoPHEE: Co-processor for Partially Homomorphic Encrypted Execution". 
      In: IEEE Hardware-Oriented Security and Trust (HOST). 

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
**********************************************************************************/


// -----------------------------------------------------------------------------
// Copyright (C) 2007-2011 Aragio Solutions. All rights reserved.
// -----------------------------------------------------------------------------
// File         : rgo_csm65_25v33_50.v
// Revision     : 2.0
// Dependencies : none
// Description  : Verilog model for the following I/O pad libraries:
//                         RGO_GF55_25V33_LPE_50C
//                         RGO_CSM65_25V33_G_50C
//                         RGO_CSM65_25V33_LP_50C
//                         RGO_CSM65_25V33_LPE_50C
//
// History      :
//                Revision 2.0 : I.N. - 2011-05-19
//                  - Fault-tolerant pad moved to a standalone library
//
//                Revision 1.9 : I.N. - 25-Jun-2009
//                  - Added warning for unconnected signals
//
//                Revision 1.8 : J.P. - 09-Jun-2009
//                  - Improved POS modeling and added comment regarding its use
//
//                Revision 1.7 : I.N. - 09-Dec-2008
//                  - Oscillator cell moved to a standalone library
//
//                Revision 1.6 : I.N. - 02-Apr-2008
//                  - PCI cell moved to a standalone library
//                  - oscillator XI->XO and EN->XO timing arcs added
//                  - EN dependency corrected in oscillator model
//
//                Revision 1.5 : I.N. - 10-Jan-2008
//                  - added SPC_CO_001_33V corner cell
//                  - oscillator model updated
//
//                Revision 1.4 : I.N. - 09-Nov-2007
//                  - "REN +=> C" timing arcs added to "specify" sections for both drivers
//
//                Revision 1.3 : I.N. - 12-Oct-2007
//                  - "specify" sections updated
//
//                Revision 1.2 : I.N. - 30-Sep-2007
//                  - TRAN statement added to ANC_BI_DWR_33V pad to show connection
//                    between ANIN and RIN
//
//                Revision 1.1 : I.N. - 15-Jul-2007
//                  - oscillator added
//                  - PWP_VD_PDO_33V model corrected
//                  - changed analog power/ground pads to have correct supply
//                         strength specification
//                  - "specify" sections updated
//
//                Revision 1.0 : I.N. - 10-May-2007
//                  - created
//
// Note         :
//                if VERIFY_UNCONNECTED_SIGNALS is defined, users will be warned
//                when POC and mode selector signals are not driven
//
// -----------------------------------------------------------------------------
`timescale 1ns/1ps

`define VERIFY_UNCONNECTED_SIGNALS

`ifdef VERIFY_UNCONNECTED_SIGNALS
`nounconnected_drive
`endif

// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// ---------------- D I G I T A L   I / O   P A D S ----------------------------
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
//
// -----------------------------------------------------------------------------
`celldefine
module SRC_BI_SDS_33V_STB (I, OEN, PAD, C, REN, SMT, SR, P1, P2, E1, E2, HVPS, POS, POC, BIAS, VDD, VSS, DVDD, DVSS);

    input  I;                // data input from core
    input  OEN;              // active low output enable
    inout  PAD;              // PAD pin
    output C;                // data input from PAD to core

    input  REN;              // Active-high receiver enable
                             //        REN = 0 - C is driven to 0
                             //        REN = 1 - receiver enabled

    input  SMT;              // Active-high Schmitt trigger enable
    input  SR;
    input  P1, P2;           //
    input  E1, E2;           // Drive strength select

    input  POC;              // Power-on control
    input  HVPS;             // High-voltage power supply signal
    input  BIAS;             // Bias

    input  POS;              //

    input  VDD, VSS;         // core power/ground
    input  DVDD, DVSS;       // I/O power/ground

    wire   REG_REPEATER;

    bufif0  (PAD, I, OEN);              // output path
    bufif1(weak0, weak1) (PAD, 1'b1,  P1 & !P2);
    bufif1(weak0, weak1) (PAD, 1'b0, !P1 &  P2);

    // Since invalid power (POC) is an analog function that cannot be
    // accurately modeled in Verilog, POC is set to 1'b0 in the _PDO_
    // power pad models.  The following statement regarding the POS
    // functionality is included to ensure that the POS and POC signals
    // are not left floating.  The user cannot see the pulldown effect in
    // Verilog simulations unless the & POC is removed from the statement.
    bufif1(weak0, weak1) (PAD, 1'b0, POS & POC);

    bufif0               (REG_REPEATER, 1'b0, PAD);        // bus-holder state
    bufif1               (REG_REPEATER, 1'b1, PAD);        // bus-holder state
    bufif1(weak0, weak1) (PAD, REG_REPEATER, P1 & P2);

    and     (C, REN, PAD);             // input path

`ifdef VERIFY_UNCONNECTED_SIGNALS
    initial #0 if ( E1     !== 1'b0 &&  E1     !== 1'b1) $display ("***FATAL***: E1 is NOT connected, it has to be driven by the core!");
    initial #0 if ( E2     !== 1'b0 &&  E2     !== 1'b1) $display ("***FATAL***: E2 is NOT connected, it has to be driven by the core!");
    initial #0 if ( SMT    !== 1'b0 &&  SMT    !== 1'b1) $display ("***FATAL***: SMT is NOT connected, it has to be driven by the core!");
    initial #0 if ( SR     !== 1'b0 &&  SR     !== 1'b1) $display ("***FATAL***: SR is NOT connected, it has to be driven by the core!");
    initial #0 if ( POC    !== 1'b0 &&  POC    !== 1'b1) $display ("***FATAL***: POC is NOT connected, it has to be driven by the special power pad!");
`endif

    specify
       if ((E1 == 1'b0) && (E2 == 1'b0) && (SR == 1'b0)) (I   +=> PAD)=(0, 0);
       if ((E1 == 1'b0) && (E2 == 1'b0) && (SR == 1'b1)) (I   +=> PAD)=(0, 0);
       if ((E1 == 1'b0) && (E2 == 1'b1) && (SR == 1'b0)) (I   +=> PAD)=(0, 0);
       if ((E1 == 1'b0) && (E2 == 1'b1) && (SR == 1'b1)) (I   +=> PAD)=(0, 0);
       if ((E1 == 1'b1) && (E2 == 1'b0) && (SR == 1'b0)) (I   +=> PAD)=(0, 0);
       if ((E1 == 1'b1) && (E2 == 1'b0) && (SR == 1'b1)) (I   +=> PAD)=(0, 0);
       if ((E1 == 1'b1) && (E2 == 1'b1) && (SR == 1'b0)) (I   +=> PAD)=(0, 0);
       if ((E1 == 1'b1) && (E2 == 1'b1) && (SR == 1'b1)) (I   +=> PAD)=(0, 0);

       if ((E1 == 1'b0) && (E2 == 1'b0) && (SR == 1'b0)) (OEN -=> PAD)=(0, 0, 0, 0, 0, 0);
       if ((E1 == 1'b0) && (E2 == 1'b0) && (SR == 1'b1)) (OEN -=> PAD)=(0, 0, 0, 0, 0, 0);
       if ((E1 == 1'b0) && (E2 == 1'b1) && (SR == 1'b0)) (OEN -=> PAD)=(0, 0, 0, 0, 0, 0);
       if ((E1 == 1'b0) && (E2 == 1'b1) && (SR == 1'b1)) (OEN -=> PAD)=(0, 0, 0, 0, 0, 0);
       if ((E1 == 1'b1) && (E2 == 1'b0) && (SR == 1'b0)) (OEN -=> PAD)=(0, 0, 0, 0, 0, 0);
       if ((E1 == 1'b1) && (E2 == 1'b0) && (SR == 1'b1)) (OEN -=> PAD)=(0, 0, 0, 0, 0, 0);
       if ((E1 == 1'b1) && (E2 == 1'b1) && (SR == 1'b0)) (OEN -=> PAD)=(0, 0, 0, 0, 0, 0);
       if ((E1 == 1'b1) && (E2 == 1'b1) && (SR == 1'b1)) (OEN -=> PAD)=(0, 0, 0, 0, 0, 0);

       if (SMT == 1'b0) (PAD +=> C)  =(0, 0);
       if (SMT == 1'b1) (PAD +=> C)  =(0, 0);

       if (SMT == 1'b0) (REN +=> C)  =(0, 0);
       if (SMT == 1'b1) (REN +=> C)  =(0, 0);

    endspecify

endmodule
`endcelldefine

// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// ---------------- I N P U T   O N L Y   P A D S ------------------------------
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// -- STP_IN_001_33V_NC  -------------------------------------------------------
// -----------------------------------------------------------------------------

// -----------------------------------------------------------------------------
// Input pad
// -----------------------------------------------------------------------------
`celldefine
module STC_IN_001_33V_NC (PAD, C, POC, HVPS, BIAS, VDD, VSS, DVDD, DVSS);
    input  PAD;              // PAD pin
    output C;                // data input from PAD to core

    input  POC;              // Power-on control
    input  HVPS;             // High-voltage power supply signal
    input  BIAS;             // Bias

    input  VDD, VSS;         // core power/ground
    input  DVDD, DVSS;       // I/O power/ground

    buf    (C, PAD);

`ifdef VERIFY_UNCONNECTED_SIGNALS
    initial #0 if ( POC    !== 1'b0 &&  POC    !== 1'b1) $display ("***FATAL***: POC is NOT connected, it has to be driven by the special power pad!");
`endif

    specify
       (PAD +=> C)  =(0, 0);
    endspecify

endmodule
`endcelldefine


// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// -- P O W E R   /   G R O U N D   /     M I S C E L L A N E O U S   P A D S --
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------


// -----------------------------------------------------------------------------
// I/O Power, 3.3V
// -----------------------------------------------------------------------------
`celldefine
module PWC_VD_RDO_33V (POC, HVPS, BIAS, VDD, VSS, DVDD, DVSS);
    inout  DVDD;

    input  POC;              // Power-on control
    input  HVPS;             // High-voltage power supply signal
    input  BIAS;             // Bias

    input  VDD, VSS;         // core power/ground
    input  DVSS;             // I/O ground

    supply1 DVDD;
endmodule
`endcelldefine

// -----------------------------------------------------------------------------
// 3.3V I/O Power with power down control
// -----------------------------------------------------------------------------
`celldefine
module PWC_VD_PDO_33V (SEL18, POC, HVPS, BIAS, VDD, VSS, DVDD, DVSS);
    input  SEL18;            // voltage selector

    inout  DVDD;
    output POC;              // Power-on control
    output HVPS;             // High-voltage power supply signal
    output BIAS;

    input  VDD, VSS;         // core power/ground
    input  DVSS;             // I/O ground

    supply1 DVDD;

    bufif0(POC, 1'b0, 1'b0); // POC tied to 0
    not(HVPS, SEL18);

endmodule
`endcelldefine

// -----------------------------------------------------------------------------
// Core Power
// -----------------------------------------------------------------------------
`celldefine
module PWC_VD_RCD_12V (POC, HVPS, BIAS, VDD, VSS, DVDD, DVSS);
    inout  VDD;

    input  POC;              // Power-on control
    input  HVPS;             // High-voltage power supply signal
    input  BIAS;             // Bias

    input  VSS;              // core ground
    input  DVDD, DVSS;       // I/O power/ground

    supply1 VDD;
endmodule
`endcelldefine

// -----------------------------------------------------------------------------
// Core Ground
// -----------------------------------------------------------------------------
`celldefine
module PWC_VS_RCD_12V (POC, HVPS, BIAS, VDD, VSS, DVDD, DVSS);
    inout  VSS;

    input  POC;              // Power-on control
    input  HVPS;             // High-voltage power supply signal
    input  BIAS;             // Bias

    input  VDD;              // core power
    input  DVDD, DVSS;       // I/O power/ground

    supply0 VSS;
endmodule
`endcelldefine

// -----------------------------------------------------------------------------
// I/O Ground, 3.3V
// -----------------------------------------------------------------------------
`celldefine
module PWC_VS_RDO_33V (POC, HVPS, BIAS, VDD, VSS, DVDD, DVSS);
    inout  DVSS;

    input  POC;              // Power-on control
    input  HVPS;             // High-voltage power supply signal
    input  BIAS;             // Bias

    input  VDD, VSS;         // core power/ground
    input  DVDD;             // I/O power

    supply0 DVSS;
endmodule
`endcelldefine

// -----------------------------------------------------------------------------
// Analog input
// -----------------------------------------------------------------------------
`celldefine
module ANC_BI_DWR_33V (ANIN, RIN, POC, HVPS, BIAS, VDD, VSS, DVDD, DVSS);
    inout  ANIN;
    inout  RIN;

    input  POC;              // Power-on control
    input  HVPS;             // High-voltage power supply signal
    input  BIAS;             // Bias

    input  VDD, VSS;         // core power/ground
    input  DVDD, DVSS;       // I/O power/ground

    tran(ANIN, RIN);
endmodule
`endcelldefine

// -----------------------------------------------------------------------------
// Corner pad
// -----------------------------------------------------------------------------
`celldefine
module SPC_CO_000_33V (BIAS_L, BIAS_R, HVPS_L, HVPS_R, POC_L, POC_R, DVDD_L, DVDD_R, DVSS_L, DVSS_R, VDD, VSS);
    input  BIAS_L, BIAS_R;   // Bias
    input  HVPS_L, HVPS_R;   // HVPS
    input  POC_L, POC_R;     // POC

    input  VDD, VSS;         // core power/ground
    input  DVDD_L, DVSS_L;   // I/O power/ground
    input  DVDD_R, DVSS_R;   // I/O power/ground
endmodule
`endcelldefine

// -----------------------------------------------------------------------------
// Corner pad with pass-through power busses
// -----------------------------------------------------------------------------
`celldefine
module SPC_CO_001_33V (BIAS, HVPS, POC, DVDD, DVSS, VDD, VSS);
    input  BIAS;             // Bias
    input  HVPS;             // HVPS
    input  POC;              // POC

    input  VDD, VSS;         // core power/ground
    input  DVDD, DVSS;       // I/O power/ground
endmodule
`endcelldefine

// -----------------------------------------------------------------------------
// 0.1um spacer pad
// -----------------------------------------------------------------------------
`celldefine
module SPC_SP_000_33V (POC, HVPS, BIAS, VDD, VSS, DVDD, DVSS);
    input  POC;              // Power-on control
    input  HVPS;             // High-voltage power supply signal
    input  BIAS;             // Bias signal

    input  VDD, VSS;         // core power/ground
    input  DVDD, DVSS;       // I/O power/ground
endmodule
`endcelldefine

// -----------------------------------------------------------------------------
// 1um spacer pad
// -----------------------------------------------------------------------------
`celldefine
module SPC_SP_001_33V (POC, HVPS, BIAS, VDD, VSS, DVDD, DVSS);
    input  POC;              // Power-on control
    input  HVPS;             // High-voltage power supply signal
    input  BIAS;             // Bias signal

    input  VDD, VSS;         // core power/ground
    input  DVDD, DVSS;       // I/O power/ground
endmodule
`endcelldefine

// -----------------------------------------------------------------------------
// 5um spacer pad
// -----------------------------------------------------------------------------
`celldefine
module SPC_SP_005_33V (POC, HVPS, BIAS, VDD, VSS, DVDD, DVSS);
    input  POC;              // Power-on control
    input  HVPS;             // High-voltage power supply signal
    input  BIAS;             // Bias signal

    input  VDD, VSS;         // core power/ground
    input  DVDD, DVSS;       // I/O power/ground
endmodule
`endcelldefine

// -----------------------------------------------------------------------------
// 10um spacer pad
// -----------------------------------------------------------------------------
`celldefine
module SPC_SP_010_33V (POC, HVPS, BIAS, VDD, VSS, DVDD, DVSS);
    input  POC;              // Power-on control
    input  HVPS;             // High-voltage power supply signal
    input  BIAS;             // Bias signal

    input  VDD, VSS;         // core power/ground
    input  DVDD, DVSS;       // I/O power/ground
endmodule
`endcelldefine

// -----------------------------------------------------------------------------
// 5um rail splitter pad
// -----------------------------------------------------------------------------
`celldefine
module SPC_RS_005_33V (VDD, VSS);
    input  VDD, VSS;         // core power/ground
endmodule
`endcelldefine


// -----------------------------------------------------------------------------
//
// -----------------------------------------------------------------------------
`celldefine
module PWC_VD_ANA_12V (AVDD, POC, HVPS, BIAS, VDD, VSS, DVDD, DVSS);
    inout  AVDD;             //

    input  POC;              // Power-on control
    input  HVPS;             // High-voltage power supply signal
    input  BIAS;             // Bias

    input  VDD, VSS;         // core power/ground
    input  DVDD, DVSS;       // I/O power/ground

    supply1 AVDD;
endmodule
`endcelldefine

// -----------------------------------------------------------------------------
//
// -----------------------------------------------------------------------------
`celldefine
module PWC_VS_ANA_12V (AVSS, POC, HVPS, BIAS, VDD, VSS, DVDD, DVSS);
    inout  AVSS;             //

    input  POC;              // Power-on control
    input  HVPS;             // High-voltage power supply signal
    input  BIAS;             // Bias

    input  VDD, VSS;         // core power/ground
    input  DVDD, DVSS;       // I/O power/ground

    supply0 AVSS;
endmodule
`endcelldefine

// -----------------------------------------------------------------------------
//
// -----------------------------------------------------------------------------
`celldefine
module PWC_VD_ANA_33V (ADVDD, POC, HVPS, BIAS, VDD, VSS, DVDD, DVSS);
    inout  ADVDD;            //

    input  POC;              // Power-on control
    input  HVPS;             // High-voltage power supply signal
    input  BIAS;             // Bias

    input  VDD, VSS;         // core power/ground
    input  DVDD, DVSS;       // I/O power/ground

    supply1 ADVDD;
endmodule
`endcelldefine

// -----------------------------------------------------------------------------
//
// -----------------------------------------------------------------------------
`celldefine
module PWC_VS_ANA_33V (ADVSS, POC, HVPS, BIAS, VDD, VSS, DVDD, DVSS);
    inout  ADVSS;            //

    input  POC;              // Power-on control
    input  HVPS;             // High-voltage power supply signal
    input  BIAS;             // Bias

    input  VDD, VSS;         // core power/ground
    input  DVDD, DVSS;       // I/O power/ground

    supply0 ADVSS;
endmodule
`endcelldefine


