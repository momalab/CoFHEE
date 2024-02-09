  uartm_write (.addr(GPCFG_FIXROEN),     .data (32'h01010101));
  uartm_write (.addr(GPCFG_VARROEN),     .data (32'h01010101));
  uartm_write (.addr(GPCFG_RO1DIV ),     .data (32'h00020001));
  uartm_write (.addr(GPCFG_RO2DIV ),     .data (32'h00040003));
  uartm_write (.addr(GPCFG_RO3DIV ),     .data (32'h00060005));
  uartm_write (.addr(GPCFG_RO4DIV ),     .data (32'h00080007));

  uartm_write (.addr(GPCFG_PAD11_PAD_CTL ),     .data (32'h10_001A));
  uartm_write (.addr(GPCFG_PAD12_PAD_CTL ),     .data (32'h10_001A));
  uartm_write (.addr(GPCFG_PAD13_PAD_CTL ),     .data (32'h10_001A));
  uartm_write (.addr(GPCFG_PAD14_PAD_CTL ),     .data (32'h10_001A));
  uartm_write (.addr(GPCFG_PAD15_PAD_CTL ),     .data (32'h10_001A));
  uartm_write (.addr(GPCFG_PAD16_PAD_CTL ),     .data (32'h10_001A));
  uartm_write (.addr(GPCFG_PAD17_PAD_CTL ),     .data (32'h10_001A));
  uartm_write (.addr(GPCFG_PAD18_PAD_CTL ),     .data (32'h10_001A));
  uartm_write (.addr(GPCFG_PAD19_PAD_CTL ),     .data (32'h10_001A));
