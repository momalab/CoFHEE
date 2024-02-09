module timer (
    input  wire          hclk,
    input  wire          hresetn,
    input  wire          wdt_rstn,
    input  wire [31:0]   timerA_cfg,
    input  wire [31:0]   timerB_cfg,
    input  wire [31:0]   timerC_cfg,
    input  wire [31:0]   wdtimer_cfg,
    input  wire [31:0]   wdtimer_cfg2,
    input  wire          timerA_en,
    input  wire          timerB_en,
    input  wire          timerC_en,
    input  wire          wdtimer_en,
    input  wire          timerA_rst,
    input  wire          timerB_rst,
    input  wire          timerC_rst,
    input  wire          wdtimer_rst,
    input  wire [31:0]   pwm_val_tim0,
    input  wire [31:0]   pwm_val_tim1,
    output reg           timerA_irq,
    output reg           timerB_irq,
    output reg           timerC_irq,
    output wire          wdtimer_irq,
    output reg           wdtimer_nmi,
    output wire          pwm_out
);

reg [15:0] timerA_L;
reg [15:0] timerA_U;
reg        timerA_incr;

reg [15:0] timerB_L;
reg [15:0] timerB_U;
reg        timerB_incr;

reg [15:0] timerC_L;
reg [15:0] timerC_U;
reg        timerC_incr;

reg [15:0] wdtimer_L;
reg [15:0] wdtimer_U;
reg        wdtimer_incr;
reg        wdtimer_irq_loc;
reg        wdtimer_irq_loc_d1;
reg        wdtimer_irq_loc_d2;
reg        wdtimer_irq_loc_d3;
reg        wdtimer_irq_loc_d4;
reg        wdtimer_irq_loc_d5;


reg [31:0] pwm_shift_reg;
reg [7:0]  pwm_shift_count;

