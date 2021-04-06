`timescale 1ns / 1ps

module res4b(init, xi, yi, cout, sal, neg);

  input init;
  input [2:0] xi;
  input [2:0] yi;
  output reg cout;
  output reg [3:0] sal;
  output reg neg;
  
  always@(*)begin
  
  if(xi>yi)begin
    {cout, sal} = xi + (~yi + 1);
    neg = 0;
  end else begin 
    {cout, sal} = (~xi + 1) + yi;
    neg = 1;
  end  
  end

endmodule


