
uartm_read     (.addr(32'h400200CC),  .data(rx_reg));

arga     = 2048'd3514503331;
argb     = 2048'd223210267;
nsq      = 2048'd29033679900681;
fkf      = 2048'd2242399243;
rand0    = 1024'd4996250;
rand1    = 1024'd4984945;
log2ofn  = 12'd23;
log2ofn2 = 12'd45;


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
uartm_modmul (.arga (2048'd3514503331),.argb (2048'd223210267));
