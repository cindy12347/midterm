`timescale 1ns / 1ps
module Multiplier_t();
reg [4-1:0] a, b;
wire [8-1:0] p;
Multiplier mul(a, b, p);
initial begin
assign a = 4'b1100;
assign b = 4'b0111;#100;
assign a = 4'b1111;
assign b = 4'b1100;#100;
assign a = 4'b1011;
assign b = 4'b0101;#100;
end
endmodule
