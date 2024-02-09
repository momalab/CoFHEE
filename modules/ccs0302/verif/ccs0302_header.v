parameter SRAM_BASE       = 32'h20000000;
parameter FHEMEM0_BASE    = 32'h21000000;
parameter FHEMEM1_BASE    = 32'h22000000;
parameter FHEMEM2_BASE    = 32'h23000000;
parameter FHEMEM3_BASE    = 32'h24000000;
parameter FHEMEM4_BASE    = 32'h25000000;
parameter FHEMEM5_BASE    = 32'h26000000;
parameter FHEMEM6_BASE    = 32'h27000000;
parameter FHEMEM0_DP_BASE = 32'h31000000;
parameter FHEMEM1_DP_BASE = 32'h32000000;
parameter FHEMEM2_DP_BASE = 32'h33000000;

parameter GPCFG_BASE    = 32'h42000000;
parameter GPIO_BASE     = 32'h43000000;
parameter MULTPOOL_BASE = 32'h46000000;

parameter GPCFG_UARTMTX_PAD_CTL  = GPCFG_BASE + 16'h0000;  //3
parameter GPCFG_UARTMRX_PAD_CTL  = GPCFG_BASE + 16'h0004;  //4
parameter GPCFG_UARTSTX_PAD_CTL  = GPCFG_BASE + 16'h0008;  //5
parameter GPCFG_UARTSRX_PAD_CTL  = GPCFG_BASE + 16'h000C;  //6
parameter GPCFG_SPICLK_PAD_CTL   = GPCFG_BASE + 16'h0010;  //7
parameter GPCFG_SPICSN_PAD_CTL   = GPCFG_BASE + 16'h0014;  //8
parameter GPCFG_HOSTIRQ_PAD_CTL  = GPCFG_BASE + 16'h0018;  //9
parameter GPCFG_GPIO0_PAD_CTL    = GPCFG_BASE + 16'h001C;  //10
parameter GPCFG_PAD11_PAD_CTL    = GPCFG_BASE + 16'h0020;  //11
parameter GPCFG_PAD12_PAD_CTL    = GPCFG_BASE + 16'h0024;  //12
parameter GPCFG_PAD13_PAD_CTL    = GPCFG_BASE + 16'h0028;  //13
parameter GPCFG_PAD14_PAD_CTL    = GPCFG_BASE + 16'h002c;  //14
parameter GPCFG_PAD15_PAD_CTL    = GPCFG_BASE + 16'h0030;  //15
parameter GPCFG_PAD16_PAD_CTL    = GPCFG_BASE + 16'h0034;  //16
parameter GPCFG_PAD17_PAD_CTL    = GPCFG_BASE + 16'h0038;  //17
parameter GPCFG_PAD18_PAD_CTL    = GPCFG_BASE + 16'h003c;  //18
parameter GPCFG_PAD19_PAD_CTL    = GPCFG_BASE + 16'h0040;  //19
parameter GPCFG_PAD20_PAD_CTL    = GPCFG_BASE + 16'h0044;  //20
parameter GPCFG_SPIMOSI_PAD_CTL  = GPCFG_BASE + 16'h0008;  //21
parameter GPCFG_SPIMISO_PAD_CTL  = GPCFG_BASE + 16'h000C;  //22

parameter GPCFG_UARTM_BAUD_CTL   = GPCFG_BASE + 16'h0044;
parameter GPCFG_UARTM_CTL        = GPCFG_BASE + 16'h0048;

parameter GPCFG_SP_ADDR          = GPCFG_BASE + 16'h004c;
parameter GPCFG_RESET_ADDR       = GPCFG_BASE + 16'h0050;
parameter GPCFG_NMI_ADDR         = GPCFG_BASE + 16'h0054;
parameter GPCFG_FAULT_ADDR       = GPCFG_BASE + 16'h0058;
parameter GPCFG_IRQ0_ADDR        = GPCFG_BASE + 16'h005c;
parameter GPCFG_IRQ1_ADDR        = GPCFG_BASE + 16'h0060;
parameter GPCFG_IRQ2_ADDR        = GPCFG_BASE + 16'h0064;
parameter GPCFG_IRQ3_ADDR        = GPCFG_BASE + 16'h0068;
parameter GPCFG_GPT_EN           = GPCFG_BASE + 16'h006c;
parameter GPCFG_GPTA_CFG         = GPCFG_BASE + 16'h0070;
parameter GPCFG_GPTB_CFG         = GPCFG_BASE + 16'h0074;
parameter GPCFG_GPTC_CFG         = GPCFG_BASE + 16'h0078;
parameter GPCFG_WDT_EN           = GPCFG_BASE + 16'h007c;
parameter GPCFG_WDT_CFG          = GPCFG_BASE + 16'h0080;
parameter GPCFG_WDT_NMI_CFG      = GPCFG_BASE + 16'h0084;

parameter GPCFG_UARTS_BAUD_CTL   = GPCFG_BASE + 16'h0088;
parameter GPCFG_UARTS_CTL        = GPCFG_BASE + 16'h008c;
parameter GPCFG_UARTS_TXDATA     = GPCFG_BASE + 16'h0090;
parameter GPCFG_UARTS_RXDATA     = GPCFG_BASE + 16'h0094;
parameter GPCFG_UARTS_TXSEND     = GPCFG_BASE + 16'h0098;
parameter GPCFG_SPARE0           = GPCFG_BASE + 16'h009c;
parameter GPCFG_SPARE1           = GPCFG_BASE + 16'h00a0;
parameter GPCFG_SPARE2           = GPCFG_BASE + 16'h00a4;
parameter GPCFG_FHECTL2          = GPCFG_BASE + 16'h00a8;

parameter CLEQCTL2_LOG2OFN       = 12'hFFF << 0;

parameter GPCFG_KEY_REG0         = GPCFG_BASE + 16'h00ac;
parameter GPCFG_KEY_REG1         = GPCFG_BASE + 16'h00b0;
parameter GPCFG_KEY_REG2         = GPCFG_BASE + 16'h00b4;
parameter GPCFG_KEY_REG3         = GPCFG_BASE + 16'h00b8;
parameter GPCFG_KEY_REG4         = GPCFG_BASE + 16'h00bc;
parameter GPCFG_KEY_REG5         = GPCFG_BASE + 16'h00c0;
parameter GPCFG_KEY_REG6         = GPCFG_BASE + 16'h00c4;
parameter GPCFG_KEY_REG7         = GPCFG_BASE + 16'h00c8;

parameter GPCFG_SIGNATURE        = GPCFG_BASE + 16'h00cc;

