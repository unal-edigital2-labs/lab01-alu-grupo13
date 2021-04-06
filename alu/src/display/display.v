`timescale 1ns / 1ps
module display(
    input [15:0] num,
    input clk,
    output [0:7] sseg,
    output reg [7:0] an,
	input rst,
	input neg
    );



reg [3:0]bcd=0;
reg negativo = 0;
 
BCDtoSSeg bcdtosseg(.BCD(bcd), .SSeg(sseg), .neg(negativo));

reg [26:0] cfreq=0;
wire enable;

// Divisor de frecuecia
assign enable = cfreq[16];

always @(posedge clk) begin
  /*if(rst==1) begin
		cfreq <= 0;
	end else begin*/
		cfreq <=cfreq+1;
	//end
end

reg [1:0] count = 0;
always @(posedge enable) begin
		if(rst==1) begin
			an=8'b11111111; 
		end else begin 
			count <= count+1;
            case (count) 
				2'h0: begin negativo = neg; bcd <= num[3:0];    an<=8'b11111110; end 
				2'h1: begin negativo = 1'b1; bcd <= num[7:4];   an<=8'b11111101; end 
				2'h2: begin negativo = 1'b1; bcd <= num[11:8];  an<=8'b11111011; end 
				2'h3: begin negativo = 1'b1; bcd <= num[15:12]; an<=8'b11110111; end 
            endcase
	    end

end

endmodule
