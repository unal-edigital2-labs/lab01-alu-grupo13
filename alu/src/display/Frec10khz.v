module Frec10khz (clk, clk_10khz);
input clk;
output reg clk_10khz = 0;

reg [15:0] contador = 1;

always @(posedge clk) begin
	contador = contador +1;
	if(contador=='d2_500) begin
	contador = 0;
	clk_10khz=!clk_10khz;
	end
end
endmodule