`timescale 1ns/1ps

module Flip_Flop (clk, d, q);
input clk;
input d;
output q;
wire bri;
wire neg_clk;
not not1(neg_clk,clk);
Latch Master(.clk(clk), .d(d), .q(bri));
Latch Slave(.clk(neg_clk), .d(bri), .q(q));
endmodule

module Latch (clk, d, q);
input clk;
input d;
output q;
wire neg_d, neg_q;
wire [3-1:0] w;
not not1(neg_d, d);
nand nand1(w[0], neg_d, clk);
nand nand2(w[1], d, clk);
nand nand3(neg_q, w[0], q);
nand nand4(q, neg_q, w[1]);
endmodule
