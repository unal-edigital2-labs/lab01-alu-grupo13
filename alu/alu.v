`timescale 1ns / 1ps


module alu(
    input [2:0] portA,
    input [2:0] portB,
    input [1:0] opcode,
    output [0:7] sseg,
    output [7:0] an,
    input clk,
    input rst);

// Declaraci�n de salidas de cada bloque 
wire [3:0] sal_suma;
wire [3:0] sal_resta;
wire [3:0] sal_div;
wire [5:0] sal_mult;


// Declaraci�n de las entradas init de cada bloque 
reg [3:0] init; 
reg negat = 0;
wire init_suma;
wire init_resta;
wire init_mult;
wire init_div;
wire negative;

// 

assign init_suma= init[0];
assign init_resta=init[1];
assign init_mult=init[2];
assign init_div=init[3];

reg [15:0]int_bcd;
reg done = 0;
wire d;
wire [3:0] operacion;

// descripci�n del decodificacion de operaciones
always @(*) begin
	case(opcode) 
		2'b00: init<=1;
		2'b01: init<=2;
		2'b10: init<=4;
		2'b11: init<=8;
	default:
		init <= 0;
	endcase
	
end
// Descripcion del miltiplexor
always @(*) begin
	case(opcode) 
		2'b00:  begin negat = 1'b1; int_bcd = {1'b0, portA, 1'b0, portB, 4'b0000,sal_suma}; end 
		2'b01:  begin negat = negative; int_bcd = {1'b0, portA, 1'b0, portB, 4'b0000,sal_resta};end 
		2'b10:  begin negat = 1'b1; if(d == 1) begin int_bcd = {1'b0, portA, 1'b0, portB, 2'b00 ,sal_mult};end end
		2'b11:  begin negat = 1'b1; int_bcd = {1'b0, portA, 1'b0, portB, 4'b0000,sal_div};end
	default:
		int_bcd <= 0;
	endcase
	
end



//instanciaci�n de los componnetes 

sum4b sum(. init(init_suma),.xi({1'b0,portA}), .yi({1'b0,portB}),.sal(sal_suma));
multiplicador mul ( .MR(portA), .MD(portB), .init(init_mult),.clk(clk), .pp(sal_mult), .done(d));
display dp( .num(int_bcd), .clk(clk), .sseg(sseg[0:7]), .an(an), .rst(rst), .neg(negat));

// adicone los dos bloques que hacen flata la resta y divisi�n
res4b res(.init(init_resta), .xi({1'b0,portA}), .yi({1'b0,portB}), .sal(sal_resta), .neg(negative));




endmodule
