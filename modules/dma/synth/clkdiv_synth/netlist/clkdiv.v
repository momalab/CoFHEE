/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : P-2019.03-SP3
// Date      : Tue Jan 26 19:47:22 2021
/////////////////////////////////////////////////////////////


module clkdiv ( clk, rst_n, div, clkdiv );
  input [15:0] div;
  input clk, rst_n;
  output clkdiv;
  wire   clkdiv_loc, diven_d, diven, N48, n2, n78, n79, n80, n81, n89, n94,
         n97, n98, n99, n100, n103, n104, n105, n106, n107, n108, n109, n110,
         n111, n112, n113, n114, n121, n122, n123, n125, n126, n127, n134,
         n136, n137, n138, n139, n140, n146, n147, n148, n149, n150, n151,
         n152, n154, n155, n156, n157, n158, n159, n160, n161, n162, n163,
         n164, n165, n166, n167, n168, n169, n170, n171, n173, n174, n175,
         n176, n177, n178, n179, n180, n184, n185, n186, n187, n188, n189,
         n190, n191, n192, n193, n194, n195, n196, n197, n198, n199, n200,
         n203, n204, n209, n210, n211, n212, n213, n214, n215, n216, n217,
         n218, n219, n221, n222, n223, n225, n226, n227, n229, n230, n231,
         n232, n233, n234, n235, n236, n237, n238, n239, n240, n241, n242,
         n243, n244, n245, n246, n247, n248, n249, n250, n251, n252, n253,
         n254, n255, n256, n257, n258, n259, n260, n261, n262, n263, n264,
         n265, n266, n267, n268, n269, n270, n271, n272, n273, n274, n275,
         n276, n277, n278, n279, n280, n281, n282, n283, n284, n285, n286,
         n287, n288, n289, n290, n291, n292, n293, n294, n295, n296, n297;
  wire   [15:1] cnt;

  DFFNRPQ_X1M_A9TH diven_d_reg ( .D(diven), .CKN(clk), .R(n247), .Q(diven_d)
         );
  DFFRPQ_X4M_A9TH diven_reg ( .D(N48), .CK(clk), .R(n247), .Q(diven) );
  DFFRPQ_X2M_A9TH cnt_reg_7_ ( .D(n244), .CK(clk), .R(n247), .Q(cnt[7]) );
  DFFRPQ_X2M_A9TH cnt_reg_15_ ( .D(n233), .CK(clk), .R(n247), .Q(cnt[15]) );
  XNOR2_X2M_A9TH U99 ( .A(n203), .B(n287), .Y(n107) );
  XNOR2_X4M_A9TH U143 ( .A(div[7]), .B(cnt[6]), .Y(n164) );
  XOR2_X2M_A9TH U152 ( .A(n216), .B(n289), .Y(n79) );
  XNOR2_X3M_A9TH U170 ( .A(n192), .B(cnt[11]), .Y(n94) );
  XNOR2_X3M_A9TH U171 ( .A(n194), .B(n291), .Y(n146) );
  NAND3_X2M_A9TH U173 ( .A(n278), .B(diven), .C(clkdiv_loc), .Y(n234) );
  XNOR2_X3M_A9TH U180 ( .A(div[14]), .B(cnt[13]), .Y(n174) );
  XNOR2_X2M_A9TH U203 ( .A(div[12]), .B(cnt[11]), .Y(n170) );
  XOR2_X3M_A9TH U207 ( .A(div[1]), .B(n232), .Y(n149) );
  XNOR2_X3M_A9TH U217 ( .A(n134), .B(n262), .Y(n105) );
  NOR2_X6B_A9TH U231 ( .A(n276), .B(n139), .Y(n195) );
  XNOR2_X3M_A9TH U239 ( .A(div[4]), .B(cnt[3]), .Y(n166) );
  XNOR2_X3M_A9TH U243 ( .A(div[15]), .B(n294), .Y(n176) );
  AOI211_X4M_A9TH U246 ( .A0(n191), .A1(n190), .B0(n188), .C0(n189), .Y(n233)
         );
  INV_X1B_A9TH U247 ( .A(rst_n), .Y(n247) );
  NAND2_X4M_A9TH U115 ( .A(n289), .B(n275), .Y(n200) );
  NAND2_X1P4M_A9TH U96 ( .A(n126), .B(n268), .Y(n125) );
  XOR2_X1M_A9TH U153 ( .A(n217), .B(n261), .Y(n80) );
  INV_X2M_A9TH U84 ( .A(n229), .Y(n191) );
  AND2_X3M_A9TH U116 ( .A(cnt[11]), .B(cnt[10]), .Y(n226) );
  chiplib_mux2 u_DONT_TOUCH_CLKMUX_inst ( .a(clk), .b(clkdiv_loc), .s(diven_d), 
        .y(clkdiv) );
  DFFRPQ_X2M_A9TH cnt_reg_1_ ( .D(n245), .CK(clk), .R(n247), .Q(cnt[1]) );
  OAI31_X6M_A9TH U162 ( .A0(n186), .A1(n185), .A2(n184), .B0(n100), .Y(n187)
         );
  AND2_X6M_A9TH U216 ( .A(n295), .B(cnt[8]), .Y(n103) );
  DFFRPQ_X2M_A9TH cnt_reg_14_ ( .D(n243), .CK(clk), .R(n247), .Q(cnt[14]) );
  AND2_X2M_A9TH U160 ( .A(n260), .B(n226), .Y(n123) );
  AND2_X2M_A9TH U142 ( .A(n103), .B(n268), .Y(n225) );
  DFFRPQ_X2M_A9TH cnt_reg_5_ ( .D(n113), .CK(clk), .R(n247), .Q(cnt[5]) );
  AND2_X2M_A9TH U124 ( .A(cnt[3]), .B(cnt[5]), .Y(n110) );
  OAI21_X3M_A9TH U223 ( .A0(n229), .A1(n125), .B0(n121), .Y(n230) );
  DFFRPQ_X3M_A9TH cnt_reg_9_ ( .D(n242), .CK(clk), .R(n247), .Q(cnt[9]) );
  INV_X2M_A9TH U245 ( .A(n278), .Y(n189) );
  XNOR2_X3M_A9TH U241 ( .A(div[11]), .B(cnt[10]), .Y(n171) );
  NOR2_X6A_A9TH U229 ( .A(n276), .B(n186), .Y(n159) );
  DFFRPQN_X3M_A9TH cnt_reg_12_ ( .D(n236), .CK(clk), .R(n247), .QN(n273) );
  DFFRPQN_X3M_A9TH cnt_reg_8_ ( .D(n241), .CK(clk), .R(n247), .QN(n269) );
  NAND3_X6A_A9TH U140 ( .A(n297), .B(n225), .C(n123), .Y(n122) );
  OR3_X6M_A9TH U113 ( .A(n293), .B(n200), .C(n248), .Y(n203) );
  INV_X7P5M_A9TH U158 ( .A(n232), .Y(n198) );
  NOR2B_X2M_A9TH U101 ( .AN(diven), .B(cnt[15]), .Y(n173) );
  DFFRPQ_X2M_A9TH clkdiv_loc_reg ( .D(n2), .CK(clk), .R(n247), .Q(n283) );
  NAND4_X4A_A9TH U175 ( .A(n165), .B(n166), .C(n167), .D(n149), .Y(n148) );
  OAI31_X6M_A9TH U189 ( .A0(n221), .A1(n248), .A2(n293), .B0(n218), .Y(n222)
         );
  NAND4_X4M_A9TH U209 ( .A(n289), .B(n275), .C(n262), .D(n287), .Y(n221) );
  DFFSQ_X1M_A9TH cnt_reg_0_ ( .D(n246), .CK(clk), .SN(rst_n), .Q(n271) );
  DFFRPQN_X3M_A9TH cnt_reg_4_ ( .D(n239), .CK(clk), .R(n247), .QN(n254) );
  DFFRPQN_X3M_A9TH cnt_reg_6_ ( .D(n114), .CK(clk), .R(n247), .QN(n253) );
  DFFRPQN_X3M_A9TH cnt_reg_2_ ( .D(n112), .CK(clk), .R(n247), .QN(n252) );
  DFFRPQN_X3M_A9TH cnt_reg_13_ ( .D(n235), .CK(clk), .R(n247), .QN(n251) );
  DFFRPQN_X3M_A9TH cnt_reg_3_ ( .D(n240), .CK(clk), .R(n247), .QN(n270) );
  XNOR2_X3M_A9TH U156 ( .A(div[13]), .B(cnt[12]), .Y(n175) );
  INV_X1M_A9TH U244 ( .A(cnt[13]), .Y(n185) );
  NAND4_X3A_A9TH U176 ( .A(n176), .B(n175), .C(n174), .D(n173), .Y(n177) );
  AND2_X2M_A9TH U149 ( .A(n249), .B(n225), .Y(n190) );
  XNOR2_X3M_A9TH U87 ( .A(n159), .B(n260), .Y(n160) );
  NOR3_X2A_A9TH U92 ( .A(div[14]), .B(div[15]), .C(div[7]), .Y(n213) );
  INV_X1M_A9TH U105 ( .A(cnt[7]), .Y(n218) );
  INV_X2M_A9TH U151 ( .A(n231), .Y(clkdiv_loc) );
  INV_X9M_A9TH U234 ( .A(div[0]), .Y(n156) );
  NAND2_X2A_A9TH U224 ( .A(n122), .B(n227), .Y(n121) );
  INV_X11M_A9TH U235 ( .A(div[7]), .Y(n157) );
  NOR2_X2A_A9TH U225 ( .A(n127), .B(n193), .Y(n126) );
  OR4_X1M_A9TH U86 ( .A(div[8]), .B(div[9]), .C(div[2]), .D(div[1]), .Y(n210)
         );
  DFFRPQN_X3M_A9TH cnt_reg_11_ ( .D(n237), .CK(clk), .R(n247), .QN(n250) );
  DFFRPQ_X2M_A9TH cnt_reg_10_ ( .D(n238), .CK(clk), .R(n247), .Q(cnt[10]) );
  XOR2_X3M_A9TH U117 ( .A(cnt[7]), .B(n157), .Y(n155) );
  AND2_X6M_A9TH U125 ( .A(cnt[6]), .B(cnt[7]), .Y(n104) );
  XNOR2_X3M_A9TH U210 ( .A(div[10]), .B(n295), .Y(n168) );
  XNOR2_X1P4M_A9TH U242 ( .A(div[9]), .B(cnt[8]), .Y(n169) );
  XNOR2_X2M_A9TH U240 ( .A(div[2]), .B(n292), .Y(n165) );
  XNOR2_X2M_A9TH U236 ( .A(div[8]), .B(cnt[7]), .Y(n163) );
  NAND2_X1M_A9TH U111 ( .A(n260), .B(n294), .Y(n127) );
  INV_X2M_A9TH U114 ( .A(n103), .Y(n193) );
  AND2_X1M_A9TH U150 ( .A(n287), .B(n261), .Y(n109) );
  INV_X1M_A9TH U106 ( .A(n275), .Y(n215) );
  INV_X1B_A9TH U103 ( .A(n294), .Y(n227) );
  INV_X1B_A9TH U104 ( .A(n296), .Y(n139) );
  NAND2_X1P4M_A9TH U226 ( .A(n294), .B(cnt[12]), .Y(n184) );
  INV_X1M_A9TH U159 ( .A(cnt[15]), .Y(n100) );
  NAND2_X3M_A9TH U227 ( .A(n226), .B(n103), .Y(n186) );
  NAND2_X2A_A9TH U98 ( .A(n297), .B(n226), .Y(n229) );
  AND2_X1M_A9TH U102 ( .A(n292), .B(diven), .Y(n78) );
  AND2_X1M_A9TH U97 ( .A(n198), .B(diven), .Y(n111) );
  NOR2_X1M_A9TH U157 ( .A(n100), .B(n184), .Y(n249) );
  NOR2_X2M_A9TH U95 ( .A(n293), .B(n215), .Y(n216) );
  XNOR2_X1M_A9TH U91 ( .A(n275), .B(n293), .Y(n106) );
  NOR2_X1M_A9TH U93 ( .A(div[10]), .B(div[11]), .Y(n211) );
  NAND2_X1M_A9TH U82 ( .A(n222), .B(n276), .Y(n223) );
  NOR2_X1B_A9TH U83 ( .A(div[12]), .B(div[13]), .Y(n212) );
  NOR2_X4M_A9TH U85 ( .A(n276), .B(n98), .Y(n192) );
  INV_X1B_A9TH U88 ( .A(n283), .Y(n231) );
  INV_X2M_A9TH U89 ( .A(n261), .Y(n248) );
  NAND2_X1M_A9TH U90 ( .A(n291), .B(n103), .Y(n98) );
  BUF_X3M_A9TH U94 ( .A(cnt[5]), .Y(n287) );
  BUFH_X1M_A9TH U100 ( .A(cnt[10]), .Y(n291) );
  XNOR2_X3M_A9TH U107 ( .A(div[3]), .B(n290), .Y(n167) );
  BUF_X2M_A9TH U108 ( .A(cnt[8]), .Y(n296) );
  BUFH_X6M_A9TH U109 ( .A(n288), .Y(n261) );
  BUF_X3M_A9TH U110 ( .A(cnt[13]), .Y(n268) );
  INV_X3M_A9TH U112 ( .A(n267), .Y(n272) );
  NAND4_X2M_A9TH U118 ( .A(n214), .B(n213), .C(n212), .D(n211), .Y(N48) );
  NOR2_X1P4B_A9TH U119 ( .A(n210), .B(n209), .Y(n214) );
  NAND2B_X3M_A9TH U120 ( .AN(n265), .B(n234), .Y(n2) );
  NOR2_X4A_A9TH U121 ( .A(n284), .B(n257), .Y(n258) );
  NAND3_X6A_A9TH U122 ( .A(n154), .B(n155), .C(n97), .Y(n147) );
  NOR2_X4A_A9TH U123 ( .A(n89), .B(n223), .Y(n244) );
  NAND2_X6A_A9TH U126 ( .A(n290), .B(n288), .Y(n158) );
  NAND3_X4A_A9TH U127 ( .A(n99), .B(n187), .C(diven), .Y(n188) );
  AND2_X3M_A9TH U128 ( .A(n277), .B(n107), .Y(n113) );
  OR4_X6M_A9TH U129 ( .A(n136), .B(n150), .C(n147), .D(n138), .Y(n137) );
  INV_X7P5B_A9TH U130 ( .A(n252), .Y(cnt[2]) );
  OR4_X8M_A9TH U131 ( .A(n279), .B(n280), .C(n281), .D(n282), .Y(n138) );
  BUFH_X3M_A9TH U132 ( .A(cnt[14]), .Y(n294) );
  OR4_X1P4M_A9TH U133 ( .A(div[4]), .B(div[3]), .C(div[6]), .D(div[5]), .Y(
        n209) );
  BUFH_X3M_A9TH U134 ( .A(cnt[12]), .Y(n260) );
  XOR2_X3M_A9TH U135 ( .A(div[14]), .B(cnt[14]), .Y(n282) );
  INV_X2M_A9TH U136 ( .A(n197), .Y(n274) );
  BUFH_X4M_A9TH U137 ( .A(cnt[9]), .Y(n295) );
  NOR2_X4A_A9TH U138 ( .A(n89), .B(n196), .Y(n242) );
  BUFH_X9M_A9TH U139 ( .A(cnt[2]), .Y(n290) );
  INV_X5M_A9TH U141 ( .A(n251), .Y(cnt[13]) );
  NOR2_X4A_A9TH U144 ( .A(n89), .B(n94), .Y(n237) );
  XNOR2_X3M_A9TH U145 ( .A(n255), .B(n268), .Y(n108) );
  NAND2_X6A_A9TH U146 ( .A(n278), .B(n111), .Y(n246) );
  BUFH_X6M_A9TH U147 ( .A(n219), .Y(n293) );
  BUFH_X6M_A9TH U148 ( .A(n290), .Y(n275) );
  NOR2_X4A_A9TH U154 ( .A(n263), .B(n285), .Y(n259) );
  BUFH_X4M_A9TH U155 ( .A(cnt[3]), .Y(n289) );
  INV_X4M_A9TH U161 ( .A(n250), .Y(cnt[11]) );
  INV_X6B_A9TH U163 ( .A(n254), .Y(cnt[4]) );
  INV_X6B_A9TH U164 ( .A(n253), .Y(n267) );
  NAND3_X3M_A9TH U165 ( .A(n260), .B(n226), .C(n103), .Y(n197) );
  NAND2_X3B_A9TH U166 ( .A(n276), .B(n100), .Y(n99) );
  XNOR2_X3M_A9TH U167 ( .A(n195), .B(n295), .Y(n196) );
  XNOR2_X4M_A9TH U168 ( .A(cnt[5]), .B(div[5]), .Y(n97) );
  XOR2_X4M_A9TH U169 ( .A(div[6]), .B(n267), .Y(n264) );
  NAND2_X4M_A9TH U172 ( .A(n297), .B(n274), .Y(n255) );
  NOR2_X6B_A9TH U174 ( .A(n148), .B(n256), .Y(n180) );
  NAND4_X4A_A9TH U177 ( .A(n164), .B(n163), .C(n162), .D(n161), .Y(n256) );
  XNOR2_X4M_A9TH U178 ( .A(div[12]), .B(n273), .Y(n257) );
  XOR2_X4M_A9TH U179 ( .A(div[1]), .B(cnt[1]), .Y(n284) );
  NAND3_X6M_A9TH U181 ( .A(n259), .B(n81), .C(n258), .Y(n136) );
  INV_X6M_A9TH U182 ( .A(n272), .Y(cnt[6]) );
  NOR2_X4A_A9TH U183 ( .A(n89), .B(n146), .Y(n238) );
  BUF_X7P5M_A9TH U184 ( .A(cnt[6]), .Y(n262) );
  XOR2_X4M_A9TH U185 ( .A(div[2]), .B(cnt[2]), .Y(n263) );
  INV_X4M_A9TH U186 ( .A(n271), .Y(n232) );
  NOR2_X6A_A9TH U187 ( .A(n264), .B(n286), .Y(n81) );
  XNOR2_X4M_A9TH U188 ( .A(n288), .B(div[5]), .Y(n162) );
  AND2_X6M_A9TH U190 ( .A(n179), .B(n180), .Y(n265) );
  NAND2_X8M_A9TH U191 ( .A(n292), .B(n198), .Y(n219) );
  NOR2_X8A_A9TH U192 ( .A(n200), .B(n293), .Y(n217) );
  XNOR2_X4M_A9TH U193 ( .A(div[13]), .B(cnt[13]), .Y(n151) );
  NAND3_X6M_A9TH U194 ( .A(n266), .B(n151), .C(n152), .Y(n150) );
  XOR2_X4M_A9TH U195 ( .A(n198), .B(n156), .Y(n266) );
  XNOR2_X4M_A9TH U196 ( .A(div[10]), .B(cnt[10]), .Y(n152) );
  OR4_X8M_A9TH U197 ( .A(n136), .B(n150), .C(n147), .D(n138), .Y(n278) );
  XNOR2_X4M_A9TH U198 ( .A(div[3]), .B(n270), .Y(n285) );
  INV_X4M_A9TH U199 ( .A(n270), .Y(cnt[3]) );
  INV_X4M_A9TH U200 ( .A(n273), .Y(cnt[12]) );
  INV_X16M_A9TH U201 ( .A(n277), .Y(n89) );
  INV_X7P5M_A9TH U202 ( .A(n269), .Y(cnt[8]) );
  NOR2_X4A_A9TH U204 ( .A(n89), .B(n160), .Y(n236) );
  XOR2_X3M_A9TH U205 ( .A(div[4]), .B(cnt[4]), .Y(n281) );
  NAND2_X3A_A9TH U206 ( .A(n278), .B(n78), .Y(n199) );
  BUF_X6M_A9TH U208 ( .A(cnt[1]), .Y(n292) );
  INV_X11M_A9TH U211 ( .A(n297), .Y(n276) );
  NOR2_X4M_A9TH U212 ( .A(n89), .B(n204), .Y(n241) );
  NOR2_X3M_A9TH U213 ( .A(n89), .B(n230), .Y(n243) );
  XNOR2_X4M_A9TH U214 ( .A(div[6]), .B(cnt[5]), .Y(n161) );
  AND2_X11M_A9TH U215 ( .A(n137), .B(diven), .Y(n277) );
  AND3_X11M_A9TH U218 ( .A(n140), .B(n110), .C(n104), .Y(n297) );
  XOR2_X1P4M_A9TH U219 ( .A(n276), .B(n296), .Y(n204) );
  NAND2_X4M_A9TH U220 ( .A(n217), .B(n109), .Y(n134) );
  NOR2_X6B_A9TH U221 ( .A(n276), .B(n193), .Y(n194) );
  NOR2_X8M_A9TH U222 ( .A(n219), .B(n158), .Y(n140) );
  XOR2_X4M_A9TH U228 ( .A(div[11]), .B(cnt[11]), .Y(n279) );
  XOR2_X4M_A9TH U230 ( .A(div[8]), .B(cnt[8]), .Y(n280) );
  NAND4_X4M_A9TH U232 ( .A(n169), .B(n170), .C(n171), .D(n168), .Y(n178) );
  NOR2_X4B_A9TH U233 ( .A(n177), .B(n178), .Y(n179) );
  AND2_X2M_A9TH U237 ( .A(n277), .B(n105), .Y(n114) );
  XOR2_X4M_A9TH U238 ( .A(n199), .B(n246), .Y(n245) );
  AND2_X2M_A9TH U248 ( .A(n277), .B(n80), .Y(n239) );
  AND2_X2M_A9TH U249 ( .A(n277), .B(n106), .Y(n112) );
  AND2_X2M_A9TH U250 ( .A(n277), .B(n108), .Y(n235) );
  AND2_X2M_A9TH U251 ( .A(n277), .B(n79), .Y(n240) );
  XOR2_X4M_A9TH U252 ( .A(div[9]), .B(cnt[9]), .Y(n286) );
  BUF_X13M_A9TH U253 ( .A(cnt[4]), .Y(n288) );
  XNOR2_X4M_A9TH U254 ( .A(div[15]), .B(cnt[15]), .Y(n154) );
endmodule

