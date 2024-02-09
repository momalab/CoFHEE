
module mod_mul #(
  parameter NBITS = 128,
  parameter PBITS = 0

 ) (
  input               clk,
  input               rst_n,
  input               enable_p,
  input               nmul,
  input  [NBITS-1 :0] a,
  input  [NBITS-1 :0] b,
  input  [NBITS-1 :0] m,
  input  [NBITS+32-1 :0] md,
  input  [2*$clog2(NBITS)-1 :0] k,
  output [NBITS-1 :0] y,
  output [2*NBITS-1 :0] y_nom_mul,
  output              done_irq_p,
  output              done_nom_mul
);



nom_mul #(
  .NBITS (NBITS),
  .PBITS (0)
 ) u_nom_mul_inst  (
  .clk           (clk),          //input                 
  .rst_n         (rst_n),        //input                 
  .enable_p      (enable_p),     //input                 
  .a             (a),            //input  [NBITS-1 :0]   
  .b             (b),            //input  [NBITS-1 :0]   
  .y             (y_nom_mul),    //output [2*NBITS-1 :0] 
  .done          (done_nom_mul)      //output  reg           
);

barrett_red  #(
  .NBITS (NBITS),
  .PBITS (0)
 ) u_barrett_red_inst (
  .clk           (clk),                      //input                   
  .rst_n         (rst_n),                    //input                   
  .enable_p      (~nmul & done_nom_mul),     //input                   
  .a             (y_nom_mul),                //input  [2*NBITS-1 :0]   
  .m             (m),                        //input  [NBITS-1 :0]     
  .k             (k),                        //input  [NBITS+15:0]     
  .md            (md),                       //input  [7:0]            
  .done          (done_barret),               //output reg              
  .y             (y)                         //)                          //output reg [NBITS-1 :0] 
);

assign done_irq_p = nmul ? done_nom_mul : done_barret;



endmodule
