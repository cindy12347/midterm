`timescale 1ns/1ps

module Memory (clk, ren, wen, addr, din, dout);
input clk;
input ren, wen;
input [7-1:0] addr;
input [8-1:0] din;
output [8-1:0] dout;
reg [8-1:0] x [128-1:0];
reg [8-1:0] dout;

always@(posedge clk) begin
if(wen == 1'b1 && ren == 1'b0) begin
x[addr] <= din;
dout <= 8'b0;
end
else if (ren ==1'b1) begin
dout <= x[addr];
end
else
dout <= 8'd0;
end
endmodule
