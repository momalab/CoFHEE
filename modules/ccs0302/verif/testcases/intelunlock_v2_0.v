

//Version 1
//Foundry/OSAT Unlock : Negative
uartm_write    (.addr(INTLV2_RKEY_ADDR0),            .data(32'h0));
uartm_write    (.addr(INTLV2_RKEY_ADDR1),            .data(METKEY[63:32]));
uartm_write    (.addr(INTLV2_RKEY_ADDR2),            .data(METKEY[95:64]));
uartm_write    (.addr(INTLV2_RKEY_ADDR3),            .data(METKEY[127:96]));

uartm_write    (.addr(INTLV2_CHECK_TRIG),            .data(32'h2));

uartm_write    (.addr(SRAM_BASE),                    .data(32'h0123_4567));
uartm_write    (.addr(GPCFG_GPTA_CFG),               .data(32'h89AB_CDEF));
uartm_write    (.addr(GPIO_GPIO0_CTL),               .data(32'hABCD_1234));

//Version 1
//Foundry/OSAT Unlock : Positive
$display($time, "----------------------------------------------------------------------");
$display($time, " << Number of Clocks value Before uart transaction  %d", ccs0201_tb.no_of_clocks);
uartm_write    (.addr(INTLV2_RKEY_ADDR0),            .data(METKEY[31:0]));
uartm_write    (.addr(INTLV2_RKEY_ADDR1),            .data(METKEY[63:32]));
uartm_write    (.addr(INTLV2_RKEY_ADDR2),            .data(METKEY[95:64]));
uartm_write    (.addr(INTLV2_RKEY_ADDR3),            .data(METKEY[127:96]));

uartm_write    (.addr(INTLV2_CHECK_TRIG),            .data(32'h2));
$display($time, " << Number of Clocks value After  uart transaction  %d", ccs0201_tb.no_of_clocks);
@(posedge unlock);
$display($time, " << Number of Clocks value After  unlock goes high  %d", ccs0201_tb.no_of_clocks);
$display($time, "----------------------------------------------------------------------");

uartm_write    (.addr(SRAM_BASE),                    .data(32'h0123_4567));
uartm_write    (.addr(GPCFG_GPTA_CFG),               .data(32'h89AB_CDEF));
uartm_write    (.addr(GPIO_GPIO0_CTL),               .data(32'hABCD_1234));
uartm_read     (.addr(SRAM_BASE),                    .data(rx_reg));



uartm_read     (.addr(INTLV0_RKEY_ADDR0),            .data(uartm_rx_tb_data[31:0]));
uartm_read     (.addr(INTLV0_RKEY_ADDR1),            .data(uartm_rx_tb_data[63:32]));
uartm_read     (.addr(INTLV0_RKEY_ADDR2),            .data(uartm_rx_tb_data[95:64]));
uartm_read     (.addr(INTLV0_RKEY_ADDR3),            .data(uartm_rx_tb_data[127:96]));

$display($time, "----------------------------------------------------------------------");
$display($time, " << RkEY VALUE            %h", ccs0201_tb.uartm_rx_tb_data[127:0]);
$display($time, " << RkEY VALUE            %d", ccs0201_tb.uartm_rx_tb_data[127:0]);
$display($time, "----------------------------------------------------------------------");

$finish; 
