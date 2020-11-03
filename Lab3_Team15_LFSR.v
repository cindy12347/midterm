`timescale 1ns/1ps

module LFSR (clk, rst_n, out);
input clk, rst_n;
output out;
wire q1, q2, q3, q4, q5, xor_q5q2;
DFF dff1(clk, rst_n, xor_q5q2, q1);
DFF dff2(clk, rst_n, q1, q2);
DFF dff3(clk, rst_n, q2, q3);
DFF dff4(clk, rst_n, q3, q4);
DFF dff5(clk, rst_n, q4, q5);
assign out = q5;
assign xor_q5q2 = q5 ^ q2;
endmodule

module DFF(clk, rst_n, in, out);
input clk, rst_n, in;
output out;
reg out;
always@(posedge clk) begin
if(rst_n == 1'b0)   out <= 1'b1;
else  out <= in;
end
endmodule
