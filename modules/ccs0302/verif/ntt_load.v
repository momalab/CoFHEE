wire [0:127] arga [127:0];
wire [0:127] ntt_of_arga [127:0];
uartm_write_128     (.addr(GPCFG_N_ADDR[0]),        .data(128'd769)); 
arga[0] = 128'd418;
arga[1] = 128'd616;
arga[2] = 128'd325;
arga[3] = 128'd595;
arga[4] = 128'd721;
arga[5] = 128'd558;
arga[6] = 128'd358;
arga[7] = 128'd534;
arga[8] = 128'd642;
arga[9] = 128'd707;
arga[10] = 128'd727;
arga[11] = 128'd153;
arga[12] = 128'd294;
arga[13] = 128'd728;
arga[14] = 128'd393;
arga[15] = 128'd700;
arga[16] = 128'd96;
arga[17] = 128'd35;
arga[18] = 128'd167;
arga[19] = 128'd656;
arga[20] = 128'd129;
arga[21] = 128'd67;
arga[22] = 128'd286;
arga[23] = 128'd213;
arga[24] = 128'd690;
arga[25] = 128'd447;
arga[26] = 128'd84;
arga[27] = 128'd171;
arga[28] = 128'd34;
arga[29] = 128'd237;
arga[30] = 128'd80;
arga[31] = 128'd308;
arga[32] = 128'd7;
arga[33] = 128'd602;
arga[34] = 128'd688;
arga[35] = 128'd68;
arga[36] = 128'd108;
arga[37] = 128'd741;
arga[38] = 128'd608;
arga[39] = 128'd324;
arga[40] = 128'd740;
arga[41] = 128'd483;
arga[42] = 128'd717;
arga[43] = 128'd250;
arga[44] = 128'd463;
arga[45] = 128'd557;
arga[46] = 128'd1;
arga[47] = 128'd646;
arga[48] = 128'd145;
arga[49] = 128'd731;
arga[50] = 128'd78;
arga[51] = 128'd709;
arga[52] = 128'd106;
arga[53] = 128'd82;
arga[54] = 128'd434;
arga[55] = 128'd543;
arga[56] = 128'd754;
arga[57] = 128'd123;
arga[58] = 128'd79;
arga[59] = 128'd253;
arga[60] = 128'd627;
arga[61] = 128'd461;
arga[62] = 128'd354;
arga[63] = 128'd670;
arga[64] = 128'd327;
arga[65] = 128'd187;
arga[66] = 128'd464;
arga[67] = 128'd256;
arga[68] = 128'd160;
arga[69] = 128'd231;
arga[70] = 128'd455;
arga[71] = 128'd273;
arga[72] = 128'd583;
arga[73] = 128'd383;
arga[74] = 128'd90;
arga[75] = 128'd633;
arga[76] = 128'd605;
arga[77] = 128'd170;
arga[78] = 128'd516;
arga[79] = 128'd549;
arga[80] = 128'd659;
arga[81] = 128'd50;
arga[82] = 128'd531;
arga[83] = 128'd224;
arga[84] = 128'd502;
arga[85] = 128'd513;
arga[86] = 128'd606;
arga[87] = 128'd590;
arga[88] = 128'd140;
arga[89] = 128'd209;
arga[90] = 128'd275;
arga[91] = 128'd743;
arga[92] = 128'd359;
arga[93] = 128'd624;
arga[94] = 128'd125;
arga[95] = 128'd211;
arga[96] = 128'd648;
arga[97] = 128'd459;
arga[98] = 128'd179;
arga[99] = 128'd326;
arga[100] = 128'd541;
arga[101] = 128'd617;
arga[102] = 128'd225;
arga[103] = 128'd173;
arga[104] = 128'd480;
arga[105] = 128'd25;
arga[106] = 128'd360;
arga[107] = 128'd258;
arga[108] = 128'd572;
arga[109] = 128'd445;
arga[110] = 128'd691;
arga[111] = 128'd755;
arga[112] = 128'd156;
arga[113] = 128'd705;
arga[114] = 128'd291;
arga[115] = 128'd86;
arga[116] = 128'd127;
arga[117] = 128'd3;
arga[118] = 128'd44;
arga[119] = 128'd117;
arga[120] = 128'd628;
arga[121] = 128'd303;
arga[122] = 128'd689;
arga[123] = 128'd59;
arga[124] = 128'd289;
arga[125] = 128'd300;
arga[126] = 128'd468;
arga[127] = 128'd16;
for (i = 0; i < POLYDEG; i++) begin
  uartm_write_128     (.addr(FHEMEM0_BASE + 16*i),  .data(arga[i]));
end
ntt_of_arga[0] = 128'd152;
ntt_of_arga[1] = 128'd286;
ntt_of_arga[2] = 128'd417;
ntt_of_arga[3] = 128'd657;
ntt_of_arga[4] = 128'd456;
ntt_of_arga[5] = 128'd526;
ntt_of_arga[6] = 128'd652;
ntt_of_arga[7] = 128'd613;
ntt_of_arga[8] = 128'd572;
ntt_of_arga[9] = 128'd49;
ntt_of_arga[10] = 128'd540;
ntt_of_arga[11] = 128'd712;
ntt_of_arga[12] = 128'd4;
ntt_of_arga[13] = 128'd593;
ntt_of_arga[14] = 128'd254;
ntt_of_arga[15] = 128'd352;
ntt_of_arga[16] = 128'd60;
ntt_of_arga[17] = 128'd369;
ntt_of_arga[18] = 128'd207;
ntt_of_arga[19] = 128'd346;
ntt_of_arga[20] = 128'd245;
ntt_of_arga[21] = 128'd317;
ntt_of_arga[22] = 128'd171;
ntt_of_arga[23] = 128'd656;
ntt_of_arga[24] = 128'd235;
ntt_of_arga[25] = 128'd85;
ntt_of_arga[26] = 128'd330;
ntt_of_arga[27] = 128'd310;
ntt_of_arga[28] = 128'd605;
ntt_of_arga[29] = 128'd564;
ntt_of_arga[30] = 128'd474;
ntt_of_arga[31] = 128'd262;
ntt_of_arga[32] = 128'd724;
ntt_of_arga[33] = 128'd654;
ntt_of_arga[34] = 128'd121;
ntt_of_arga[35] = 128'd768;
ntt_of_arga[36] = 128'd430;
ntt_of_arga[37] = 128'd641;
ntt_of_arga[38] = 128'd656;
ntt_of_arga[39] = 128'd224;
ntt_of_arga[40] = 128'd644;
ntt_of_arga[41] = 128'd478;
ntt_of_arga[42] = 128'd266;
ntt_of_arga[43] = 128'd419;
ntt_of_arga[44] = 128'd66;
ntt_of_arga[45] = 128'd159;
ntt_of_arga[46] = 128'd598;
ntt_of_arga[47] = 128'd395;
ntt_of_arga[48] = 128'd660;
ntt_of_arga[49] = 128'd338;
ntt_of_arga[50] = 128'd527;
ntt_of_arga[51] = 128'd146;
ntt_of_arga[52] = 128'd465;
ntt_of_arga[53] = 128'd671;
ntt_of_arga[54] = 128'd323;
ntt_of_arga[55] = 128'd765;
ntt_of_arga[56] = 128'd186;
ntt_of_arga[57] = 128'd471;
ntt_of_arga[58] = 128'd677;
ntt_of_arga[59] = 128'd666;
ntt_of_arga[60] = 128'd593;
ntt_of_arga[61] = 128'd84;
ntt_of_arga[62] = 128'd759;
ntt_of_arga[63] = 128'd410;
ntt_of_arga[64] = 128'd446;
ntt_of_arga[65] = 128'd609;
ntt_of_arga[66] = 128'd115;
ntt_of_arga[67] = 128'd321;
ntt_of_arga[68] = 128'd369;
ntt_of_arga[69] = 128'd44;
ntt_of_arga[70] = 128'd687;
ntt_of_arga[71] = 128'd417;
ntt_of_arga[72] = 128'd158;
ntt_of_arga[73] = 128'd438;
ntt_of_arga[74] = 128'd314;
ntt_of_arga[75] = 128'd402;
ntt_of_arga[76] = 128'd587;
ntt_of_arga[77] = 128'd297;
ntt_of_arga[78] = 128'd618;
ntt_of_arga[79] = 128'd298;
ntt_of_arga[80] = 128'd681;
ntt_of_arga[81] = 128'd648;
ntt_of_arga[82] = 128'd446;
ntt_of_arga[83] = 128'd508;
ntt_of_arga[84] = 128'd256;
ntt_of_arga[85] = 128'd69;
ntt_of_arga[86] = 128'd646;
ntt_of_arga[87] = 128'd291;
ntt_of_arga[88] = 128'd118;
ntt_of_arga[89] = 128'd201;
ntt_of_arga[90] = 128'd490;
ntt_of_arga[91] = 128'd488;
ntt_of_arga[92] = 128'd617;
ntt_of_arga[93] = 128'd318;
ntt_of_arga[94] = 128'd306;
ntt_of_arga[95] = 128'd510;
ntt_of_arga[96] = 128'd462;
ntt_of_arga[97] = 128'd449;
ntt_of_arga[98] = 128'd227;
ntt_of_arga[99] = 128'd660;
ntt_of_arga[100] = 128'd221;
ntt_of_arga[101] = 128'd312;
ntt_of_arga[102] = 128'd302;
ntt_of_arga[103] = 128'd665;
ntt_of_arga[104] = 128'd742;
ntt_of_arga[105] = 128'd417;
ntt_of_arga[106] = 128'd701;
ntt_of_arga[107] = 128'd191;
ntt_of_arga[108] = 128'd112;
ntt_of_arga[109] = 128'd556;
ntt_of_arga[110] = 128'd244;
ntt_of_arga[111] = 128'd219;
ntt_of_arga[112] = 128'd658;
ntt_of_arga[113] = 128'd766;
ntt_of_arga[114] = 128'd545;
ntt_of_arga[115] = 128'd588;
ntt_of_arga[116] = 128'd528;
ntt_of_arga[117] = 128'd745;
ntt_of_arga[118] = 128'd721;
ntt_of_arga[119] = 128'd435;
ntt_of_arga[120] = 128'd500;
ntt_of_arga[121] = 128'd556;
ntt_of_arga[122] = 128'd634;
ntt_of_arga[123] = 128'd595;
ntt_of_arga[124] = 128'd719;
ntt_of_arga[125] = 128'd381;
ntt_of_arga[126] = 128'd447;
ntt_of_arga[127] = 128'd745;
uartm_write         (.addr(GPCFG_FHECTLP_ADDR),  .data(32'b1));
