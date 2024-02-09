task uartm_data_shift (input [7:0] data);
  begin
    tx_reg <= {1'b1, data, 1'b0, 1'b1};
    repeat(11) begin
      @(posedge UART_CLK);
      tx_reg <= {1'b1, tx_reg[9:1]};
    end
  end
endtask

task uartm_rx_data_capture (output [7:0] data);
  begin
    //rx_reg <= 8'b0;
    @(negedge uartm_rx_data);
    //@(negedge UART_CLK && ~uartm_rx_data);
    #(UART_BAUD/2);
    //@(negedge UART_CLK);
    repeat(8) begin
      #UART_BAUD;
      //@(negedge UART_CLK);
      rx_reg = {uartm_rx_data, rx_reg[7:1]};
    end
    //@(posedge UART_CLK);
    data = rx_reg;
  end
endtask



task uartm_write (input integer data,input integer addr);
  begin
    //Pass write pnemonic
    uartm_data_shift(8'h34);
    uartm_data_shift(8'h34);
    uartm_data_shift(8'h34);
    uartm_data_shift(8'h34);

    //Pass write Adddress
    uartm_data_shift(addr[7:0]);
    uartm_data_shift(addr[15:8]);
    uartm_data_shift(addr[23:16]);
    uartm_data_shift(addr[31:24]);

    //Pass write Data
    uartm_data_shift(data[7:0]);
    uartm_data_shift(data[15:8]);
    uartm_data_shift(data[23:16]);
    uartm_data_shift(data[31:24]);
  end
endtask

task uartm_write_128 (input [127:0] data, input integer addr);
  begin
    uartm_write (.addr(addr + 16'h0),    .data(data[31:0]));
    uartm_write (.addr(addr + 16'h4),    .data(data[63:32]));
    uartm_write (.addr(addr + 16'h8),    .data(data[95:64]));
    uartm_write (.addr(addr + 16'hc),    .data(data[127:96]));
  end
endtask


task uartm_write_256 (input [255:0] data, input integer addr);
  begin
    uartm_write (.addr(addr + 16'h0),    .data(data[31:0]));
    uartm_write (.addr(addr + 16'h4),    .data(data[63:32]));
    uartm_write (.addr(addr + 16'h8),    .data(data[95:64]));
    uartm_write (.addr(addr + 16'hc),    .data(data[127:96]));
    uartm_write (.addr(addr + 16'h10),   .data(data[159:128]));
    uartm_write (.addr(addr + 16'h14),   .data(data[191:160]));
    uartm_write (.addr(addr + 16'h18),   .data(data[223:192]));
    uartm_write (.addr(addr + 16'h1c),   .data(data[255:224]));
  end
endtask



task uartm_write_2k (input [2047:0] data, input integer addr);
  begin
    uartm_write (.addr(addr + 16'h0),    .data(data[31:0]));
    uartm_write (.addr(addr + 16'h4),    .data(data[63:32]));
    uartm_write (.addr(addr + 16'h8),    .data(data[95:64]));
    uartm_write (.addr(addr + 16'hc),    .data(data[127:96]));
    uartm_write (.addr(addr + 16'h10),   .data(data[159:128]));
    uartm_write (.addr(addr + 16'h14),   .data(data[191:160]));
    uartm_write (.addr(addr + 16'h18),   .data(data[223:192]));
    uartm_write (.addr(addr + 16'h1c),   .data(data[255:224]));
    uartm_write (.addr(addr + 16'h20),   .data(data[287:256]));
    uartm_write (.addr(addr + 16'h24),   .data(data[319:288]));
    uartm_write (.addr(addr + 16'h28),   .data(data[351:320]));
    uartm_write (.addr(addr + 16'h2c),   .data(data[383:352]));
    uartm_write (.addr(addr + 16'h30),   .data(data[415:384]));
    uartm_write (.addr(addr + 16'h34),   .data(data[447:416]));
    uartm_write (.addr(addr + 16'h38),   .data(data[479:448]));
    uartm_write (.addr(addr + 16'h3c),   .data(data[511:480]));
    uartm_write (.addr(addr + 16'h40),   .data(data[543:512]));
    uartm_write (.addr(addr + 16'h44),   .data(data[575:544]));
    uartm_write (.addr(addr + 16'h48),   .data(data[607:576]));
    uartm_write (.addr(addr + 16'h4c),   .data(data[639:608]));
    uartm_write (.addr(addr + 16'h50),   .data(data[671:640]));
    uartm_write (.addr(addr + 16'h54),   .data(data[703:672]));
    uartm_write (.addr(addr + 16'h58),   .data(data[735:704]));
    uartm_write (.addr(addr + 16'h5c),   .data(data[767:736]));
    uartm_write (.addr(addr + 16'h60),   .data(data[799:768]));
    uartm_write (.addr(addr + 16'h64),   .data(data[831:800]));
    uartm_write (.addr(addr + 16'h68),   .data(data[863:832]));
    uartm_write (.addr(addr + 16'h6c),   .data(data[895:864]));
    uartm_write (.addr(addr + 16'h70),   .data(data[927:896]));
    uartm_write (.addr(addr + 16'h74),   .data(data[959:928]));
    uartm_write (.addr(addr + 16'h78),   .data(data[991:960]));
    uartm_write (.addr(addr + 16'h7c),   .data(data[1023:992]));
    uartm_write (.addr(addr + 16'h80),   .data(data[1055:1024]));
    uartm_write (.addr(addr + 16'h84),   .data(data[1087:1056]));
    uartm_write (.addr(addr + 16'h88),   .data(data[1119:1088]));
    uartm_write (.addr(addr + 16'h8c),   .data(data[1151:1120]));
    uartm_write (.addr(addr + 16'h90),   .data(data[1183:1152]));
    uartm_write (.addr(addr + 16'h94),   .data(data[1215:1184]));
    uartm_write (.addr(addr + 16'h98),   .data(data[1247:1216]));
    uartm_write (.addr(addr + 16'h9c),   .data(data[1279:1248]));
    uartm_write (.addr(addr + 16'ha0),   .data(data[1311:1280]));
    uartm_write (.addr(addr + 16'ha4),   .data(data[1343:1312]));
    uartm_write (.addr(addr + 16'ha8),   .data(data[1375:1344]));
    uartm_write (.addr(addr + 16'hac),   .data(data[1407:1376]));
    uartm_write (.addr(addr + 16'hb0),   .data(data[1439:1408]));
    uartm_write (.addr(addr + 16'hb4),   .data(data[1471:1440]));
    uartm_write (.addr(addr + 16'hb8),   .data(data[1503:1472]));
    uartm_write (.addr(addr + 16'hbc),   .data(data[1535:1504]));
    uartm_write (.addr(addr + 16'hc0),   .data(data[1567:1536]));
    uartm_write (.addr(addr + 16'hc4),   .data(data[1599:1568]));
    uartm_write (.addr(addr + 16'hc8),   .data(data[1631:1600]));
    uartm_write (.addr(addr + 16'hcc),   .data(data[1663:1632]));
    uartm_write (.addr(addr + 16'hd0),   .data(data[1695:1664]));
    uartm_write (.addr(addr + 16'hd4),   .data(data[1727:1696]));
    uartm_write (.addr(addr + 16'hd8),   .data(data[1759:1728]));
    uartm_write (.addr(addr + 16'hdc),   .data(data[1791:1760]));
    uartm_write (.addr(addr + 16'he0),   .data(data[1823:1792]));
    uartm_write (.addr(addr + 16'he4),   .data(data[1855:1824]));
    uartm_write (.addr(addr + 16'he8),   .data(data[1887:1856]));
    uartm_write (.addr(addr + 16'hec),   .data(data[1919:1888]));
    uartm_write (.addr(addr + 16'hf0),   .data(data[1951:1920]));
    uartm_write (.addr(addr + 16'hf4),   .data(data[1983:1952]));
    uartm_write (.addr(addr + 16'hf8),   .data(data[2015:1984]));
    uartm_write (.addr(addr + 16'hfc),   .data(data[2047:2016]));
  end
endtask


task uartm_write_1k (input [1023:0] data, input integer addr);
  begin
    uartm_write (.addr(addr + 16'h0),    .data(data[31:0]));
    uartm_write (.addr(addr + 16'h4),    .data(data[63:32]));
    uartm_write (.addr(addr + 16'h8),    .data(data[95:64]));
    uartm_write (.addr(addr + 16'hc),    .data(data[127:96]));
    uartm_write (.addr(addr + 16'h10),   .data(data[159:128]));
    uartm_write (.addr(addr + 16'h14),   .data(data[191:160]));
    uartm_write (.addr(addr + 16'h18),   .data(data[223:192]));
    uartm_write (.addr(addr + 16'h1c),   .data(data[255:224]));
    uartm_write (.addr(addr + 16'h20),   .data(data[287:256]));
    uartm_write (.addr(addr + 16'h24),   .data(data[319:288]));
    uartm_write (.addr(addr + 16'h28),   .data(data[351:320]));
    uartm_write (.addr(addr + 16'h2c),   .data(data[383:352]));
    uartm_write (.addr(addr + 16'h30),   .data(data[415:384]));
    uartm_write (.addr(addr + 16'h34),   .data(data[447:416]));
    uartm_write (.addr(addr + 16'h38),   .data(data[479:448]));
    uartm_write (.addr(addr + 16'h3c),   .data(data[511:480]));
    uartm_write (.addr(addr + 16'h40),   .data(data[543:512]));
    uartm_write (.addr(addr + 16'h44),   .data(data[575:544]));
    uartm_write (.addr(addr + 16'h48),   .data(data[607:576]));
    uartm_write (.addr(addr + 16'h4c),   .data(data[639:608]));
    uartm_write (.addr(addr + 16'h50),   .data(data[671:640]));
    uartm_write (.addr(addr + 16'h54),   .data(data[703:672]));
    uartm_write (.addr(addr + 16'h58),   .data(data[735:704]));
    uartm_write (.addr(addr + 16'h5c),   .data(data[767:736]));
    uartm_write (.addr(addr + 16'h60),   .data(data[799:768]));
    uartm_write (.addr(addr + 16'h64),   .data(data[831:800]));
    uartm_write (.addr(addr + 16'h68),   .data(data[863:832]));
    uartm_write (.addr(addr + 16'h6c),   .data(data[895:864]));
    uartm_write (.addr(addr + 16'h70),   .data(data[927:896]));
    uartm_write (.addr(addr + 16'h74),   .data(data[959:928]));
    uartm_write (.addr(addr + 16'h78),   .data(data[991:960]));
    uartm_write (.addr(addr + 16'h7c),   .data(data[1023:992]));
  end
endtask




task uartm_read (input integer addr, output integer data);
  begin
    fork
      begin
        //Pass write pnemonic
        uartm_data_shift(8'h4D);
        uartm_data_shift(8'h4D);
        uartm_data_shift(8'h4D);
        uartm_data_shift(8'h4D);
        //Pass write Adddress
        uartm_data_shift(addr[7:0]);
        uartm_data_shift(addr[15:8]);
        uartm_data_shift(addr[23:16]);
        uartm_data_shift(addr[31:24]);
      end
      begin
        //Sample RXdata
        uartm_rx_data_capture(.data (data[7:0]));
        uartm_rx_data_capture(.data (data[15:8]));
        uartm_rx_data_capture(.data (data[23:16]));
        uartm_rx_data_capture(.data (data[31:24]));
      end
    join
  end
endtask


task uartm_read_128 (input integer addr);
  begin
    uartm_read (.addr (addr + 16'h00), .data(uartm_rx_tb_data[31:0]));
    uartm_read (.addr (addr + 16'h04), .data(uartm_rx_tb_data[63:32]));
    uartm_read (.addr (addr + 16'h08), .data(uartm_rx_tb_data[95:64]));
    uartm_read (.addr (addr + 16'h0c), .data(uartm_rx_tb_data[127:96]));
  end
endtask

task uartm_read_256 (input integer addr);
  begin
    uartm_read (.addr (addr + 16'h00), .data(uartm_rx_tb_data[31:0]));
    uartm_read (.addr (addr + 16'h04), .data(uartm_rx_tb_data[63:32]));
    uartm_read (.addr (addr + 16'h08), .data(uartm_rx_tb_data[95:64]));
    uartm_read (.addr (addr + 16'h0c), .data(uartm_rx_tb_data[127:96]));
    uartm_read (.addr (addr + 16'h10), .data(uartm_rx_tb_data[159:128]));
    uartm_read (.addr (addr + 16'h14), .data(uartm_rx_tb_data[191:160]));
    uartm_read (.addr (addr + 16'h18), .data(uartm_rx_tb_data[223:192]));
    uartm_read (.addr (addr + 16'h1c), .data(uartm_rx_tb_data[255:224]));
  end
endtask

task uartm_read_2k (input integer addr);
  begin
    uartm_read (.addr (addr + 16'h00), .data(uartm_rx_tb_data[31:0]));
    uartm_read (.addr (addr + 16'h04), .data(uartm_rx_tb_data[63:32]));
    uartm_read (.addr (addr + 16'h08), .data(uartm_rx_tb_data[95:64]));
    uartm_read (.addr (addr + 16'h0c), .data(uartm_rx_tb_data[127:96]));
    uartm_read (.addr (addr + 16'h10), .data(uartm_rx_tb_data[159:128]));
    uartm_read (.addr (addr + 16'h14), .data(uartm_rx_tb_data[191:160]));
    uartm_read (.addr (addr + 16'h18), .data(uartm_rx_tb_data[223:192]));
    uartm_read (.addr (addr + 16'h1c), .data(uartm_rx_tb_data[255:224]));
    uartm_read (.addr (addr + 16'h20), .data(uartm_rx_tb_data[287:256]));
    uartm_read (.addr (addr + 16'h24), .data(uartm_rx_tb_data[319:288]));
    uartm_read (.addr (addr + 16'h28), .data(uartm_rx_tb_data[351:320]));
    uartm_read (.addr (addr + 16'h2c), .data(uartm_rx_tb_data[383:352]));
    uartm_read (.addr (addr + 16'h30), .data(uartm_rx_tb_data[415:384]));
    uartm_read (.addr (addr + 16'h34), .data(uartm_rx_tb_data[447:416]));
    uartm_read (.addr (addr + 16'h38), .data(uartm_rx_tb_data[479:448]));
    uartm_read (.addr (addr + 16'h3c), .data(uartm_rx_tb_data[511:480]));
    uartm_read (.addr (addr + 16'h40), .data(uartm_rx_tb_data[543:512]));
    uartm_read (.addr (addr + 16'h44), .data(uartm_rx_tb_data[575:544]));
    uartm_read (.addr (addr + 16'h48), .data(uartm_rx_tb_data[607:576]));
    uartm_read (.addr (addr + 16'h4c), .data(uartm_rx_tb_data[639:608]));
    uartm_read (.addr (addr + 16'h50), .data(uartm_rx_tb_data[671:640]));
    uartm_read (.addr (addr + 16'h54), .data(uartm_rx_tb_data[703:672]));
    uartm_read (.addr (addr + 16'h58), .data(uartm_rx_tb_data[735:704]));
    uartm_read (.addr (addr + 16'h5c), .data(uartm_rx_tb_data[767:736]));
    uartm_read (.addr (addr + 16'h60), .data(uartm_rx_tb_data[799:768]));
    uartm_read (.addr (addr + 16'h64), .data(uartm_rx_tb_data[831:800]));
    uartm_read (.addr (addr + 16'h68), .data(uartm_rx_tb_data[863:832]));
    uartm_read (.addr (addr + 16'h6c), .data(uartm_rx_tb_data[895:864]));
    uartm_read (.addr (addr + 16'h70), .data(uartm_rx_tb_data[927:896]));
    uartm_read (.addr (addr + 16'h74), .data(uartm_rx_tb_data[959:928]));
    uartm_read (.addr (addr + 16'h78), .data(uartm_rx_tb_data[991:960]));
    uartm_read (.addr (addr + 16'h7c), .data(uartm_rx_tb_data[1023:992]));
    uartm_read (.addr (addr + 16'h80), .data(uartm_rx_tb_data[1055:1024]));
    uartm_read (.addr (addr + 16'h84), .data(uartm_rx_tb_data[1087:1056]));
    uartm_read (.addr (addr + 16'h88), .data(uartm_rx_tb_data[1119:1088]));
    uartm_read (.addr (addr + 16'h8c), .data(uartm_rx_tb_data[1151:1120]));
    uartm_read (.addr (addr + 16'h90), .data(uartm_rx_tb_data[1183:1152]));
    uartm_read (.addr (addr + 16'h94), .data(uartm_rx_tb_data[1215:1184]));
    uartm_read (.addr (addr + 16'h98), .data(uartm_rx_tb_data[1247:1216]));
    uartm_read (.addr (addr + 16'h9c), .data(uartm_rx_tb_data[1279:1248]));
    uartm_read (.addr (addr + 16'ha0), .data(uartm_rx_tb_data[1311:1280]));
    uartm_read (.addr (addr + 16'ha4), .data(uartm_rx_tb_data[1343:1312]));
    uartm_read (.addr (addr + 16'ha8), .data(uartm_rx_tb_data[1375:1344]));
    uartm_read (.addr (addr + 16'hac), .data(uartm_rx_tb_data[1407:1376]));
    uartm_read (.addr (addr + 16'hb0), .data(uartm_rx_tb_data[1439:1408]));
    uartm_read (.addr (addr + 16'hb4), .data(uartm_rx_tb_data[1471:1440]));
    uartm_read (.addr (addr + 16'hb8), .data(uartm_rx_tb_data[1503:1472]));
    uartm_read (.addr (addr + 16'hbc), .data(uartm_rx_tb_data[1535:1504]));
    uartm_read (.addr (addr + 16'hc0), .data(uartm_rx_tb_data[1567:1536]));
    uartm_read (.addr (addr + 16'hc4), .data(uartm_rx_tb_data[1599:1568]));
    uartm_read (.addr (addr + 16'hc8), .data(uartm_rx_tb_data[1631:1600]));
    uartm_read (.addr (addr + 16'hcc), .data(uartm_rx_tb_data[1663:1632]));
    uartm_read (.addr (addr + 16'hd0), .data(uartm_rx_tb_data[1695:1664]));
    uartm_read (.addr (addr + 16'hd4), .data(uartm_rx_tb_data[1727:1696]));
    uartm_read (.addr (addr + 16'hd8), .data(uartm_rx_tb_data[1759:1728]));
    uartm_read (.addr (addr + 16'hdc), .data(uartm_rx_tb_data[1791:1760]));
    uartm_read (.addr (addr + 16'he0), .data(uartm_rx_tb_data[1823:1792]));
    uartm_read (.addr (addr + 16'he4), .data(uartm_rx_tb_data[1855:1824]));
    uartm_read (.addr (addr + 16'he8), .data(uartm_rx_tb_data[1887:1856]));
    uartm_read (.addr (addr + 16'hec), .data(uartm_rx_tb_data[1919:1888]));
    uartm_read (.addr (addr + 16'hf0), .data(uartm_rx_tb_data[1951:1920]));
    uartm_read (.addr (addr + 16'hf4), .data(uartm_rx_tb_data[1983:1952]));
    uartm_read (.addr (addr + 16'hf8), .data(uartm_rx_tb_data[2015:1984]));
    uartm_read (.addr (addr + 16'hfc), .data(uartm_rx_tb_data[2047:2016]));
  end
endtask



task uartm_read_1k (input integer addr);
  begin
    uartm_read (.addr (addr + 16'h00), .data(uartm_rx_tb_data[31:0]));
    uartm_read (.addr (addr + 16'h04), .data(uartm_rx_tb_data[63:32]));
    uartm_read (.addr (addr + 16'h08), .data(uartm_rx_tb_data[95:64]));
    uartm_read (.addr (addr + 16'h0c), .data(uartm_rx_tb_data[127:96]));
    uartm_read (.addr (addr + 16'h10), .data(uartm_rx_tb_data[159:128]));
    uartm_read (.addr (addr + 16'h14), .data(uartm_rx_tb_data[191:160]));
    uartm_read (.addr (addr + 16'h18), .data(uartm_rx_tb_data[223:192]));
    uartm_read (.addr (addr + 16'h1c), .data(uartm_rx_tb_data[255:224]));
    uartm_read (.addr (addr + 16'h20), .data(uartm_rx_tb_data[287:256]));
    uartm_read (.addr (addr + 16'h24), .data(uartm_rx_tb_data[319:288]));
    uartm_read (.addr (addr + 16'h28), .data(uartm_rx_tb_data[351:320]));
    uartm_read (.addr (addr + 16'h2c), .data(uartm_rx_tb_data[383:352]));
    uartm_read (.addr (addr + 16'h30), .data(uartm_rx_tb_data[415:384]));
    uartm_read (.addr (addr + 16'h34), .data(uartm_rx_tb_data[447:416]));
    uartm_read (.addr (addr + 16'h38), .data(uartm_rx_tb_data[479:448]));
    uartm_read (.addr (addr + 16'h3c), .data(uartm_rx_tb_data[511:480]));
    uartm_read (.addr (addr + 16'h40), .data(uartm_rx_tb_data[543:512]));
    uartm_read (.addr (addr + 16'h44), .data(uartm_rx_tb_data[575:544]));
    uartm_read (.addr (addr + 16'h48), .data(uartm_rx_tb_data[607:576]));
    uartm_read (.addr (addr + 16'h4c), .data(uartm_rx_tb_data[639:608]));
    uartm_read (.addr (addr + 16'h50), .data(uartm_rx_tb_data[671:640]));
    uartm_read (.addr (addr + 16'h54), .data(uartm_rx_tb_data[703:672]));
    uartm_read (.addr (addr + 16'h58), .data(uartm_rx_tb_data[735:704]));
    uartm_read (.addr (addr + 16'h5c), .data(uartm_rx_tb_data[767:736]));
    uartm_read (.addr (addr + 16'h60), .data(uartm_rx_tb_data[799:768]));
    uartm_read (.addr (addr + 16'h64), .data(uartm_rx_tb_data[831:800]));
    uartm_read (.addr (addr + 16'h68), .data(uartm_rx_tb_data[863:832]));
    uartm_read (.addr (addr + 16'h6c), .data(uartm_rx_tb_data[895:864]));
    uartm_read (.addr (addr + 16'h70), .data(uartm_rx_tb_data[927:896]));
    uartm_read (.addr (addr + 16'h74), .data(uartm_rx_tb_data[959:928]));
    uartm_read (.addr (addr + 16'h78), .data(uartm_rx_tb_data[991:960]));
    uartm_read (.addr (addr + 16'h7c), .data(uartm_rx_tb_data[1023:992]));
  end
endtask

task cleq_init (input [1023:0] n, input [2047:0] nsq, input [2047:0] fkf, input [1023:0] rand0, input [1023:0] rand1, input [11:0] log2ofn, input [11:0] maxbits, input nsq_modulus, input hw_rand, input bypvn);
  begin
    uartm_write    (.addr(GPCFG_HOSTIRQ_PAD_CTL),     .data(32'h12001A));
    uartm_write_1k (.addr(GPCFG_N_ADDR[0][31:0]),     .data(n));
    uartm_write_2k (.addr(GPCFG_NSQ_ADDR[0][31:0]),   .data(nsq));
    uartm_write_2k (.addr(GPCFG_FKF_ADDR[0][31:0]),   .data(fkf));
    uartm_write_1k (.addr(GPCFG_RAND0_ADDR[0][31:0]), .data(rand0));
    uartm_write_1k (.addr(GPCFG_RAND1_ADDR[0][31:0]), .data(rand1));
    uartm_write    (.addr(GPCFG_FHECTLP_ADDR),         .data(32'h0 | CLCTLP_CLRHIRQ));
    temp1_reg[31:0] = 32'h0 | ((CLCTL_MODNSQ & (nsq_modulus << 13))  | (CLCTL_GCDARGB & (1'b0    << 16)) |
                               (CLCTL_HWRAND & (hw_rand     << 15))  | (CLCTL_BYPVN   & (bypvn   << 14)) | maxbits);
    uartm_write    (.addr(GPCFG_FHECTL_ADDR),          .data(temp1_reg[31:0]));
  end
endtask


task uartm_modmul (input [2047:0] arga,input [2047:0] argb);
  begin
        $display($time, " #------------------MODMUL STARTED---------------------*");
    uartm_write_2k (.addr(GPCFG_ARGA_ADDR[0][31:0]),    .data(arga));
    uartm_write_2k (.addr(GPCFG_ARGB_ADDR[0][31:0]),    .data(argb));
    uartm_write    (.addr(GPCFG_FHECTLP_ADDR),           .data(32'h0 | CLCTLP_ENMODMUL));
    //@(posedge fhe_host_irq);
    wait (fhe_host_irq == 1'b1)
    uartm_write    (.addr(GPCFG_FHECTLP_ADDR),           .data(32'h0 | CLCTLP_CLRHIRQ));
    uartm_read_2k  (.addr(GPCFG_MUL_ADDR[0][31:0]));
    if (uartm_rx_tb_data[NBITS-1 :0] == arga*argb%mod) begin
      $display($time, " #------------------MODMUL PASSED---------------------*");
    end
    else begin
      $display($time, " #------------------MODMUL FAILED---------------------*");
    end
    $display($time, " << Expected Result               %d", arga*argb%mod);
    $display($time, " << Calculated Result             %d", uartm_rx_tb_data[NBITS-1 :0]);
  end
endtask

task uartm_modexp (input [2047:0] arga,input [2047:0] argb);
  begin
        $display($time, " #------------------MODEXP STARTED---------------------*");
    uartm_write_2k (.addr(GPCFG_ARGA_ADDR[0][31:0]),    .data(arga));
    uartm_write_2k (.addr(GPCFG_ARGB_ADDR[0][31:0]),    .data(argb));
    uartm_write    (.addr(GPCFG_FHECTLP_ADDR),           .data(32'h0 | CLCTLP_ENMODEXP));
    wait (fhe_host_irq == 1'b1)
//  @(posedge fhe_host_irq);
    uartm_write    (.addr(GPCFG_FHECTLP_ADDR),           .data(32'h0 | CLCTLP_CLRHIRQ));
    uartm_read_2k  (.addr(GPCFG_EXP_ADDR[0][31:0]));
    $display($time, " << Calculated Result            %d", uartm_rx_tb_data[NBITS-1 :0]);
    //scratch_pad = (arga**argb)%nsq;
    scratch_pad = arga;
    for (i = 1; i < argb; i++) begin
      //$display($time, " << %d out of %d", i, argb);
      scratch_pad = scratch_pad*arga%mod;
    end
    if (uartm_rx_tb_data[NBITS-1 :0] == scratch_pad) begin
      $display($time, " #------------------MODEXP PASSED---------------------*");
    end
    else begin
      $display($time, " #------------------MODEXP FAILED---------------------*");
    end
    $display($time, " << Expected Result               %d", scratch_pad);
    $display($time, " << Calculated Result             %d", uartm_rx_tb_data[NBITS-1 :0]);
  end
endtask

task uartm_gfunc (input [2047:0] arga,input [2047:0] argb);
  begin
        $display($time, " #------------------GFUNC STARTED---------------------*");
    uartm_write_2k (.addr(GPCFG_ARGA_ADDR[0][31:0]),    .data(arga));
    uartm_write_2k (.addr(GPCFG_ARGB_ADDR[0][31:0]),    .data(argb));
    uartm_write    (.addr(GPCFG_FHECTLP_ADDR),           .data(32'h0 | CLCTLP_ENGFUNC));
    wait (fhe_host_irq == 1'b1)
//  @(posedge fhe_host_irq);
    uartm_write    (.addr(GPCFG_FHECTLP_ADDR),           .data(32'h0 | CLCTLP_CLRHIRQ));
    uartm_read_2k  (.addr(GPCFG_RES_ADDR[0][31:0]));
    $display($time, " << Calculated Result             %d", uartm_rx_tb_data[NBITS-1 :0]);
  end
endtask

task uarts_rx_data_capture (output [7:0] data);
  begin
    //rx_reg <= 8'b0;
    @(negedge uarts_rx_data);
    //@(negedge UART_CLK && ~uartm_rx_data);
    #(UART_BAUD/2);
    //@(negedge UART_CLK);
    repeat(8) begin
      #UART_BAUD;
      //@(negedge UART_CLK);
      rx_reg = {uarts_rx_data, rx_reg[7:1]};
    end
    //@(posedge UART_CLK);
    data = rx_reg;
  end
endtask

  // Sends a single byte from master to slave.  Will drive CS on its own.
  task SendSingleByte_SPI(input [7:0] data);
    @(posedge r_Clkm);
      $display("TX = %x", data);
    r_Master_TX_Byte <= data;
    r_Master_TX_DV   <= 1'b1;
    r_Master_CS_n    <= 1'b0;
    @(posedge r_Clkm);
    r_Master_TX_DV <= 1'b0;
    @(posedge w_Master_TX_Ready);
    //r_Master_CS_n    <= 1'b1;    
    //repeat (100) @(posedge r_Clkm);
  endtask // SendSingleByte


  // Sends a multi-byte transfer from master to slave.  Drives CS on its own.  
  task SendMultiByte_SPI(input [7:0] data[0:255], input [7:0] length);
    integer ii,jj;

    @(posedge r_Clkm);
    r_Master_CS_n    <= 1'b0;

    for (ii=0; ii<length; ii++)
    begin
      @(posedge r_Clkm);
      $display("TX = %x", data[ii]);
      r_Master_TX_Byte <= data[ii];
      r_Master_TX_DV   <= 1'b1;
      @(posedge r_Clkm);
      r_Master_TX_DV <= 1'b0;
      @(posedge w_Master_TX_Ready);
      if((ii%4) == 3) begin
	repeat(80) @(posedge CLK50M);
      end
    end

  endtask // SendMultiByte

// Sends a multi-byte transfer from master to slave.  Drives CS on its own.  
//  task SendMultiByte_UART(input [7:0] data[0:255], input [7:0] length);
//    integer ii;
//
//    @(posedge CLK50M);
//    uart_start    <= 1'b0;
//
//    for (ii=0; ii<length; ii++)
//    begin
//      @(posedge CLK50M);
//      uart_data <= data[ii];
//      repeat(10) @(posedge CLK50M);
//      @(posedge CLK50M);
//      uart_start   <= 1'b1;
//      @(posedge CLK50M);
//      uart_start   <= 1'b0;
//      @(posedge CLK50M);
//      @(negedge uart_busy);
//      repeat(10) @(posedge CLK50M);
//    end
//      repeat(10000) @(posedge CLK50M);
//  endtask // SendMultiByte

// Generates read commands for the SPI/UART. 
task read_SPI(input int burst_size, input int bitwidth, input int start_address, output [7:0] data[0:255], output [7:0] length);
    integer ii, jj;

    length = 1;

    if(bitwidth != prev_r_bitwidth_spi) begin
	data[0] = 'd7;
	data[length+0] = bitwidth/(256*256*256);
	data[length+1] = bitwidth/(256*256);
	data[length+2] = bitwidth/256;
	data[length+3] = bitwidth;
	length = length + 4;
	data[length+0] = burst_size/(256*256*256);
	data[length+1] = burst_size/(256*256);
	data[length+2] = burst_size/256;
	data[length+3] = burst_size;
	length = length + 4;
    data[length+0] = (start_address/(256*256*256))%256;
    data[length+1] = (start_address/(256*256))%256;
    data[length+2] = (start_address/256)%256;
    data[length+3] = start_address%256;
    length = length + 4;
	prev_r_bitwidth_spi = bitwidth;
	prev_r_burst_size_spi = burst_size;
	prev_r_address_spi = start_address + burst_size*bitwidth/8;
    end else if(burst_size != prev_r_burst_size_spi) begin
	data[0] = 'd6;
	data[length+0] = burst_size/(256*256*256);
	data[length+1] = burst_size/(256*256);
	data[length+2] = burst_size/256;
	data[length+3] = burst_size;
	length = length + 4;
    data[length+0] = (start_address/(256*256*256))%256;
    data[length+1] = (start_address/(256*256))%256;
    data[length+2] = (start_address/256)%256;
    data[length+3] = start_address%256;
    length = length + 4;
	prev_r_burst_size_spi = burst_size;
	prev_r_address_spi = start_address + burst_size*bitwidth/8;
    end else if(start_address != prev_r_address_spi) begin
	data[0] = 'd5;
    data[length+0] = (start_address/(256*256*256))%256;
    data[length+1] = (start_address/(256*256))%256;
    data[length+2] = (start_address/256)%256;
    data[length+3] = start_address%256;
    length = length + 4;
	prev_r_address_spi = start_address + burst_size*bitwidth/8;
    end else begin
        data[0] = 'd4;
	prev_r_address_spi = start_address + burst_size*bitwidth/8;
    end
    $display("SPI: read payload size = %d",length);
    SendMultiByte_SPI(data, length);
    repeat(80) @(posedge CLK50M);
    $display("SPI: read payload size = %d",length);
    for (ii=0; ii<burst_size; ii++)
    begin
      for (jj=0; jj<bitwidth/8; jj++)
      begin
         SendSingleByte_SPI('hFE);
         r_Master_CS_n    <= 1'b1;    
         repeat(8) @(posedge CLK50M);
	 if(((ii*bitwidth/8+jj)%4) == 3) begin
	    repeat(80) @(posedge CLK50M);
	 end
	 //$display("SPI: send single Byte");
      end
      //repeat(80) @(posedge CLK50M);
    end
    r_Master_CS_n    <= 1'b1;    
    repeat (100) @(posedge r_Clkm);
endtask //read command

// Generates write commands for the SPI/UART. 
task write_SPI(input int burst_size, input int bitwidth, input int start_address, output [7:0] data[0:255], output [7:0] length);
    integer ii, jj;

    length = 1;

    if(bitwidth != prev_w_bitwidth_spi) begin
	data[0] = 'd3;
	data[length+0] = bitwidth/(256*256*256);
	data[length+1] = bitwidth/(256*256);
	data[length+2] = bitwidth/256;
	data[length+3] = bitwidth;
	length = length + 4;
	data[length+0] = burst_size/(256*256*256);
	data[length+1] = burst_size/(256*256);
	data[length+2] = burst_size/256;
	data[length+3] = burst_size;
	length = length + 4;
    data[length+0] = (start_address/(256*256*256))%256;
    data[length+1] = (start_address/(256*256))%256;
    data[length+2] = (start_address/256)%256;
    data[length+3] = start_address%256;
    length = length + 4;
	prev_w_bitwidth_spi = bitwidth;
	prev_w_burst_size_spi = burst_size;
	prev_w_address_spi = start_address + burst_size*bitwidth/8;
    end else if(burst_size != prev_w_burst_size_spi) begin
	data[0] = 'd2;
	data[length+0] = burst_size/(256*256*256);
	data[length+1] = burst_size/(256*256);
	data[length+2] = burst_size/256;
	data[length+3] = burst_size;
	length = length + 4;
    data[length+0] = (start_address/(256*256*256))%256;
    data[length+1] = (start_address/(256*256))%256;
    data[length+2] = (start_address/256)%256;
    data[length+3] = start_address%256;
    length = length + 4;
	prev_w_burst_size_spi = burst_size;
	prev_w_address_spi = start_address + burst_size*bitwidth/8;
    end else if(start_address != prev_w_address_spi) begin
	data[0] = 'd1;
    data[length+0] = (start_address/(256*256*256))%256;
    data[length+1] = (start_address/(256*256))%256;
    data[length+2] = (start_address/256)%256;
    data[length+3] = start_address%256;
    length = length + 4;
	prev_w_address_spi = start_address + burst_size*bitwidth/8;
    end else begin
        data[0] = 'd0;
	prev_w_address_spi = start_address + burst_size*bitwidth/8;
    end

    for (ii=0; ii<burst_size; ii++)
    begin
      for (jj=0; jj<bitwidth/8; jj++)
      begin
        data[length+ii*bitwidth/8+jj] = ii*16 + jj;
      end
    end
    length = length + burst_size*bitwidth/8;
    $display("SPI: write payload size = %d start address = %d prev address = %d",length, start_address, prev_w_address_spi);
    SendMultiByte_SPI(data, length);
endtask //Write command
  

// Generates read commands for the SPI/UART. 
// task read_UART(input int burst_size, input int bitwidth, input int start_address, output [7:0] data[0:255], output [7:0] length);
//   integer ii, jj;
//
//   length = 1;
//
//   if(bitwidth != prev_r_bitwidth) begin
//   data[0] = 'd7;
//   data[length+0] = bitwidth/256*256*256;
//   data[length+1] = bitwidth/256*256;
//   data[length+2] = bitwidth/256;
//   data[length+3] = bitwidth;
//   length = length + 4;
//   data[length+0] = burst_size/256*256*256;
//   data[length+1] = burst_size/256*256;
//   data[length+2] = burst_size/256;
//   data[length+3] = burst_size;
//   length = length + 4;
//       data[length+0] = start_address/256*256*256;
//       data[length+1] = start_address/256*256;
//       data[length+2] = start_address/256;
//       data[length+3] = start_address;
//       length = length + 4;
//   prev_r_bitwidth = bitwidth;
//   prev_r_burst_size = burst_size;
//   prev_r_address = start_address + burst_size*bitwidth/8;
//   end else if(burst_size != prev_r_burst_size) begin
//   data[0] = 'd6;
//   data[length+0] = burst_size/256*256*256;
//   data[length+1] = burst_size/256*256;
//   data[length+2] = burst_size/256;
//   data[length+3] = burst_size;
//   length = length + 4;
//       data[length+0] = start_address/256*256*256;
//       data[length+1] = start_address/256*256;
//       data[length+2] = start_address/256;
//       data[length+3] = start_address;
//       length = length + 4;
//   prev_r_burst_size = burst_size;
//   prev_r_address = start_address + burst_size*bitwidth/8;
//   end else if(start_address != prev_r_address) begin
//   data[0] = 'd5;
//       data[length+0] = start_address/256*256*256;
//       data[length+1] = start_address/256*256;
//       data[length+2] = start_address/256;
//       data[length+3] = start_address;
//       length = length + 4;
//   prev_r_address = start_address + burst_size*bitwidth/8;
//   end else begin
//       data[0] = 'd4;
//   prev_r_address = start_address + burst_size*bitwidth/8;
//   end
//   $display("read payload size = %d",length);
//   SendMultiByte_UART(data, length);
//   for (ii=0; ii<burst_size; ii++)
//   begin
//     for (jj=0; jj<bitwidth/8; jj++)
//     begin
//        @(posedge CLK50M);
//        repeat(10) @(posedge CLK50M);
//        @(posedge CLK50M);
//        @(posedge CLK50M);
//        @(posedge CLK50M);
//        repeat(8000) @(posedge CLK50M);
//     end
//   end
//   repeat(4000) @(posedge CLK50M);
// endtask //read command

// Generates write commands for the SPI/UART. 
// task write_UART(input int burst_size, input int bitwidth, input int start_address, output [7:0] data[0:255], output [7:0] length);
//   integer ii, jj;
//
//   length = 1;
//
//   if(bitwidth != prev_w_bitwidth) begin
//   data[0] = 'd3;
//   data[length+0] = bitwidth/256*256*256;
//   data[length+1] = bitwidth/256*256;
//   data[length+2] = bitwidth/256;
//   data[length+3] = bitwidth;
//   length = length + 4;
//   data[length+0] = burst_size/256*256*256;
//   data[length+1] = burst_size/256*256;
//   data[length+2] = burst_size/256;
//   data[length+3] = burst_size;
//   length = length + 4;
//       data[length+0] = start_address/256*256*256;
//       data[length+1] = start_address/256*256;
//       data[length+2] = start_address/256;
//       data[length+3] = start_address;
//       length = length + 4;
//   prev_w_bitwidth = bitwidth;
//   prev_w_burst_size = burst_size;
//   prev_w_address = start_address + burst_size*bitwidth/8;
//   end else if(burst_size != prev_w_burst_size) begin
//   data[0] = 'd2;
//   data[length+0] = burst_size/256*256*256;
//   data[length+1] = burst_size/256*256;
//   data[length+2] = burst_size/256;
//   data[length+3] = burst_size;
//   length = length + 4;
//       data[length+0] = start_address/256*256*256;
//       data[length+1] = start_address/256*256;
//       data[length+2] = start_address/256;
//       data[length+3] = start_address;
//       length = length + 4;
//   prev_w_burst_size = burst_size;
//   prev_w_address = start_address + burst_size*bitwidth/8;
//   end else if(start_address != prev_w_address) begin
//   data[0] = 'd1;
//       data[length+0] = start_address/256*256*256;
//       data[length+1] = start_address/256*256;
//       data[length+2] = start_address/256;
//       data[length+3] = start_address;
//       length = length + 4;
//   prev_w_address = start_address + burst_size*bitwidth/8;
//   end else begin
//       data[0] = 'd0;
//   prev_w_address = start_address + burst_size*bitwidth/8;
//   end
//
//   for (ii=0; ii<burst_size; ii++)
//   begin
//     for (jj=0; jj<bitwidth/8; jj++)
//     begin
//       data[length+ii*bitwidth/8+jj] = ii*16 + jj;
//     end
//   end
//   length = length + burst_size*bitwidth/8;
//   $display("write payload size = %d",length);
//   SendMultiByte_UART(data, length);
//   
// endtask //Write command

//task UART_check();
//      //read_UART(3,32,320,dataPayload, dataLength);
//      //read_UART(4,32,3200,dataPayload, dataLength);
//      //read_UART(8,32,3000,dataPayload, dataLength);
//      //$display("payload size = %d",dataLength);
//      //SendMultiByte_UART(dataPayload, dataLength);
//      //read_UART(1,32,8,dataPayload, dataLength);
//      write_UART(2,32,8,dataPayload, dataLength);
//      //write_UART(1,32,48,dataPayload, dataLength);
//      read_UART(2,32,8,dataPayload, dataLength);
//      //$display("payload size = %d",dataLength);
//      //SendMultiByte_UART(dataPayload, dataLength);
//      write_UART(1,32,20,dataPayload, dataLength);
//      //$display("payload size = %d",dataLength);
//      //SendMultiByte_UART(dataPayload, dataLength);
//      write_UART(2,32,28,dataPayload, dataLength);
//      read_UART(2,32,28,dataPayload, dataLength);
//      //$display("payload size = %d",dataLength);
//      //SendMultiByte_UART(dataPayload, dataLength);
//      write_UART(2,128,80,dataPayload, dataLength);
//      //$display("payload size = %d",dataLength);
//      //SendMultiByte_UART(dataPayload, dataLength);
//endtask

task SPI_check();
      //read_SPI(3,32,320,dataPayload, dataLength);
      //read_SPI(4,32,3200,dataPayload, dataLength);
      //read_SPI(8,32,3000,dataPayload, dataLength);
      //$display("payload size = %d",dataLength);
      //SendMultiByte_SPI(dataPayload, dataLength);
      //read_SPI(1,32,8,dataPayload, dataLength);
      write_SPI(1,32,32'h21000000,dataPayload, dataLength);
      read_SPI (1,32,32'h21000000,dataPayload, dataLength);
      //write_SPI(1,32,48,dataPayload, dataLength);
      //write_SPI(10,32,8,dataPayload, dataLength);
      //read_SPI(10,32,8,dataPayload, dataLength);
      //$display("payload size = %d",dataLength);
      //SendMultiByte_SPI(dataPayload, dataLength);
      //write_SPI(1,32,20,dataPayload, dataLength);
      //$display("payload size = %d",dataLength);
      //SendMultiByte_SPI(dataPayload, dataLength);
      //write_SPI(2,32,28,dataPayload, dataLength);
      //read_SPI(2,32,28,dataPayload, dataLength);
      //$display("payload size = %d",dataLength);
      //SendMultiByte_SPI(dataPayload, dataLength);
      //write_SPI(2,128,80,dataPayload, dataLength);
      //$display("payload size = %d",dataLength);
      //SendMultiByte_SPI(dataPayload, dataLength);
endtask
 
