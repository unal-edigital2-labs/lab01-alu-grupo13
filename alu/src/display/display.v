`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.03.2021 21:42:23
// Design Name: 
// Module Name: display
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module display(clk, num, an, pin, done);
input done;
input clk;
input [11:0]num;

output reg [3:0]an = 0;
output [6:0]pin;

wire clk10k;
reg [3:0]val = 0;
reg [1:0]selector = 0;

wire [3:0]ones;
wire [3:0]tens;


Frec10khz clk10(clk, clk10k);
BCDtoSSeg bcd(val, pin);
BinToBCD2Dig(clk, num[5:0], ones, tens, done);


parameter DISPLAY1 = 0, DISPLAY2 = 1, DISPLAY3 = 2, DISPLAY4 = 3;
always @(posedge clk10k)begin
selector = selector + 'd1;
    case(selector)
        DISPLAY1:  begin
                   an = 4'b1110;
                   val = num[11:9];
                   end
        DISPLAY2:  begin 
                   an = 4'b1101;
                   val = num[8:6];
                   end
        DISPLAY3:  begin
                   an = 4'b1011;
                   val = tens;
                   end
        DISPLAY4:  begin 
                   an = 4'b0111;
                   val = ones;
                   end
        endcase
end

endmodule