parameter GPCFG_IRQQ4_ADDR       = GPCFG_BASE + 16'h00D0;   //IRQQ4_ADDR
parameter GPCFG_IRQQ5_ADDR       = GPCFG_BASE + 16'h00D4;   //IRQQ5_ADDR
parameter GPCFG_IRQQ6_ADDR       = GPCFG_BASE + 16'h00D8;   //IRQQ6_ADDR
parameter GPCFG_IRQQ7_ADDR       = GPCFG_BASE + 16'h00DC;   //IRQQ7_ADDR
parameter GPCFG_IRQQ8_ADDR       = GPCFG_BASE + 16'h00E0;   //IRQQ8_ADDR
parameter GPCFG_IRQQ9_ADDR       = GPCFG_BASE + 16'h00E4;   //IRQQ9_ADDR
parameter GPCFG_IRQQ10_ADDR      = GPCFG_BASE + 16'h00E8;   //IRQQ10_ADDR
parameter GPCFG_IRQQ11_ADDR      = GPCFG_BASE + 16'h00EC;   //IRQQ11_ADDR
parameter GPCFG_IRQQ12_ADDR      = GPCFG_BASE + 16'h00F0;   //IRQQ12_ADDR
parameter GPCFG_IRQQ13_ADDR      = GPCFG_BASE + 16'h00F4;   //IRQQ13_ADDR
parameter GPCFG_IRQQ14_ADDR      = GPCFG_BASE + 16'h00F8;   //IRQQ14_ADDR
parameter GPCFG_IRQQ15_ADDR      = GPCFG_BASE + 16'h00FC;   //IRQQ15_ADDR

parameter GPCFG_FIXROEN          = GPCFG_BASE + 16'h0100;
parameter GPCFG_VARROEN          = GPCFG_BASE + 16'h0104;
parameter GPCFG_RO1DIV           = GPCFG_BASE + 16'h0108;
parameter GPCFG_RO2DIV           = GPCFG_BASE + 16'h010C;
parameter GPCFG_RO3DIV           = GPCFG_BASE + 16'h0110;
parameter GPCFG_RO4DIV           = GPCFG_BASE + 16'h0114;

parameter GPCFG_AESDATIN0        = GPCFG_BASE + 16'h0118;
parameter GPCFG_AESDATIN1        = GPCFG_BASE + 16'h011C;
parameter GPCFG_AESDATIN2        = GPCFG_BASE + 16'h0120;
parameter GPCFG_AESDATIN3        = GPCFG_BASE + 16'h0124;
parameter GPCFG_AESKEYIN0        = GPCFG_BASE + 16'h0128;
parameter GPCFG_AESKEYIN1        = GPCFG_BASE + 16'h012C;
parameter GPCFG_AESKEYIN2        = GPCFG_BASE + 16'h0130;
parameter GPCFG_AESKEYIN3        = GPCFG_BASE + 16'h0134;
parameter GPCFG_AESCTL           = GPCFG_BASE + 16'h0138;
parameter GPCFG_AESCTL_P         = GPCFG_BASE + 16'h013C;
parameter GPCFG_AESDATOUT0       = GPCFG_BASE + 16'h0140;
parameter GPCFG_AESDATOUT1       = GPCFG_BASE + 16'h0144;
parameter GPCFG_AESDATOUT2       = GPCFG_BASE + 16'h0148;
parameter GPCFG_AESDATOUT3       = GPCFG_BASE + 16'h014C;
parameter GPCFG_AESKEYOUT0       = GPCFG_BASE + 16'h0150;
parameter GPCFG_AESKEYOUT1       = GPCFG_BASE + 16'h0154;
parameter GPCFG_AESKEYOUT2       = GPCFG_BASE + 16'h0158;
parameter GPCFG_AESKEYOUT3       = GPCFG_BASE + 16'h015C;
parameter GPCFG88_ADDR           = GPCFG_BASE + 16'h0160;
parameter GPCFG89_ADDR           = GPCFG_BASE + 16'h0164;
parameter GPCFG90_ADDR           = GPCFG_BASE + 16'h0168;
parameter GPCFG91_ADDR           = GPCFG_BASE + 16'h016C;

parameter  GPCFG_FHECTLP_ADDR     = GPCFG_BASE + 16'h8000;
parameter  CLCTLP_ENMODMUL       = 1 << 0;
parameter  CLCTLP_ENMODEXP       = 1 << 1;
parameter  CLCTLP_ENEXTGCD       = 1 << 2;
parameter  CLCTLP_ENGFUNC        = 1 << 3;
parameter  CLCTLP_ENHWRNG        = 1 << 4;
parameter  CLCTLP_CLRHIRQ        = 1 << 8;
parameter  CLCTLP_UPDTRNG        = 1 << 9;

parameter  GPCFG_FHECTL_ADDR     = GPCFG_BASE + 16'h8004;
parameter  CLCTL_MAXBITS         = 4095 << 0;
parameter  CLCTL_NFUSED          = 1    << 12;
parameter  CLCTL_NSQFUSED        = 1    << 12;
parameter  CLCTL_FKFUSED         = 1    << 12;
parameter  CLCTL_MODNSQ          = 1    << 13;
parameter  CLCTL_BYPVN           = 1    << 14;
parameter  CLCTL_HWRAND          = 1    << 15;
parameter  CLCTL_GCDARGB         = 1    << 16;
parameter  CLCTL_RNGERRCNT       = 255  << 24;
           
parameter  GPCFG_FHESTATUS_ADDR   = GPCFG_BASE + 16'h8008;
parameter  GPCFG_FHECTL3_ADDR     = GPCFG_BASE + 16'h800C;
parameter  GPCFG_PADTESTOUT_ADDR  = GPCFG_BASE + 16'h8010;
parameter  GPCFG_PADTESTIN_ADDR   = GPCFG_BASE + 16'h8014;
parameter  GPCFG_COMMNDFIFO_ADDR  = GPCFG_BASE + 16'h8018;

parameter  GPCFG_DMASRC_ADDR      = GPCFG_BASE + 16'h801C;
parameter  GPCFG_DMADST_ADDR      = GPCFG_BASE + 16'h8020;
parameter  GPCFG_DMACTL_ADDR      = GPCFG_BASE + 16'h8024;
parameter  GPCFG_PLLCTL_ADDR      = GPCFG_BASE + 16'h8028;
parameter  GPCFG_GPCTL0_ADDR      = GPCFG_BASE + 16'h802C;
parameter  GPCFG_GPCTL1_ADDR      = GPCFG_BASE + 16'h8030;

