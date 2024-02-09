
//Version 1
//Intel Unlock : Negative

uartm_write    (.addr(INTLV2_METKEYDIS_ADDR),     .data(32'h1));
uartm_write    (.addr(INTLV2_OSATDIS_ADDR),       .data(32'h1));
temp2_reg[127 :0]     = 128'h0123_4567_89AB_CDEF_0123_4567_89AB_CDEF;                                          //Red Key
temp4_reg             = 256'h223E_0A16_0AF9_DA0A_03E6_DD2C_4719_C56F_5D66_A633_CBE8_4E78_AAA9_F373_5865_522A;  //HAsh digest of Red Key

uartm_write    (.addr(INTLV2_RKEYHASH_ADDR0),        .data(temp4_reg[31:0]));
uartm_write    (.addr(INTLV2_RKEYHASH_ADDR1),        .data(temp4_reg[63:32]));
uartm_write    (.addr(INTLV2_RKEYHASH_ADDR2),        .data(temp4_reg[95:64]));
uartm_write    (.addr(INTLV2_RKEYHASH_ADDR3),        .data(temp4_reg[127:96]));
uartm_write    (.addr(INTLV2_RKEYHASH_ADDR4),        .data(temp4_reg[159:128]));
uartm_write    (.addr(INTLV2_RKEYHASH_ADDR5),        .data(temp4_reg[191:160]));
uartm_write    (.addr(INTLV2_RKEYHASH_ADDR6),        .data(temp4_reg[223:192]));
uartm_write    (.addr(INTLV2_RKEYHASH_ADDR7),        .data(temp4_reg[255:224]));


uartm_write    (.addr(INTLV2_RKEY_ADDR0),            .data(~temp2_reg[127:96]));
uartm_write    (.addr(INTLV2_RKEY_ADDR1),            .data(~temp2_reg[95:64]));
uartm_write    (.addr(INTLV2_RKEY_ADDR2),            .data(~temp2_reg[31:0]));
uartm_write    (.addr(INTLV2_RKEY_ADDR3),            .data(~temp2_reg[127:96]));

uartm_write    (.addr(INTLV2_CHECK_TRIG),            .data(32'h2));

//uartm_write    (.addr(SRAM_BASE + 32'h4),            .data(32'h0123_4567));
uartm_read     (.addr(SRAM_BASE + 32'h4),            .data(rx_reg));
uartm_write    (.addr(GPCFG_GPTA_CFG),               .data(32'h89AB_CDEF));
uartm_write    (.addr(GPIO_GPIO0_CTL),               .data(32'hABCD_1234));

//Version 1
//Intel Unlock : Positive
$display($time, "----------------------------------------------------------------------");
$display($time, " << Number of Clocks value Before uart transaction  %d", ccs0201_tb.no_of_clocks);
uartm_write    (.addr(INTLV2_RKEY_ADDR0),            .data(temp2_reg[31:0]));
uartm_write    (.addr(INTLV2_RKEY_ADDR1),            .data(temp2_reg[63:32]));
uartm_write    (.addr(INTLV2_RKEY_ADDR2),            .data(temp2_reg[95:64]));
uartm_write    (.addr(INTLV2_RKEY_ADDR3),            .data(temp2_reg[127:96]));

uartm_write    (.addr(INTLV2_CHECK_TRIG),            .data(32'h2));
$display($time, " << Number of Clocks value After  uart transaction  %d", ccs0201_tb.no_of_clocks);
@(posedge unlock);
$display($time, " << Number of Clocks value After  unlock goes high  %d", ccs0201_tb.no_of_clocks);
$display($time, "----------------------------------------------------------------------");

//uartm_write    (.addr(SRAM_BASE),                  .data(32'h0123_4567));
//uartm_write    (.addr(SRAM_BASE + 32'h4),            .data(32'h0123_4567));
uartm_write    (.addr(GPCFG_GPTA_CFG),               .data(32'h89AB_CDEF));
uartm_write    (.addr(GPIO_GPIO0_CTL),               .data(32'hABCD_1234));
uartm_read     (.addr(SRAM_BASE + 32'h4),            .data(rx_reg));



uartm_read     (.addr(INTLV0_RKEY_ADDR0),            .data(uartm_rx_tb_data[31:0]));
uartm_read     (.addr(INTLV0_RKEY_ADDR1),            .data(uartm_rx_tb_data[63:32]));
uartm_read     (.addr(INTLV0_RKEY_ADDR2),            .data(uartm_rx_tb_data[95:64]));
uartm_read     (.addr(INTLV0_RKEY_ADDR3),            .data(uartm_rx_tb_data[127:96]));

$display($time, "----------------------------------------------------------------------");
$display($time, " << RkEY VALUE            %h", ccs0201_tb.uartm_rx_tb_data[127:0]);
$display($time, " << RkEY VALUE            %d", ccs0201_tb.uartm_rx_tb_data[127:0]);
$display($time, "----------------------------------------------------------------------");

$finish; 
