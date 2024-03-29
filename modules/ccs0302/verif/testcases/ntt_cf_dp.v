uartm_write_128     (.addr(GPCFG_N_ADDR[0]),        .data(128'd257));  
uartm_write_256     (.addr(GPCFG_NSQ_ADDR[0]),      .data(256'd255)); 
uartm_write         (.addr(GPCFG_NSQ_ADDR[5]),      .data(32'd16));  
coef[0] = 128'd235;
coef[1] = 128'd207;
coef[2] = 128'd209;
coef[3] = 128'd89;
coef[4] = 128'd226;
coef[5] = 128'd197;
coef[6] = 128'd158;
coef[7] = 128'd77;
coef[8] = 128'd108;
coef[9] = 128'd222;
coef[10] = 128'd145;
coef[11] = 128'd215;
coef[12] = 128'd227;
coef[13] = 128'd113;
coef[14] = 128'd83;
coef[15] = 128'd205;
coef[16] = 128'd216;
coef[17] = 128'd62;
coef[18] = 128'd210;
coef[19] = 128'd118;
coef[20] = 128'd185;
coef[21] = 128'd14;
coef[22] = 128'd201;
coef[23] = 128'd24;
coef[24] = 128'd1;
coef[25] = 128'd137;
coef[26] = 128'd67;
coef[27] = 128'd71;
coef[28] = 128'd54;
coef[29] = 128'd41;
coef[30] = 128'd155;
coef[31] = 128'd206;
coef[32] = 128'd82;
coef[33] = 128'd200;
coef[34] = 128'd144;
coef[35] = 128'd59;
coef[36] = 128'd139;
coef[37] = 128'd33;
coef[38] = 128'd39;
coef[39] = 128'd136;
coef[40] = 128'd242;
coef[41] = 128'd180;
coef[42] = 128'd254;
coef[43] = 128'd0;
coef[44] = 128'd198;
coef[45] = 128'd124;
coef[46] = 128'd15;
coef[47] = 128'd142;
coef[48] = 128'd246;
coef[49] = 128'd6;
coef[50] = 128'd42;
coef[51] = 128'd97;
coef[52] = 128'd248;
coef[53] = 128'd187;
coef[54] = 128'd64;
coef[55] = 128'd27;
coef[56] = 128'd79;
coef[57] = 128'd78;
coef[58] = 128'd8;
coef[59] = 128'd5;
coef[60] = 128'd93;
coef[61] = 128'd112;
coef[62] = 128'd250;
coef[63] = 128'd106;
coef[64] = 128'd110;
coef[65] = 128'd160;
coef[66] = 128'd86;
coef[67] = 128'd179;
coef[68] = 128'd195;
coef[69] = 128'd29;
coef[70] = 128'd25;
coef[71] = 128'd170;
coef[72] = 128'd125;
coef[73] = 128'd63;
coef[74] = 128'd156;
coef[75] = 128'd184;
coef[76] = 128'd55;
coef[77] = 128'd10;
coef[78] = 128'd72;
coef[79] = 128'd4;
coef[80] = 128'd194;
coef[81] = 128'd56;
coef[82] = 128'd150;
coef[83] = 128'd153;
coef[84] = 128'd217;
coef[85] = 128'd84;
coef[86] = 128'd102;
coef[87] = 128'd240;
coef[88] = 128'd37;
coef[89] = 128'd182;
coef[90] = 128'd16;
coef[91] = 128'd243;
coef[92] = 128'd133;
coef[93] = 128'd99;
coef[94] = 128'd238;
coef[95] = 128'd32;
coef[96] = 128'd87;
coef[97] = 128'd154;
coef[98] = 128'd80;
coef[99] = 128'd30;
coef[100] = 128'd88;
coef[101] = 128'd138;
coef[102] = 128'd122;
coef[103] = 128'd26;
coef[104] = 128'd22;
coef[105] = 128'd172;
coef[106] = 128'd23;
coef[107] = 128'd161;
coef[108] = 128'd104;
coef[109] = 128'd120;
coef[110] = 128'd228;
coef[111] = 128'd103;
coef[112] = 128'd247;
coef[113] = 128'd202;
coef[114] = 128'd75;
coef[115] = 128'd43;
coef[116] = 128'd100;
coef[117] = 128'd76;
coef[118] = 128'd157;
coef[119] = 128'd181;
coef[120] = 128'd35;
coef[121] = 128'd131;
coef[122] = 128'd18;
coef[123] = 128'd168;
coef[124] = 128'd38;
coef[125] = 128'd52;
coef[126] = 128'd232;
coef[127] = 128'd96;
twdl[0] = 128'd1;
twdl[1] = 128'd9;
twdl[2] = 128'd81;
twdl[3] = 128'd215;
twdl[4] = 128'd136;
twdl[5] = 128'd196;
twdl[6] = 128'd222;
twdl[7] = 128'd199;
twdl[8] = 128'd249;
twdl[9] = 128'd185;
twdl[10] = 128'd123;
twdl[11] = 128'd79;
twdl[12] = 128'd197;
twdl[13] = 128'd231;
twdl[14] = 128'd23;
twdl[15] = 128'd207;
twdl[16] = 128'd64;
twdl[17] = 128'd62;
twdl[18] = 128'd44;
twdl[19] = 128'd139;
twdl[20] = 128'd223;
twdl[21] = 128'd208;
twdl[22] = 128'd73;
twdl[23] = 128'd143;
twdl[24] = 128'd2;
twdl[25] = 128'd18;
twdl[26] = 128'd162;
twdl[27] = 128'd173;
twdl[28] = 128'd15;
twdl[29] = 128'd135;
twdl[30] = 128'd187;
twdl[31] = 128'd141;
twdl[32] = 128'd241;
twdl[33] = 128'd113;
twdl[34] = 128'd246;
twdl[35] = 128'd158;
twdl[36] = 128'd137;
twdl[37] = 128'd205;
twdl[38] = 128'd46;
twdl[39] = 128'd157;
twdl[40] = 128'd128;
twdl[41] = 128'd124;
twdl[42] = 128'd88;
twdl[43] = 128'd21;
twdl[44] = 128'd189;
twdl[45] = 128'd159;
twdl[46] = 128'd146;
twdl[47] = 128'd29;
twdl[48] = 128'd4;
twdl[49] = 128'd36;
twdl[50] = 128'd67;
twdl[51] = 128'd89;
twdl[52] = 128'd30;
twdl[53] = 128'd13;
twdl[54] = 128'd117;
twdl[55] = 128'd25;
twdl[56] = 128'd225;
twdl[57] = 128'd226;
twdl[58] = 128'd235;
twdl[59] = 128'd59;
twdl[60] = 128'd17;
twdl[61] = 128'd153;
twdl[62] = 128'd92;
twdl[63] = 128'd57;
twdl[64] = 128'd256;
twdl[65] = 128'd248;
twdl[66] = 128'd176;
twdl[67] = 128'd42;
twdl[68] = 128'd121;
twdl[69] = 128'd61;
twdl[70] = 128'd35;
twdl[71] = 128'd58;
twdl[72] = 128'd8;
twdl[73] = 128'd72;
twdl[74] = 128'd134;
twdl[75] = 128'd178;
twdl[76] = 128'd60;
twdl[77] = 128'd26;
twdl[78] = 128'd234;
twdl[79] = 128'd50;
twdl[80] = 128'd193;
twdl[81] = 128'd195;
twdl[82] = 128'd213;
twdl[83] = 128'd118;
twdl[84] = 128'd34;
twdl[85] = 128'd49;
twdl[86] = 128'd184;
twdl[87] = 128'd114;
twdl[88] = 128'd255;
twdl[89] = 128'd239;
twdl[90] = 128'd95;
twdl[91] = 128'd84;
twdl[92] = 128'd242;
twdl[93] = 128'd122;
twdl[94] = 128'd70;
twdl[95] = 128'd116;
twdl[96] = 128'd16;
twdl[97] = 128'd144;
twdl[98] = 128'd11;
twdl[99] = 128'd99;
twdl[100] = 128'd120;
twdl[101] = 128'd52;
twdl[102] = 128'd211;
twdl[103] = 128'd100;
twdl[104] = 128'd129;
twdl[105] = 128'd133;
twdl[106] = 128'd169;
twdl[107] = 128'd236;
twdl[108] = 128'd68;
twdl[109] = 128'd98;
twdl[110] = 128'd111;
twdl[111] = 128'd228;
twdl[112] = 128'd253;
twdl[113] = 128'd221;
twdl[114] = 128'd190;
twdl[115] = 128'd168;
twdl[116] = 128'd227;
twdl[117] = 128'd244;
twdl[118] = 128'd140;
twdl[119] = 128'd232;
twdl[120] = 128'd32;
twdl[121] = 128'd31;
twdl[122] = 128'd22;
twdl[123] = 128'd198;
twdl[124] = 128'd240;
twdl[125] = 128'd104;
twdl[126] = 128'd165;
twdl[127] = 128'd200;
for (i = 0; i < POLYDEG; i++) begin
  uartm_write_128     (.addr(FHEMEM0_BASE + 16*i),  .data(coef[i]));
end
for (i = 0; i < POLYDEG; i++) begin
  uartm_write_128     (.addr(FHEMEM3_BASE + 16*i),  .data(twdl[i]));
end
fhe_exp_res[0] = 128'd1;
fhe_exp_res[1] = 128'd188;
fhe_exp_res[2] = 128'd240;
fhe_exp_res[3] = 128'd73;
fhe_exp_res[4] = 128'd55;
fhe_exp_res[5] = 128'd255;
fhe_exp_res[6] = 128'd186;
fhe_exp_res[7] = 128'd110;
fhe_exp_res[8] = 128'd53;
fhe_exp_res[9] = 128'd78;
fhe_exp_res[10] = 128'd144;
fhe_exp_res[11] = 128'd94;
fhe_exp_res[12] = 128'd148;
fhe_exp_res[13] = 128'd17;
fhe_exp_res[14] = 128'd188;
fhe_exp_res[15] = 128'd25;
fhe_exp_res[16] = 128'd73;
fhe_exp_res[17] = 128'd194;
fhe_exp_res[18] = 128'd141;
fhe_exp_res[19] = 128'd103;
fhe_exp_res[20] = 128'd115;
fhe_exp_res[21] = 128'd225;
fhe_exp_res[22] = 128'd200;
fhe_exp_res[23] = 128'd250;
fhe_exp_res[24] = 128'd255;
fhe_exp_res[25] = 128'd88;
fhe_exp_res[26] = 128'd123;
fhe_exp_res[27] = 128'd170;
fhe_exp_res[28] = 128'd56;
fhe_exp_res[29] = 128'd165;
fhe_exp_res[30] = 128'd209;
fhe_exp_res[31] = 128'd147;
fhe_exp_res[32] = 128'd38;
fhe_exp_res[33] = 128'd172;
fhe_exp_res[34] = 128'd95;
fhe_exp_res[35] = 128'd134;
fhe_exp_res[36] = 128'd62;
fhe_exp_res[37] = 128'd2;
fhe_exp_res[38] = 128'd148;
fhe_exp_res[39] = 128'd16;
fhe_exp_res[40] = 128'd234;
fhe_exp_res[41] = 128'd79;
fhe_exp_res[42] = 128'd171;
fhe_exp_res[43] = 128'd34;
fhe_exp_res[44] = 128'd111;
fhe_exp_res[45] = 128'd7;
fhe_exp_res[46] = 128'd161;
fhe_exp_res[47] = 128'd241;
fhe_exp_res[48] = 128'd170;
fhe_exp_res[49] = 128'd2;
fhe_exp_res[50] = 128'd138;
fhe_exp_res[51] = 128'd61;
fhe_exp_res[52] = 128'd234;
fhe_exp_res[53] = 128'd224;
fhe_exp_res[54] = 128'd12;
fhe_exp_res[55] = 128'd154;
fhe_exp_res[56] = 128'd142;
fhe_exp_res[57] = 128'd188;
fhe_exp_res[58] = 128'd144;
fhe_exp_res[59] = 128'd26;
fhe_exp_res[60] = 128'd47;
fhe_exp_res[61] = 128'd107;
fhe_exp_res[62] = 128'd7;
fhe_exp_res[63] = 128'd215;
fhe_exp_res[64] = 128'd158;
fhe_exp_res[65] = 128'd141;
fhe_exp_res[66] = 128'd254;
fhe_exp_res[67] = 128'd171;
fhe_exp_res[68] = 128'd120;
fhe_exp_res[69] = 128'd128;
fhe_exp_res[70] = 128'd136;
fhe_exp_res[71] = 128'd132;
fhe_exp_res[72] = 128'd230;
fhe_exp_res[73] = 128'd8;
fhe_exp_res[74] = 128'd29;
fhe_exp_res[75] = 128'd41;
fhe_exp_res[76] = 128'd247;
fhe_exp_res[77] = 128'd26;
fhe_exp_res[78] = 128'd88;
fhe_exp_res[79] = 128'd191;
fhe_exp_res[80] = 128'd10;
fhe_exp_res[81] = 128'd15;
fhe_exp_res[82] = 128'd85;
fhe_exp_res[83] = 128'd237;
fhe_exp_res[84] = 128'd140;
fhe_exp_res[85] = 128'd37;
fhe_exp_res[86] = 128'd9;
fhe_exp_res[87] = 128'd137;
fhe_exp_res[88] = 128'd64;
fhe_exp_res[89] = 128'd38;
fhe_exp_res[90] = 128'd2;
fhe_exp_res[91] = 128'd85;
fhe_exp_res[92] = 128'd58;
fhe_exp_res[93] = 128'd143;
fhe_exp_res[94] = 128'd86;
fhe_exp_res[95] = 128'd230;
fhe_exp_res[96] = 128'd117;
fhe_exp_res[97] = 128'd184;
fhe_exp_res[98] = 128'd197;
fhe_exp_res[99] = 128'd18;
fhe_exp_res[100] = 128'd125;
fhe_exp_res[101] = 128'd174;
fhe_exp_res[102] = 128'd206;
fhe_exp_res[103] = 128'd157;
fhe_exp_res[104] = 128'd223;
fhe_exp_res[105] = 128'd209;
fhe_exp_res[106] = 128'd18;
fhe_exp_res[107] = 128'd244;
fhe_exp_res[108] = 128'd62;
fhe_exp_res[109] = 128'd100;
fhe_exp_res[110] = 128'd63;
fhe_exp_res[111] = 128'd35;
fhe_exp_res[112] = 128'd244;
fhe_exp_res[113] = 128'd118;
fhe_exp_res[114] = 128'd171;
fhe_exp_res[115] = 128'd11;
fhe_exp_res[116] = 128'd213;
fhe_exp_res[117] = 128'd3;
fhe_exp_res[118] = 128'd15;
fhe_exp_res[119] = 128'd224;
fhe_exp_res[120] = 128'd94;
fhe_exp_res[121] = 128'd116;
fhe_exp_res[122] = 128'd140;
fhe_exp_res[123] = 128'd39;
fhe_exp_res[124] = 128'd111;
fhe_exp_res[125] = 128'd206;
fhe_exp_res[126] = 128'd235;
fhe_exp_res[127] = 128'd195;
uartm_write         (.addr(GPCFG_FHECTL2),       .data({FHEMEM1_BASE[31:24], FHEMEM3_BASE[31:24], FHEMEM0_DP_BASE[31:24], FHEMEM0_BASE[31:24]}));
uartm_write         (.addr(GPCFG_FHECTL_ADDR),   .data({8'h00, 8'h00, POLYDEG[15:0]}));
uartm_write         (.addr(GPCFG_FHECTL_ADDR),   .data({8'h00, 8'h40, POLYDEG[15:0]}));
uartm_write    (.addr(GPCFG_COMMNDFIFO_ADDR),  .data({8'h81, FHEMEM1_BASE[31:24], FHEMEM0_DP_BASE[31:24], FHEMEM0_BASE[31:24]}));
$display(" << INFO: Triggered NTT A");
