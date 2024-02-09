uartm_read          (.addr(32'h400200CC),  .data(rx_reg));

uartm_write_128     (.addr(SRAM_BASE),     .data(rx_reg));
uartm_read_128      (.addr(SRAM_BASE));

for (i = 0; i < POLYDEG; i++) begin
  uartm_write_128     (.addr(FHEMEM0_BASE + 16*i),  .data(arga));
end
uartm_read_128      (.addr(FHEMEM0_BASE + 16*i));

uartm_write_128     (.addr(FHEMEM1_BASE),  .data(argb));
uartm_read_128      (.addr(FHEMEM1_BASE));

for (i = 0; i < POLYDEG; i++) begin
   uartm_write_128     (.addr(FHEMEM2_BASE + 16*i),  .data(arga));
end
uartm_read_128      (.addr(FHEMEM2_BASE + 16*i));

uartm_write_128     (.addr(FHEMEM3_BASE),  .data(rand0));
uartm_read_128      (.addr(FHEMEM3_BASE));

uartm_write_128     (.addr(FHEMEM4_BASE),  .data(rand1));
uartm_read_128      (.addr(FHEMEM4_BASE));

uartm_write_128     (.addr(FHEMEM5_BASE),  .data(rand0));
uartm_read_128      (.addr(FHEMEM5_BASE));

uartm_write_128     (.addr(FHEMEM6_BASE),  .data(rand1));
uartm_read_128      (.addr(FHEMEM6_BASE));

uartm_write_128     (.addr(GPCFG_N_ADDR[0]),        .data(mod));
uartm_write         (.addr(GPCFG_FHECTLP_ADDR),  .data(32'b1));

