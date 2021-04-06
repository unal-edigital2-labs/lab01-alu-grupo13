module BCDtoSSeg (BCD, SSeg, neg);
  input neg;
  input [3:0] BCD;
  output reg [7:0] SSeg;


always @ ( * ) begin
  case (BCD)
    4'b0000: SSeg = {7'b1000000, neg}; // "0"  
	4'b0001: SSeg = {7'b1111001, neg}; // "1" 
	4'b0010: SSeg = {7'b0100100, neg}; // "2" 
	4'b0011: SSeg = {7'b0110000, neg}; // "3" 
	4'b0100: SSeg = {7'b0011001, neg}; // "4" 
	4'b0101: SSeg = {7'b0010010, neg}; // "5" 
	4'b0110: SSeg = {7'b0000010, neg}; // "6" 
	4'b0111: SSeg = {7'b1111000, neg}; // "7" 
	4'b1000: SSeg = {7'b0000000, neg}; // "8"  
	4'b1001: SSeg = {7'b0011000, neg}; // "9" 
       4'ha: SSeg = {7'b0001000, neg};  
       4'hb: SSeg = {7'b0000011, neg};
       4'hc: SSeg = {7'b1000110, neg};
       4'hd: SSeg = {7'b0100001, neg};
       4'he: SSeg = {7'b0000110, neg};
       4'hf: SSeg = {7'b0001110, neg};
    default:
    SSeg = 0;
    endcase
end

endmodule
