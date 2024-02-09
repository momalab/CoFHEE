uartm_write    (.addr(GPCFG_SPICLK_PAD_CTL),       .data(32'h0003_0016));
uartm_write    (.addr(GPCFG_SPICSN_PAD_CTL),       .data(32'h0003_0016));
uartm_write    (.addr(GPCFG_HOSTIRQ_PAD_CTL),      .data(32'h0003_0016));

uartm_write    (.addr(GPCFG_AESKEYIN3),            .data(32'h1215_3524));
uartm_write    (.addr(GPCFG_AESKEYIN2),            .data(32'hC089_5E81));
uartm_write    (.addr(GPCFG_AESKEYIN1),            .data(32'h8484_D609));
uartm_write    (.addr(GPCFG_AESKEYIN0),            .data(32'hB1F0_5663));

uartm_write    (.addr(GPCFG_AESDATIN3),            .data(32'h06B9_7B0D));
uartm_write    (.addr(GPCFG_AESDATIN2),            .data(32'h46DF_998D));
uartm_write    (.addr(GPCFG_AESDATIN1),            .data(32'hB2C2_8465));
uartm_write    (.addr(GPCFG_AESDATIN0),            .data(32'h8937_5212));

uartm_write    (.addr(GPCFG_AESCTL_P),             .data(32'h0002_0101));
uartm_write    (.addr(GPCFG_AESCTL_P),             .data(32'h0001_0000));


uartm_read    (.addr(GPCFG_AESDATOUT0), .data(rx_reg));
uartm_read    (.addr(GPCFG_AESDATOUT1), .data(rx_reg));
uartm_read    (.addr(GPCFG_AESDATOUT2), .data(rx_reg));
uartm_read    (.addr(GPCFG_AESDATOUT3), .data(rx_reg));

uartm_read    (.addr(GPCFG_AESKEYOUT0), .data(rx_reg));
uartm_read    (.addr(GPCFG_AESKEYOUT1), .data(rx_reg));
uartm_read    (.addr(GPCFG_AESKEYOUT2), .data(rx_reg));
uartm_read    (.addr(GPCFG_AESKEYOUT3), .data(rx_reg));

uartm_write    (.addr(GPCFG_AESCTL),               .data(32'h1010_1010));
uartm_write    (.addr(GPCFG_AESCTL_P),             .data(32'h0002_0101));
uartm_write    (.addr(GPCFG_AESCTL_P),             .data(32'h0001_0000));


