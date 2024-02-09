uartm_write (.addr(GPCFG_KEY_REG0),     .data (32'b11111111010011000000000000001011));
uartm_write (.addr(GPCFG_KEY_REG1),     .data (32'b00000111000000000000000000011110));
uartm_write (.addr(GPCFG_KEY_REG2),     .data (32'b00100000010000001000000000000001));
uartm_write (.addr(GPCFG_KEY_REG3),     .data (32'b11111111111111111111110000100000));

uartm_write (.addr(GPCFG_KEY_REG4),     .data (32'b11001101000101100111101110001100));
uartm_write (.addr(GPCFG_KEY_REG5),     .data (32'b11011011110000100100101101000010));
uartm_write (.addr(GPCFG_KEY_REG6),     .data (32'b10000111001100110001101100001110));
uartm_write (.addr(GPCFG_KEY_REG7),     .data (32'b10011100101010101100111010100011));

temp1_reg[31:0]   = 32'b11111111010011000000000000001011;
temp1_reg[63:32]  = 32'b00000111000000000000000000011110;
temp1_reg[95:64]  = 32'b00100000010000001000000000000001;
temp1_reg[127:96] = 32'b11111111111111111111110000100000;

temp2_reg[31:0]   = 32'b11001101000101100111101110001100;
temp2_reg[63:32]  = 32'b11011011110000100100101101000010;
temp2_reg[95:64]  = 32'b10000111001100110001101100001110;
temp2_reg[127:96] = 32'b10011100101010101100111010100011;


$display($time, "----------------------------------------------------------------------");
$display($time, " << SFLL KEY VALUE            %h", ccs0201_tb.temp1_reg[127:0]);
$display($time, " << FLL  KEY VALUE            %h", ccs0201_tb.temp2_reg[127:0]);
$display($time, "----------------------------------------------------------------------");
$display($time, " << SFLL KEY VALUE            %d", ccs0201_tb.temp1_reg[127:0]);
$display($time, " << FLL  KEY VALUE            %d", ccs0201_tb.temp2_reg[127:0]);
$display($time, "----------------------------------------------------------------------");
$finish; 
