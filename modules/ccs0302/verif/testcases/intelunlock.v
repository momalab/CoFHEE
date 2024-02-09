//Version 0
//Foundry Unlock : Positive
uartm_write    (.addr(INTLV0_CHECK_TRIG),            .data(32'h1));

uartm_write    (.addr(INTLV0_RKEY_ADDR0),            .data(obf_metkey[31:0]));
uartm_write    (.addr(INTLV0_RKEY_ADDR1),            .data(obf_metkey[63:32]));
uartm_write    (.addr(INTLV0_RKEY_ADDR2),            .data(obf_metkey[95:64]));
uartm_write    (.addr(INTLV0_RKEY_ADDR3),            .data(obf_metkey[127:96]));
uartm_write    (.addr(INTLV0_CHECK_TRIG),            .data(32'h2));

uartm_read     (.addr(INTLV0_RKEY_ADDR0),            .data(uartm_rx_tb_data[31:0]));
uartm_read     (.addr(INTLV0_RKEY_ADDR1),            .data(uartm_rx_tb_data[63:32]));
uartm_read     (.addr(INTLV0_RKEY_ADDR2),            .data(uartm_rx_tb_data[95:64]));
uartm_read     (.addr(INTLV0_RKEY_ADDR3),            .data(uartm_rx_tb_data[127:96]));

$display($time, "----------------------------------------------------------------------");
$display($time, " << RkEY VALUE            %h", ccs0201_tb.uartm_rx_tb_data[127:0]);
$display($time, " << RkEY VALUE            %d", ccs0201_tb.uartm_rx_tb_data[127:0]);
$display($time, "----------------------------------------------------------------------");
//$finish; 