//Timer A
always @ (posedge hclk or negedge hresetn) begin
  if (hresetn == 1'b0) begin
    timerA_U    <= 16'b0;
    timerA_incr <= 1'b0;
  end
  else begin
    if (timerA_rst == 1'b1) begin
      timerA_U    <= 16'b0;
      timerA_incr <= 1'b0;
    end
    else if (timerA_en == 1'b1) begin
        if (timerA_U == timerA_cfg[31:16]) begin
          timerA_U    <= 16'b0;
          timerA_incr <= 1'b1;
        end
        else begin
          timerA_U    <= timerA_U + 1'b1;
          timerA_incr <= 1'b0;
        end
    end
    else begin
      timerA_U    <= 16'b0;
      timerA_incr <= 1'b0;
    end
  end
end


always @ (posedge hclk or negedge hresetn) begin
  if (hresetn == 1'b0) begin
    timerA_L   <= 16'b0;
  end
  else begin
    if (timerA_rst == 1'b1) begin
      timerA_L    <= 16'b0;
    end
    else if (timerA_en == 1'b1) begin
      if (timerA_L == timerA_cfg[15:0]) begin
        timerA_L   <= 16'b0;
      end
      else if (timerA_incr == 1'b1) begin
        timerA_L   <= timerA_L + 1'b1;
      end
    end
    else begin
      timerA_L   <= 16'b0;
    end
  end
end

always @ (posedge hclk or negedge hresetn) begin
  if (hresetn == 1'b0) begin
    timerA_irq <= 1'b0;
  end
  else begin
    if (timerA_rst == 1'b1) begin
      timerA_irq <= 1'b0;
    end
    else if (timerA_en == 1'b1) begin
      if (timerA_L == timerA_cfg[15:0]) begin
        timerA_irq <= 1'b1;
      end
      else begin
        timerA_irq <= 1'b0;
      end
    end
  end
end


//Timer B

always @ (posedge hclk or negedge hresetn) begin
  if (hresetn == 1'b0) begin
    timerB_U    <= 16'b0;
    timerB_incr <= 1'b0;
  end
  else begin
    if (timerB_rst == 1'b1) begin
      timerB_U    <= 16'b0;
      timerB_incr <= 1'b0;
    end
    else if (timerB_en == 1'b1) begin
        if (timerB_U == timerB_cfg[31:16]) begin
          timerB_U    <= 16'b0;
          timerB_incr <= 1'b1;
        end
        else begin
          timerB_U    <= timerB_U + 1'b1;
          timerB_incr <= 1'b0;
        end
    end
    else begin
      timerB_U    <= 16'b0;
      timerB_incr <= 1'b0;
    end
  end
end


always @ (posedge hclk or negedge hresetn) begin
  if (hresetn == 1'b0) begin
    timerB_L   <= 16'b0;
  end
  else begin
    if (timerB_rst == 1'b1) begin
      timerB_L    <= 16'b0;
    end
    else if (timerB_en == 1'b1) begin
      if (timerB_L == timerB_cfg[15:0]) begin
        timerB_L   <= 16'b0;
      end
      else if (timerB_incr == 1'b1) begin
        timerB_L   <= timerB_L + 1'b1;
      end
    end
    else begin
      timerB_L   <= 16'b0;
    end
  end
end

always @ (posedge hclk or negedge hresetn) begin
  if (hresetn == 1'b0) begin
    timerB_irq <= 1'b0;
  end
  else begin
    if (timerB_rst == 1'b1) begin
      timerB_irq <= 1'b0;
    end
    else if (timerB_en == 1'b1) begin
      if (timerB_L == timerB_cfg[15:0]) begin
        timerB_irq <= 1'b1;
      end
      else begin
        timerB_irq <= 1'b0;
      end
    end
  end
end


//Timer C

always @ (posedge hclk or negedge hresetn) begin
  if (hresetn == 1'b0) begin
    timerC_U    <= 16'b0;
    timerC_incr <= 1'b0;
  end
  else begin
    if (timerC_rst == 1'b1) begin
      timerC_U    <= 16'b0;
      timerC_incr <= 1'b0;
    end
    else if (timerC_en == 1'b1) begin
        if (timerC_U == timerC_cfg[31:16]) begin
          timerC_U    <= 16'b0;
          timerC_incr <= 1'b1;
        end
        else begin
          timerC_U    <= timerC_U + 1'b1;
          timerC_incr <= 1'b0;
        end
    end
    else begin
      timerC_U    <= 16'b0;
      timerC_incr <= 1'b0;
    end
  end
end


always @ (posedge hclk or negedge hresetn) begin
  if (hresetn == 1'b0) begin
    timerC_L   <= 16'b0;
  end
  else begin
    if (timerC_rst == 1'b1) begin
      timerC_L    <= 16'b0;
    end
    else if (timerC_en == 1'b1) begin
      if (timerC_L == timerC_cfg[15:0]) begin
        timerC_L   <= 16'b0;
      end
      else if (timerC_incr == 1'b1) begin
        timerC_L   <= timerC_L + 1'b1;
      end
    end
    else begin
      timerC_L   <= 16'b0;
    end
  end
end

always @ (posedge hclk or negedge hresetn) begin
  if (hresetn == 1'b0) begin
    timerC_irq <= 1'b0;
  end
  else begin
    if (timerC_rst == 1'b1) begin
      timerC_irq <= 1'b0;
    end
    else if (timerC_en == 1'b1) begin
      if (timerC_L == timerC_cfg[15:0]) begin
        timerC_irq <= 1'b1;
      end
      else begin
        timerC_irq <= 1'b0;
      end
    end
  end
end


//WD Timer


always @ (posedge hclk or negedge hresetn) begin
  if (hresetn == 1'b0) begin
    wdtimer_U    <= 16'b0;
    wdtimer_incr <= 1'b0;
  end
  else begin
    if (wdtimer_rst == 1'b1) begin
      wdtimer_U    <= 16'b0;
      wdtimer_incr <= 1'b0;
    end
    else if (wdtimer_en == 1'b1) begin
        if (wdtimer_U == wdtimer_cfg[31:16]) begin
          wdtimer_U    <= 16'b0;
          wdtimer_incr <= 1'b1;
        end
        else begin
          wdtimer_U    <= wdtimer_U + 1'b1;
          wdtimer_incr <= 1'b0;
        end
    end
    else begin
      wdtimer_U    <= 16'b0;
      wdtimer_incr <= 1'b0;
    end
  end
end


always @ (posedge hclk or negedge hresetn) begin
  if (hresetn == 1'b0) begin
    wdtimer_L   <= 16'b0;
  end
  else begin
    if (wdtimer_rst == 1'b1) begin
      wdtimer_L    <= 16'b0;
    end
    else if (wdtimer_en == 1'b1) begin
      if (wdtimer_L == wdtimer_cfg[15:0]) begin
        wdtimer_L   <= 16'b0;
      end
      else if (wdtimer_incr == 1'b1) begin
        wdtimer_L   <= wdtimer_L + 1'b1;
      end
    end
    else begin
      wdtimer_L    <= 16'b0;
    end
  end
end

always @ (posedge hclk or negedge hresetn) begin
  if (hresetn == 1'b0) begin
    wdtimer_irq_loc <= 1'b0;
  end
  else begin
    if (wdtimer_rst == 1'b1) begin
      wdtimer_irq_loc <= 1'b0;
    end
    else if (wdtimer_en == 1'b1) begin
      if (wdtimer_L == wdtimer_cfg[15:0]) begin
        wdtimer_irq_loc <= 1'b1;
      end
      else begin
        wdtimer_irq_loc <= 1'b0;
      end
    end
  end
end

always @ (posedge hclk or negedge hresetn) begin
  if (hresetn == 1'b0) begin
    wdtimer_nmi <= 1'b0;
  end
  else begin
    if (wdtimer_en == 1'b1) begin
      if (wdtimer_L == wdtimer_cfg2[15:0]) begin
        wdtimer_nmi <= 1'b1;
      end
      else begin
        wdtimer_nmi <= 1'b0;
      end
    end
  end
end

always @ (posedge hclk or negedge wdt_rstn) begin
  if (wdt_rstn == 1'b0) begin
    wdtimer_irq_loc_d1 <= 1'b0;
    wdtimer_irq_loc_d2 <= 1'b0;
    wdtimer_irq_loc_d3 <= 1'b0;
    wdtimer_irq_loc_d4 <= 1'b0;
    wdtimer_irq_loc_d5 <= 1'b0;
  end
  else begin
    wdtimer_irq_loc_d1 <= wdtimer_irq_loc;
    wdtimer_irq_loc_d2 <= wdtimer_irq_loc_d1;
    wdtimer_irq_loc_d3 <= wdtimer_irq_loc_d2;
    wdtimer_irq_loc_d4 <= wdtimer_irq_loc_d3;
    wdtimer_irq_loc_d5 <= wdtimer_irq_loc_d4;
  end
end

assign  wdtimer_irq = wdtimer_irq_loc_d3 | wdtimer_irq_loc_d4 | wdtimer_irq_loc_d5;


always @ (posedge hclk or negedge hresetn) begin
  if (hresetn == 1'b0) begin
    pwm_shift_reg   <= 32'b0;
    pwm_shift_count <= 8'd0;
  end
  else if ((timerC_rst == 1'b1) | (pwm_shift_count == 8'd64)) begin
    pwm_shift_reg   <= pwm_val_tim0;
    pwm_shift_count <= 8'd0;
  end
  else if (pwm_shift_count == 8'd32) begin
    pwm_shift_reg <= pwm_val_tim1;
  end
  else if (timerC_irq == 1'b1) begin
    pwm_shift_reg[31:0] <= {1'b0, pwm_shift_reg[31:1]};
  end
end

assign pwm_out = pwm_shift_reg[0];

endmodule
