
uartm_read     (.addr(32'h400200CC),  .data(rx_reg));

cleq_init (.n (N), .nsq (nsq), .fkf (fkf), .rand0 (rand0), .rand1 (rand1), .log2ofn(log2ofn), .maxbits (log2ofn2), .nsq_modulus (1'b1), .hw_rand (1'b0), .bypvn (1'b1));
  $display($time, " << ARGA               %d", arga);
  $display($time, " << ARGB               %d", argb);
  $display($time, " << NSQ                %d", nsq);
  $display($time, " << FKF                %d", fkf);
  $display($time, " << RAND0              %d", rand0);
  $display($time, " << RAND1              %d", rand1);
  $display($time, " << LOG2ofN            %d", log2ofn);
  $display($time, " << LOG2ofNSQ          %d", log2ofn2);
  $display($time, " << R_for_EGCD         %d", r_for_egcd);
  $display($time, " << R_RED_FOR_EGCD     %d", r_red_for_egcd);
uartm_modinv (.arga (arga + 1'b1),.argb (nsq));
uartm_modmul (.arga (arga),.argb (argb));
uartm_modexp (.arga (arga),.argb (argb));
