module BinToBCD2Dig(clk, bin, ones, tens, done);
input clk;
input [5:0]bin;
input done;
output reg [3:0]ones = 0;
output reg [3:0]tens = 0;

reg [3:0]i = 0;
reg [15:0] shift_register = 0;
reg [3:0] temp_tens = 0;
reg [3:0] temp_ones = 0;

reg [5:0] old_bin = 0;

always@(posedge clk)begin
if(done)begin
if(i==0 & (old_bin != bin)) begin
	shift_register = 16'd0;
	
	old_bin = bin;

	shift_register[5:0] = bin;
	temp_tens = shift_register[15:12];
	temp_ones = shift_register[11:8];
	i=i+1;
end
if(i<9 & i>0)begin
	if(temp_tens >= 5) temp_tens = temp_tens+3;
	if(temp_ones >= 5) temp_ones = temp_ones+3;
	
	shift_register [15:8] = {temp_tens, temp_ones};
	
	shift_register = shift_register << 1;
	
	temp_tens = shift_register[15:12];
	temp_ones = shift_register[11:8];
	
	i=i+1;
end
if(i == 9)begin
	i=0;
	tens = temp_tens;
	ones = temp_ones;
end
end
end
endmodule