parameter [31:0] GPCFG_N_ADDR [0:31] ='{GPCFG_BASE + 16'h9000,
                                        GPCFG_BASE + 16'h9004,
                                        GPCFG_BASE + 16'h9008,
                                        GPCFG_BASE + 16'h900C,
                                        GPCFG_BASE + 16'h9010,
                                        GPCFG_BASE + 16'h9014,
                                        GPCFG_BASE + 16'h9018,
                                        GPCFG_BASE + 16'h901C,
                                        GPCFG_BASE + 16'h9020,
                                        GPCFG_BASE + 16'h9024,
                                        GPCFG_BASE + 16'h9028,
                                        GPCFG_BASE + 16'h902C,
                                        GPCFG_BASE + 16'h9030,
                                        GPCFG_BASE + 16'h9034,
                                        GPCFG_BASE + 16'h9038,
                                        GPCFG_BASE + 16'h903C,
                                        GPCFG_BASE + 16'h9040,
                                        GPCFG_BASE + 16'h9044,
                                        GPCFG_BASE + 16'h9048,
                                        GPCFG_BASE + 16'h904C,
                                        GPCFG_BASE + 16'h9050,
                                        GPCFG_BASE + 16'h9054,
                                        GPCFG_BASE + 16'h9058,
                                        GPCFG_BASE + 16'h905C,
                                        GPCFG_BASE + 16'h9060,
                                        GPCFG_BASE + 16'h9064,
                                        GPCFG_BASE + 16'h9068,
                                        GPCFG_BASE + 16'h906C,
                                        GPCFG_BASE + 16'h9070,
                                        GPCFG_BASE + 16'h9074,
                                        GPCFG_BASE + 16'h9078,
                                        GPCFG_BASE + 16'h907C};


  parameter [31:0] GPCFG_NINV_ADDR[0:31]  = '{GPCFG_BASE + 16'h9080,
                                           GPCFG_BASE + 16'h9084,
                                           GPCFG_BASE + 16'h9088,
                                           GPCFG_BASE + 16'h908C,
                                           GPCFG_BASE + 16'h9090,
                                           GPCFG_BASE + 16'h9094,
                                           GPCFG_BASE + 16'h9098,
                                           GPCFG_BASE + 16'h909C,
                                           GPCFG_BASE + 16'h90A0,
                                           GPCFG_BASE + 16'h90A4,
                                           GPCFG_BASE + 16'h90A8,
                                           GPCFG_BASE + 16'h90AC,
                                           GPCFG_BASE + 16'h90B0,
                                           GPCFG_BASE + 16'h90B4,
                                           GPCFG_BASE + 16'h90B8,
                                           GPCFG_BASE + 16'h90BC,
                                           GPCFG_BASE + 16'h90C0,
                                           GPCFG_BASE + 16'h90C4,
                                           GPCFG_BASE + 16'h90C8,
                                           GPCFG_BASE + 16'h90CC,
                                           GPCFG_BASE + 16'h90D0,
                                           GPCFG_BASE + 16'h90D4,
                                           GPCFG_BASE + 16'h90D8,
                                           GPCFG_BASE + 16'h90DC,
                                           GPCFG_BASE + 16'h90E0,
                                           GPCFG_BASE + 16'h90E4,
                                           GPCFG_BASE + 16'h90E8,
                                           GPCFG_BASE + 16'h90EC,
                                           GPCFG_BASE + 16'h90F0,
                                           GPCFG_BASE + 16'h90F4,
                                           GPCFG_BASE + 16'h90F8,
                                           GPCFG_BASE + 16'h90FC};

  parameter [31:0]  GPCFG_NSQ_ADDR[0:63]   = '{GPCFG_BASE + 16'h9100,
                                               GPCFG_BASE + 16'h9104,
                                               GPCFG_BASE + 16'h9108,
                                               GPCFG_BASE + 16'h910C,
                                               GPCFG_BASE + 16'h9110,
                                               GPCFG_BASE + 16'h9114,
                                               GPCFG_BASE + 16'h9118,
                                               GPCFG_BASE + 16'h911C,
                                               GPCFG_BASE + 16'h9120,
                                               GPCFG_BASE + 16'h9124,
                                               GPCFG_BASE + 16'h9128,
                                               GPCFG_BASE + 16'h912C,
                                               GPCFG_BASE + 16'h9130,
                                               GPCFG_BASE + 16'h9134,
                                               GPCFG_BASE + 16'h9138,
                                               GPCFG_BASE + 16'h913C,
                                               GPCFG_BASE + 16'h9140,
                                               GPCFG_BASE + 16'h9144,
                                               GPCFG_BASE + 16'h9148,
                                               GPCFG_BASE + 16'h914C,
                                               GPCFG_BASE + 16'h9150,
                                               GPCFG_BASE + 16'h9154,
                                               GPCFG_BASE + 16'h9158,
                                               GPCFG_BASE + 16'h915C,
                                               GPCFG_BASE + 16'h9160,
                                               GPCFG_BASE + 16'h9164,
                                               GPCFG_BASE + 16'h9168,
                                               GPCFG_BASE + 16'h916C,
                                               GPCFG_BASE + 16'h9170,
                                               GPCFG_BASE + 16'h9174,
                                               GPCFG_BASE + 16'h9178,
                                               GPCFG_BASE + 16'h917C,
                                               GPCFG_BASE + 16'h9180,
                                               GPCFG_BASE + 16'h9184,
                                               GPCFG_BASE + 16'h9188,
                                               GPCFG_BASE + 16'h918C,
                                               GPCFG_BASE + 16'h9190,
                                               GPCFG_BASE + 16'h9194,
                                               GPCFG_BASE + 16'h9198,
                                               GPCFG_BASE + 16'h919C,
                                               GPCFG_BASE + 16'h91A0,
                                               GPCFG_BASE + 16'h91A4,
                                               GPCFG_BASE + 16'h91A8,
                                               GPCFG_BASE + 16'h91AC,
                                               GPCFG_BASE + 16'h91B0,
                                               GPCFG_BASE + 16'h91B4,
                                               GPCFG_BASE + 16'h91B8,
                                               GPCFG_BASE + 16'h91BC,
                                               GPCFG_BASE + 16'h91C0,
                                               GPCFG_BASE + 16'h91C4,
                                               GPCFG_BASE + 16'h91C8,
                                               GPCFG_BASE + 16'h91CC,
                                               GPCFG_BASE + 16'h91D0,
                                               GPCFG_BASE + 16'h91D4,
                                               GPCFG_BASE + 16'h91D8,
                                               GPCFG_BASE + 16'h91DC,
                                               GPCFG_BASE + 16'h91E0,
                                               GPCFG_BASE + 16'h91E4,
                                               GPCFG_BASE + 16'h91E8,
                                               GPCFG_BASE + 16'h91EC,
                                               GPCFG_BASE + 16'h91F0,
                                               GPCFG_BASE + 16'h91F4,
                                               GPCFG_BASE + 16'h91F8,
                                               GPCFG_BASE + 16'h91FC};

  parameter [31:0]  GPCFG_FKF_ADDR[0:63]   = '{GPCFG_BASE + 16'h9200,
                                               GPCFG_BASE + 16'h9204,
                                               GPCFG_BASE + 16'h9208,
                                               GPCFG_BASE + 16'h920C,
                                               GPCFG_BASE + 16'h9210,
                                               GPCFG_BASE + 16'h9214,
                                               GPCFG_BASE + 16'h9218,
                                               GPCFG_BASE + 16'h921C,
                                               GPCFG_BASE + 16'h9220,
                                               GPCFG_BASE + 16'h9224,
                                               GPCFG_BASE + 16'h9228,
                                               GPCFG_BASE + 16'h922C,
                                               GPCFG_BASE + 16'h9230,
                                               GPCFG_BASE + 16'h9234,
                                               GPCFG_BASE + 16'h9238,
                                               GPCFG_BASE + 16'h923C,
                                               GPCFG_BASE + 16'h9240,
                                               GPCFG_BASE + 16'h9244,
                                               GPCFG_BASE + 16'h9248,
                                               GPCFG_BASE + 16'h924C,
                                               GPCFG_BASE + 16'h9250,
                                               GPCFG_BASE + 16'h9254,
                                               GPCFG_BASE + 16'h9258,
                                               GPCFG_BASE + 16'h925C,
                                               GPCFG_BASE + 16'h9260,
                                               GPCFG_BASE + 16'h9264,
                                               GPCFG_BASE + 16'h9268,
                                               GPCFG_BASE + 16'h926C,
                                               GPCFG_BASE + 16'h9270,
                                               GPCFG_BASE + 16'h9274,
                                               GPCFG_BASE + 16'h9278,
                                               GPCFG_BASE + 16'h927C,
                                               GPCFG_BASE + 16'h9280,
                                               GPCFG_BASE + 16'h9284,
                                               GPCFG_BASE + 16'h9288,
                                               GPCFG_BASE + 16'h928C,
                                               GPCFG_BASE + 16'h9290,
                                               GPCFG_BASE + 16'h9294,
                                               GPCFG_BASE + 16'h9298,
                                               GPCFG_BASE + 16'h929C,
                                               GPCFG_BASE + 16'h92A0,
                                               GPCFG_BASE + 16'h92A4,
                                               GPCFG_BASE + 16'h92A8,
                                               GPCFG_BASE + 16'h92AC,
                                               GPCFG_BASE + 16'h92B0,
                                               GPCFG_BASE + 16'h92B4,
                                               GPCFG_BASE + 16'h92B8,
                                               GPCFG_BASE + 16'h92BC,
                                               GPCFG_BASE + 16'h92C0,
                                               GPCFG_BASE + 16'h92C4,
                                               GPCFG_BASE + 16'h92C8,
                                               GPCFG_BASE + 16'h92CC,
                                               GPCFG_BASE + 16'h92D0,
                                               GPCFG_BASE + 16'h92D4,
                                               GPCFG_BASE + 16'h92D8,
                                               GPCFG_BASE + 16'h92DC,
                                               GPCFG_BASE + 16'h92E0,
                                               GPCFG_BASE + 16'h92E4,
                                               GPCFG_BASE + 16'h92E8,
                                               GPCFG_BASE + 16'h92EC,
                                               GPCFG_BASE + 16'h92F0,
                                               GPCFG_BASE + 16'h92F4,
                                               GPCFG_BASE + 16'h92F8,
                                               GPCFG_BASE + 16'h92FC};

  parameter [31:0]  GPCFG_ARGA_ADDR[0:63]   = '{GPCFG_BASE + 16'h9300,
                                                GPCFG_BASE + 16'h9304,
                                                GPCFG_BASE + 16'h9308,
                                                GPCFG_BASE + 16'h930C,
                                                GPCFG_BASE + 16'h9310,
                                                GPCFG_BASE + 16'h9314,
                                                GPCFG_BASE + 16'h9318,
                                                GPCFG_BASE + 16'h931C,
                                                GPCFG_BASE + 16'h9320,
                                                GPCFG_BASE + 16'h9324,
                                                GPCFG_BASE + 16'h9328,
                                                GPCFG_BASE + 16'h932C,
                                                GPCFG_BASE + 16'h9330,
                                                GPCFG_BASE + 16'h9334,
                                                GPCFG_BASE + 16'h9338,
                                                GPCFG_BASE + 16'h933C,
                                                GPCFG_BASE + 16'h9340,
                                                GPCFG_BASE + 16'h9344,
                                                GPCFG_BASE + 16'h9348,
                                                GPCFG_BASE + 16'h934C,
                                                GPCFG_BASE + 16'h9350,
                                                GPCFG_BASE + 16'h9354,
                                                GPCFG_BASE + 16'h9358,
                                                GPCFG_BASE + 16'h935C,
                                                GPCFG_BASE + 16'h9360,
                                                GPCFG_BASE + 16'h9364,
                                                GPCFG_BASE + 16'h9368,
                                                GPCFG_BASE + 16'h936C,
                                                GPCFG_BASE + 16'h9370,
                                                GPCFG_BASE + 16'h9374,
                                                GPCFG_BASE + 16'h9378,
                                                GPCFG_BASE + 16'h937C,
                                                GPCFG_BASE + 16'h9380,
                                                GPCFG_BASE + 16'h9384,
                                                GPCFG_BASE + 16'h9388,
                                                GPCFG_BASE + 16'h938C,
                                                GPCFG_BASE + 16'h9390,
                                                GPCFG_BASE + 16'h9394,
                                                GPCFG_BASE + 16'h9398,
                                                GPCFG_BASE + 16'h939C,
                                                GPCFG_BASE + 16'h93A0,
                                                GPCFG_BASE + 16'h93A4,
                                                GPCFG_BASE + 16'h93A8,
                                                GPCFG_BASE + 16'h93AC,
                                                GPCFG_BASE + 16'h93B0,
                                                GPCFG_BASE + 16'h93B4,
                                                GPCFG_BASE + 16'h93B8,
                                                GPCFG_BASE + 16'h93BC,
                                                GPCFG_BASE + 16'h93C0,
                                                GPCFG_BASE + 16'h93C4,
                                                GPCFG_BASE + 16'h93C8,
                                                GPCFG_BASE + 16'h93CC,
                                                GPCFG_BASE + 16'h93D0,
                                                GPCFG_BASE + 16'h93D4,
                                                GPCFG_BASE + 16'h93D8,
                                                GPCFG_BASE + 16'h93DC,
                                                GPCFG_BASE + 16'h93E0,
                                                GPCFG_BASE + 16'h93E4,
                                                GPCFG_BASE + 16'h93E8,
                                                GPCFG_BASE + 16'h93EC,
                                                GPCFG_BASE + 16'h93F0,
                                                GPCFG_BASE + 16'h93F4,
                                                GPCFG_BASE + 16'h93F8,
                                                GPCFG_BASE + 16'h93FC};

  parameter [31:0]  GPCFG_ARGB_ADDR[0:63]   = '{GPCFG_BASE + 16'h9400,
                                                GPCFG_BASE + 16'h9404,
                                                GPCFG_BASE + 16'h9408,
                                                GPCFG_BASE + 16'h940C,
                                                GPCFG_BASE + 16'h9410,
                                                GPCFG_BASE + 16'h9414,
                                                GPCFG_BASE + 16'h9418,
                                                GPCFG_BASE + 16'h941C,
                                                GPCFG_BASE + 16'h9420,
                                                GPCFG_BASE + 16'h9424,
                                                GPCFG_BASE + 16'h9428,
                                                GPCFG_BASE + 16'h942C,
                                                GPCFG_BASE + 16'h9430,
                                                GPCFG_BASE + 16'h9434,
                                                GPCFG_BASE + 16'h9438,
                                                GPCFG_BASE + 16'h943C,
                                                GPCFG_BASE + 16'h9440,
                                                GPCFG_BASE + 16'h9444,
                                                GPCFG_BASE + 16'h9448,
                                                GPCFG_BASE + 16'h944C,
                                                GPCFG_BASE + 16'h9450,
                                                GPCFG_BASE + 16'h9454,
                                                GPCFG_BASE + 16'h9458,
                                                GPCFG_BASE + 16'h945C,
                                                GPCFG_BASE + 16'h9460,
                                                GPCFG_BASE + 16'h9464,
                                                GPCFG_BASE + 16'h9468,
                                                GPCFG_BASE + 16'h946C,
                                                GPCFG_BASE + 16'h9470,
                                                GPCFG_BASE + 16'h9474,
                                                GPCFG_BASE + 16'h9478,
                                                GPCFG_BASE + 16'h947C,
                                                GPCFG_BASE + 16'h9480,
                                                GPCFG_BASE + 16'h9484,
                                                GPCFG_BASE + 16'h9488,
                                                GPCFG_BASE + 16'h948C,
                                                GPCFG_BASE + 16'h9490,
                                                GPCFG_BASE + 16'h9494,
                                                GPCFG_BASE + 16'h9498,
                                                GPCFG_BASE + 16'h949C,
                                                GPCFG_BASE + 16'h94A0,
                                                GPCFG_BASE + 16'h94A4,
                                                GPCFG_BASE + 16'h94A8,
                                                GPCFG_BASE + 16'h94AC,
                                                GPCFG_BASE + 16'h94B0,
                                                GPCFG_BASE + 16'h94B4,
                                                GPCFG_BASE + 16'h94B8,
                                                GPCFG_BASE + 16'h94BC,
                                                GPCFG_BASE + 16'h94C0,
                                                GPCFG_BASE + 16'h94C4,
                                                GPCFG_BASE + 16'h94C8,
                                                GPCFG_BASE + 16'h94CC,
                                                GPCFG_BASE + 16'h94D0,
                                                GPCFG_BASE + 16'h94D4,
                                                GPCFG_BASE + 16'h94D8,
                                                GPCFG_BASE + 16'h94DC,
                                                GPCFG_BASE + 16'h94E0,
                                                GPCFG_BASE + 16'h94E4,
                                                GPCFG_BASE + 16'h94E8,
                                                GPCFG_BASE + 16'h94EC,
                                                GPCFG_BASE + 16'h94F0,
                                                GPCFG_BASE + 16'h94F4,
                                                GPCFG_BASE + 16'h94F8,
                                                GPCFG_BASE + 16'h94FC};

  parameter [31:0]  GPCFG_ARGC_ADDR[0:63]   = '{GPCFG_BASE + 16'h9500,
                                                GPCFG_BASE + 16'h9504,
                                                GPCFG_BASE + 16'h9508,
                                                GPCFG_BASE + 16'h950C,
                                                GPCFG_BASE + 16'h9510,
                                                GPCFG_BASE + 16'h9514,
                                                GPCFG_BASE + 16'h9518,
                                                GPCFG_BASE + 16'h951C,
                                                GPCFG_BASE + 16'h9520,
                                                GPCFG_BASE + 16'h9524,
                                                GPCFG_BASE + 16'h9528,
                                                GPCFG_BASE + 16'h952C,
                                                GPCFG_BASE + 16'h9530,
                                                GPCFG_BASE + 16'h9534,
                                                GPCFG_BASE + 16'h9538,
                                                GPCFG_BASE + 16'h953C,
                                                GPCFG_BASE + 16'h9540,
                                                GPCFG_BASE + 16'h9544,
                                                GPCFG_BASE + 16'h9548,
                                                GPCFG_BASE + 16'h954C,
                                                GPCFG_BASE + 16'h9550,
                                                GPCFG_BASE + 16'h9554,
                                                GPCFG_BASE + 16'h9558,
                                                GPCFG_BASE + 16'h955C,
                                                GPCFG_BASE + 16'h9560,
                                                GPCFG_BASE + 16'h9564,
                                                GPCFG_BASE + 16'h9568,
                                                GPCFG_BASE + 16'h956C,
                                                GPCFG_BASE + 16'h9570,
                                                GPCFG_BASE + 16'h9574,
                                                GPCFG_BASE + 16'h9578,
                                                GPCFG_BASE + 16'h957C,
                                                GPCFG_BASE + 16'h9580,
                                                GPCFG_BASE + 16'h9584,
                                                GPCFG_BASE + 16'h9588,
                                                GPCFG_BASE + 16'h958C,
                                                GPCFG_BASE + 16'h9590,
                                                GPCFG_BASE + 16'h9594,
                                                GPCFG_BASE + 16'h9598,
                                                GPCFG_BASE + 16'h959C,
                                                GPCFG_BASE + 16'h95A0,
                                                GPCFG_BASE + 16'h95A4,
                                                GPCFG_BASE + 16'h95A8,
                                                GPCFG_BASE + 16'h95AC,
                                                GPCFG_BASE + 16'h95B0,
                                                GPCFG_BASE + 16'h95B4,
                                                GPCFG_BASE + 16'h95B8,
                                                GPCFG_BASE + 16'h95BC,
                                                GPCFG_BASE + 16'h95C0,
                                                GPCFG_BASE + 16'h95C4,
                                                GPCFG_BASE + 16'h95C8,
                                                GPCFG_BASE + 16'h95CC,
                                                GPCFG_BASE + 16'h95D0,
                                                GPCFG_BASE + 16'h95D4,
                                                GPCFG_BASE + 16'h95D8,
                                                GPCFG_BASE + 16'h95DC,
                                                GPCFG_BASE + 16'h95E0,
                                                GPCFG_BASE + 16'h95E4,
                                                GPCFG_BASE + 16'h95E8,
                                                GPCFG_BASE + 16'h95EC,
                                                GPCFG_BASE + 16'h95F0,
                                                GPCFG_BASE + 16'h95F4,
                                                GPCFG_BASE + 16'h95F8,
                                                GPCFG_BASE + 16'h95FC};
  
  parameter [31:0]  GPCFG_RAND0_ADDR[0:31]   = '{GPCFG_BASE + 16'h9600,
                                                 GPCFG_BASE + 16'h9604,
                                                 GPCFG_BASE + 16'h9608,
                                                 GPCFG_BASE + 16'h960C,
                                                 GPCFG_BASE + 16'h9610,
                                                 GPCFG_BASE + 16'h9614,
                                                 GPCFG_BASE + 16'h9618,
                                                 GPCFG_BASE + 16'h961C,
                                                 GPCFG_BASE + 16'h9620,
                                                 GPCFG_BASE + 16'h9624,
                                                 GPCFG_BASE + 16'h9628,
                                                 GPCFG_BASE + 16'h962C,
                                                 GPCFG_BASE + 16'h9630,
                                                 GPCFG_BASE + 16'h9634,
                                                 GPCFG_BASE + 16'h9638,
                                                 GPCFG_BASE + 16'h963C,
                                                 GPCFG_BASE + 16'h9640,
                                                 GPCFG_BASE + 16'h9644,
                                                 GPCFG_BASE + 16'h9648,
                                                 GPCFG_BASE + 16'h964C,
                                                 GPCFG_BASE + 16'h9650,
                                                 GPCFG_BASE + 16'h9654,
                                                 GPCFG_BASE + 16'h9658,
                                                 GPCFG_BASE + 16'h965C,
                                                 GPCFG_BASE + 16'h9660,
                                                 GPCFG_BASE + 16'h9664,
                                                 GPCFG_BASE + 16'h9668,
                                                 GPCFG_BASE + 16'h966C,
                                                 GPCFG_BASE + 16'h9670,
                                                 GPCFG_BASE + 16'h9674,
                                                 GPCFG_BASE + 16'h9678,
                                                 GPCFG_BASE + 16'h967C};

  parameter [31:0]  GPCFG_RAND1_ADDR[0:31]       = '{GPCFG_BASE + 16'h9680,
                                                     GPCFG_BASE + 16'h9684,
                                                     GPCFG_BASE + 16'h9688,
                                                     GPCFG_BASE + 16'h968C,
                                                     GPCFG_BASE + 16'h9690,
                                                     GPCFG_BASE + 16'h9694,
                                                     GPCFG_BASE + 16'h9698,
                                                     GPCFG_BASE + 16'h969C,
                                                     GPCFG_BASE + 16'h96A0,
                                                     GPCFG_BASE + 16'h96A4,
                                                     GPCFG_BASE + 16'h96A8,
                                                     GPCFG_BASE + 16'h96AC,
                                                     GPCFG_BASE + 16'h96B0,
                                                     GPCFG_BASE + 16'h96B4,
                                                     GPCFG_BASE + 16'h96B8,
                                                     GPCFG_BASE + 16'h96BC,
                                                     GPCFG_BASE + 16'h96C0,
                                                     GPCFG_BASE + 16'h96C4,
                                                     GPCFG_BASE + 16'h96C8,
                                                     GPCFG_BASE + 16'h96CC,
                                                     GPCFG_BASE + 16'h96D0,
                                                     GPCFG_BASE + 16'h96D4,
                                                     GPCFG_BASE + 16'h96D8,
                                                     GPCFG_BASE + 16'h96DC,
                                                     GPCFG_BASE + 16'h96E0,
                                                     GPCFG_BASE + 16'h96E4,
                                                     GPCFG_BASE + 16'h96E8,
                                                     GPCFG_BASE + 16'h96EC,
                                                     GPCFG_BASE + 16'h96F0,
                                                     GPCFG_BASE + 16'h96F4,
                                                     GPCFG_BASE + 16'h96F8,
                                                     GPCFG_BASE + 16'h96FC};


  parameter [31:0]   GPCFG_RES_ADDR[0:63]   = '{GPCFG_BASE + 16'h9700,
                                                GPCFG_BASE + 16'h9704,
                                                GPCFG_BASE + 16'h9708,
                                                GPCFG_BASE + 16'h970C,
                                                GPCFG_BASE + 16'h9710,
                                                GPCFG_BASE + 16'h9714,
                                                GPCFG_BASE + 16'h9718,
                                                GPCFG_BASE + 16'h971C,
                                                GPCFG_BASE + 16'h9720,
                                                GPCFG_BASE + 16'h9724,
                                                GPCFG_BASE + 16'h9728,
                                                GPCFG_BASE + 16'h972C,
                                                GPCFG_BASE + 16'h9730,
                                                GPCFG_BASE + 16'h9734,
                                                GPCFG_BASE + 16'h9738,
                                                GPCFG_BASE + 16'h973C,
                                                GPCFG_BASE + 16'h9740,
                                                GPCFG_BASE + 16'h9744,
                                                GPCFG_BASE + 16'h9748,
                                                GPCFG_BASE + 16'h974C,
                                                GPCFG_BASE + 16'h9750,
                                                GPCFG_BASE + 16'h9754,
                                                GPCFG_BASE + 16'h9758,
                                                GPCFG_BASE + 16'h975C,
                                                GPCFG_BASE + 16'h9760,
                                                GPCFG_BASE + 16'h9764,
                                                GPCFG_BASE + 16'h9768,
                                                GPCFG_BASE + 16'h976C,
                                                GPCFG_BASE + 16'h9770,
                                                GPCFG_BASE + 16'h9774,
                                                GPCFG_BASE + 16'h9778,
                                                GPCFG_BASE + 16'h977C,
                                                GPCFG_BASE + 16'h9780,
                                                GPCFG_BASE + 16'h9784,
                                                GPCFG_BASE + 16'h9788,
                                                GPCFG_BASE + 16'h978C,
                                                GPCFG_BASE + 16'h9790,
                                                GPCFG_BASE + 16'h9794,
                                                GPCFG_BASE + 16'h9798,
                                                GPCFG_BASE + 16'h979C,
                                                GPCFG_BASE + 16'h97A0,
                                                GPCFG_BASE + 16'h97A4,
                                                GPCFG_BASE + 16'h97A8,
                                                GPCFG_BASE + 16'h97AC,
                                                GPCFG_BASE + 16'h97B0,
                                                GPCFG_BASE + 16'h97B4,
                                                GPCFG_BASE + 16'h97B8,
                                                GPCFG_BASE + 16'h97BC,
                                                GPCFG_BASE + 16'h97C0,
                                                GPCFG_BASE + 16'h97C4,
                                                GPCFG_BASE + 16'h97C8,
                                                GPCFG_BASE + 16'h97CC,
                                                GPCFG_BASE + 16'h97D0,
                                                GPCFG_BASE + 16'h97D4,
                                                GPCFG_BASE + 16'h97D8,
                                                GPCFG_BASE + 16'h97DC,
                                                GPCFG_BASE + 16'h97E0,
                                                GPCFG_BASE + 16'h97E4,
                                                GPCFG_BASE + 16'h97E8,
                                                GPCFG_BASE + 16'h97EC,
                                                GPCFG_BASE + 16'h97F0,
                                                GPCFG_BASE + 16'h97F4,
                                                GPCFG_BASE + 16'h97F8,
                                                GPCFG_BASE + 16'h97FC};


  parameter [31:0]  GPCFG_MUL_ADDR[0:63]   = '{GPCFG_BASE + 16'h9800,
                                               GPCFG_BASE + 16'h9804,
                                               GPCFG_BASE + 16'h9808,
                                               GPCFG_BASE + 16'h980C,
                                               GPCFG_BASE + 16'h9810,
                                               GPCFG_BASE + 16'h9814,
                                               GPCFG_BASE + 16'h9818,
                                               GPCFG_BASE + 16'h981C,
                                               GPCFG_BASE + 16'h9820,
                                               GPCFG_BASE + 16'h9824,
                                               GPCFG_BASE + 16'h9828,
                                               GPCFG_BASE + 16'h982C,
                                               GPCFG_BASE + 16'h9830,
                                               GPCFG_BASE + 16'h9834,
                                               GPCFG_BASE + 16'h9838,
                                               GPCFG_BASE + 16'h983C,
                                               GPCFG_BASE + 16'h9840,
                                               GPCFG_BASE + 16'h9844,
                                               GPCFG_BASE + 16'h9848,
                                               GPCFG_BASE + 16'h984C,
                                               GPCFG_BASE + 16'h9850,
                                               GPCFG_BASE + 16'h9854,
                                               GPCFG_BASE + 16'h9858,
                                               GPCFG_BASE + 16'h985C,
                                               GPCFG_BASE + 16'h9860,
                                               GPCFG_BASE + 16'h9864,
                                               GPCFG_BASE + 16'h9868,
                                               GPCFG_BASE + 16'h986C,
                                               GPCFG_BASE + 16'h9870,
                                               GPCFG_BASE + 16'h9874,
                                               GPCFG_BASE + 16'h9878,
                                               GPCFG_BASE + 16'h987C,
                                               GPCFG_BASE + 16'h9880,
                                               GPCFG_BASE + 16'h9884,
                                               GPCFG_BASE + 16'h9888,
                                               GPCFG_BASE + 16'h988C,
                                               GPCFG_BASE + 16'h9890,
                                               GPCFG_BASE + 16'h9894,
                                               GPCFG_BASE + 16'h9898,
                                               GPCFG_BASE + 16'h989C,
                                               GPCFG_BASE + 16'h98A0,
                                               GPCFG_BASE + 16'h98A4,
                                               GPCFG_BASE + 16'h98A8,
                                               GPCFG_BASE + 16'h98AC,
                                               GPCFG_BASE + 16'h98B0,
                                               GPCFG_BASE + 16'h98B4,
                                               GPCFG_BASE + 16'h98B8,
                                               GPCFG_BASE + 16'h98BC,
                                               GPCFG_BASE + 16'h98C0,
                                               GPCFG_BASE + 16'h98C4,
                                               GPCFG_BASE + 16'h98C8,
                                               GPCFG_BASE + 16'h98CC,
                                               GPCFG_BASE + 16'h98D0,
                                               GPCFG_BASE + 16'h98D4,
                                               GPCFG_BASE + 16'h98D8,
                                               GPCFG_BASE + 16'h98DC,
                                               GPCFG_BASE + 16'h98E0,
                                               GPCFG_BASE + 16'h98E4,
                                               GPCFG_BASE + 16'h98E8,
                                               GPCFG_BASE + 16'h98EC,
                                               GPCFG_BASE + 16'h98F0,
                                               GPCFG_BASE + 16'h98F4,
                                               GPCFG_BASE + 16'h98F8,
                                               GPCFG_BASE + 16'h98FC};

  parameter [31:0]  GPCFG_EXP_ADDR[0:63]   = '{GPCFG_BASE + 16'h9900,
                                               GPCFG_BASE + 16'h9904,
                                               GPCFG_BASE + 16'h9908,
                                               GPCFG_BASE + 16'h990C,
                                               GPCFG_BASE + 16'h9910,
                                               GPCFG_BASE + 16'h9914,
                                               GPCFG_BASE + 16'h9918,
                                               GPCFG_BASE + 16'h991C,
                                               GPCFG_BASE + 16'h9920,
                                               GPCFG_BASE + 16'h9924,
                                               GPCFG_BASE + 16'h9928,
                                               GPCFG_BASE + 16'h992C,
                                               GPCFG_BASE + 16'h9930,
                                               GPCFG_BASE + 16'h9934,
                                               GPCFG_BASE + 16'h9938,
                                               GPCFG_BASE + 16'h993C,
                                               GPCFG_BASE + 16'h9940,
                                               GPCFG_BASE + 16'h9944,
                                               GPCFG_BASE + 16'h9948,
                                               GPCFG_BASE + 16'h994C,
                                               GPCFG_BASE + 16'h9950,
                                               GPCFG_BASE + 16'h9954,
                                               GPCFG_BASE + 16'h9958,
                                               GPCFG_BASE + 16'h995C,
                                               GPCFG_BASE + 16'h9960,
                                               GPCFG_BASE + 16'h9964,
                                               GPCFG_BASE + 16'h9968,
                                               GPCFG_BASE + 16'h996C,
                                               GPCFG_BASE + 16'h9970,
                                               GPCFG_BASE + 16'h9974,
                                               GPCFG_BASE + 16'h9978,
                                               GPCFG_BASE + 16'h997C,
                                               GPCFG_BASE + 16'h9980,
                                               GPCFG_BASE + 16'h9984,
                                               GPCFG_BASE + 16'h9988,
                                               GPCFG_BASE + 16'h998C,
                                               GPCFG_BASE + 16'h9990,
                                               GPCFG_BASE + 16'h9994,
                                               GPCFG_BASE + 16'h9998,
                                               GPCFG_BASE + 16'h999C,
                                               GPCFG_BASE + 16'h99A0,
                                               GPCFG_BASE + 16'h99A4,
                                               GPCFG_BASE + 16'h99A8,
                                               GPCFG_BASE + 16'h99AC,
                                               GPCFG_BASE + 16'h99B0,
                                               GPCFG_BASE + 16'h99B4,
                                               GPCFG_BASE + 16'h99B8,
                                               GPCFG_BASE + 16'h99BC,
                                               GPCFG_BASE + 16'h99C0,
                                               GPCFG_BASE + 16'h99C4,
                                               GPCFG_BASE + 16'h99C8,
                                               GPCFG_BASE + 16'h99CC,
                                               GPCFG_BASE + 16'h99D0,
                                               GPCFG_BASE + 16'h99D4,
                                               GPCFG_BASE + 16'h99D8,
                                               GPCFG_BASE + 16'h99DC,
                                               GPCFG_BASE + 16'h99E0,
                                               GPCFG_BASE + 16'h99E4,
                                               GPCFG_BASE + 16'h99E8,
                                               GPCFG_BASE + 16'h99EC,
                                               GPCFG_BASE + 16'h99F0,
                                               GPCFG_BASE + 16'h99F4,
                                               GPCFG_BASE + 16'h99F8,
                                               GPCFG_BASE + 16'h99FC};

  parameter [31:0]  GPCFG_INV_ADDR[0:63]   = '{GPCFG_BASE + 16'h9A00,
                                               GPCFG_BASE + 16'h9A04,
                                               GPCFG_BASE + 16'h9A08,
                                               GPCFG_BASE + 16'h9A0C,
                                               GPCFG_BASE + 16'h9A10,
                                               GPCFG_BASE + 16'h9A14,
                                               GPCFG_BASE + 16'h9A18,
                                               GPCFG_BASE + 16'h9A1C,
                                               GPCFG_BASE + 16'h9A20,
                                               GPCFG_BASE + 16'h9A24,
                                               GPCFG_BASE + 16'h9A28,
                                               GPCFG_BASE + 16'h9A2C,
                                               GPCFG_BASE + 16'h9A30,
                                               GPCFG_BASE + 16'h9A34,
                                               GPCFG_BASE + 16'h9A38,
                                               GPCFG_BASE + 16'h9A3C,
                                               GPCFG_BASE + 16'h9A40,
                                               GPCFG_BASE + 16'h9A44,
                                               GPCFG_BASE + 16'h9A48,
                                               GPCFG_BASE + 16'h9A4C,
                                               GPCFG_BASE + 16'h9A50,
                                               GPCFG_BASE + 16'h9A54,
                                               GPCFG_BASE + 16'h9A58,
                                               GPCFG_BASE + 16'h9A5C,
                                               GPCFG_BASE + 16'h9A60,
                                               GPCFG_BASE + 16'h9A64,
                                               GPCFG_BASE + 16'h9A68,
                                               GPCFG_BASE + 16'h9A6C,
                                               GPCFG_BASE + 16'h9A70,
                                               GPCFG_BASE + 16'h9A74,
                                               GPCFG_BASE + 16'h9A78,
                                               GPCFG_BASE + 16'h9A7C,
                                               GPCFG_BASE + 16'h9A80,
                                               GPCFG_BASE + 16'h9A84,
                                               GPCFG_BASE + 16'h9A88,
                                               GPCFG_BASE + 16'h9A8C,
                                               GPCFG_BASE + 16'h9A90,
                                               GPCFG_BASE + 16'h9A94,
                                               GPCFG_BASE + 16'h9A98,
                                               GPCFG_BASE + 16'h9A9C,
                                               GPCFG_BASE + 16'h9AA0,
                                               GPCFG_BASE + 16'h9AA4,
                                               GPCFG_BASE + 16'h9AA8,
                                               GPCFG_BASE + 16'h9AAC,
                                               GPCFG_BASE + 16'h9AB0,
                                               GPCFG_BASE + 16'h9AB4,
                                               GPCFG_BASE + 16'h9AB8,
                                               GPCFG_BASE + 16'h9ABC,
                                               GPCFG_BASE + 16'h9AC0,
                                               GPCFG_BASE + 16'h9AC4,
                                               GPCFG_BASE + 16'h9AC8,
                                               GPCFG_BASE + 16'h9ACC,
                                               GPCFG_BASE + 16'h9AD0,
                                               GPCFG_BASE + 16'h9AD4,
                                               GPCFG_BASE + 16'h9AD8,
                                               GPCFG_BASE + 16'h9ADC,
                                               GPCFG_BASE + 16'h9AE0,
                                               GPCFG_BASE + 16'h9AE4,
                                               GPCFG_BASE + 16'h9AE8,
                                               GPCFG_BASE + 16'h9AEC,
                                               GPCFG_BASE + 16'h9AF0,
                                               GPCFG_BASE + 16'h9AF4,
                                               GPCFG_BASE + 16'h9AF8,
                                               GPCFG_BASE + 16'h9AFC};





parameter GPIO_GPIO0_CTL         = GPIO_BASE + 16'h0000;
parameter GPIO_GPIO0_OUT         = GPIO_BASE + 16'h0004;
parameter GPIO_GPIO0_IN          = GPIO_BASE + 16'h0008;
parameter GPIO_GPIO1_CTL         = GPIO_BASE + 16'h000c;
parameter GPIO_GPIO1_OUT         = GPIO_BASE + 16'h0010;
parameter GPIO_GPIO1_IN          = GPIO_BASE + 16'h0014;
parameter GPIO_GPIO2_CTL         = GPIO_BASE + 16'h0018;
parameter GPIO_GPIO2_OUT         = GPIO_BASE + 16'h001c;
parameter GPIO_GPIO2_IN          = GPIO_BASE + 16'h0020;
parameter GPIO_GPIO3_CTL         = GPIO_BASE + 16'h0024;
parameter GPIO_GPIO3_OUT         = GPIO_BASE + 16'h0028;
parameter GPIO_GPIO3_IN          = GPIO_BASE + 16'h002c;


