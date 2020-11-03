`timescale 1ns/1ps

module FullAdder(a, b, cin, cout, sum);
input a, b;
input cin;
output sum;
output cout;

wire nand_ab, nand_ab_a, nand_ab_b, axorb;
nand nand1(nand_ab, a, b);
nand nand2(nand_ab_a, nand_ab, a);
nand nand3(nand_ab_b, nand_ab, b);
nand nand4(axorb, nand_ab_a, nand_ab_b);
wire and_ab;
nand nand6(and_ab, nand_ab);
wire nand_cin_axorb, w1, w2;
nand nand7(nand_cin_axorb, cin, axorb);
nand nand8(w1, axorb, nand_cin_axorb);
nand nand9(w2, cin, nand_cin_axorb);
nand nand10(sum, w1,w2);
wire and_cin_axorb;
nand nand12(and_cin_axorb, nand_cin_axorb);
nand nand13(cout, nand_ab, nand_cin_axorb);
endmodule

module Carry_Look_Ahead_Adder (a, b, cin, cout, sum);
input [4-1:0] a, b;
input cin;
output cout;
output [4-1:0] sum;

wire c1, c2, c3;
FullAdder f1(a[0], b[0], cin, x, sum[0]); 
FullAdder f2(a[1], b[1], c1, y, sum[1]);
FullAdder f3(a[2], b[2], c2, u, sum[2]);
FullAdder f4(a[3], b[3], c3, v, sum[3]);

wire p0, g0, p1, g1, p2, g2, p3, g3;
pg pg1(a[0], b[0], p0, g0);
pg pg2(a[1], b[1], p1, g1);
pg pg3(a[2], b[2], p2, g2);
pg pg4(a[3], b[3], p3, g3);

wire a1, p0cin, ng0;
nand nand1(a1, p0, cin);
nand nand2(p0cin, a1);
nand nand3(ng0,g0);
nand nand4(c1, a1, ng0); 

wire b1, b2, p1p0cin, p1g0, ng1;
nand nand5(b1, p1, g0);
nand nand6(p1g0, b1);
nand nand7(b2, p1, p0, cin);
nand nand8(p1p0cin, b2);
nand nand9(ng1, g1);
nand nand10(c2, b1, b2, ng1);

wire d1, d2, d3, p2g1, p2p1g0, p2p1p0cin, ng2;
nand nand11(d1, p2, g1);
nand nand12(p2g1, d1);
nand nand13(d2, p2, p1, g0);
nand nand14(p2p1g0, d2);
nand nand15(d3, p2, p1, p0, cin);
nand nand16(p2p1p0cin, d3);
nand nand17(ng2, g2);
nand nand18(c3, d1, d2, d3, ng2);

wire e1, e2, e3, e4, p3g2, p3p2g1, p3p2p1g0, p3p2p1p0cin, ng3;
nand nand19(e1, p3, g2);
nand nand20(p3g2, e1);
nand nand21(e2, p3, p2, g1);
nand nand22(p3p2g1, e2);
nand nand23(e3, p3, p2, p1, g0);
nand nand24(p3p2p1g0, e3);
nand nand25(e4, p3, p2, p1, p0, cin);
nand nand26(p3p2p1p0cin, e4);
nand nand27(ng3, g3);
nand nand28(cout, e1, e2, e3, e4, ng3);
endmodule

module pg(a, b, p, g);   
input a, b;                 
output p, g;                   
wire w1, w2, w3;            
nand nand1(w1, a, b); 
nand nand2(w2, w1, a);   
nand nand3(w3, w1, b);   
nand nand4(p, w2, w3);     
nand nand5(g, w1);
endmodule         

module Lab2_Team15_Carry_Look_Ahead_Adder_fpga(a, b, cin, seg, dp, AN);
input [4-1:0] a, b;
input cin;
output [7-1:0] seg;
output dp;
output [4-1:0] AN;
nand nandan3(AN[3], 1'b1);
nand nandan2(AN[2], 1'b0);
nand nandan1(AN[1], 1'b0);
nand nandan0(AN[0], 1'b0);
Carry_Look_Ahead_Adder (a, b, cin, cout, sum);
wire cout, w1;
nand nand1(dp, cout);
wire [4-1:0] sum;
nand nand4(nsum0, sum[0]);
nand nand5(nsum1, sum[1]);
nand nand6(nsum2, sum[2]);
nand nand7(nsum3, sum[3]);
wire a1, a2, a3, a4, a5, a6, s0;
nand nand8(a1, sum[2], sum[1]);
nand nand9(a2, nsum3, sum[1]);
nand nand10(a3, nsum0, nsum2);
nand nand11(a4, sum[0], sum[2], nsum3);
nand nand12(a5, sum[3], nsum0, nsum1);
nand nand13(a6, sum[3], nsum2, nsum1);
nand nand14(s0, a1, a2, a3, a4, a5, a6); 
wire b1, b2, b3, b4, b5, b6, s2;
nand nand15(b1, nsum0, nsum2);
nand nand16(b2, sum[0], sum[1], nsum3);
nand nand17(b3, nsum2, nsum3);
nand nand18(b4, nsum1, nsum2); 
nand nand19(b5, nsum0, nsum1, nsum3);
nand nand20(b6, sum[0], nsum1, sum[3]);
nand nand21(s1, b1, b2, b3, b4, b5, b6);
wire c1, c2, c3, c4, c5, s2;
nand nand22(c1, sum[3], nsum2);
nand nand23(c2, sum[0], nsum1);
nand nand24(c3, sum[2], nsum3);
nand nand25(c4, sum[0], nsum3);
nand nand26(c5, nsum1, nsum3);
nand nand27(s2, c1, c2, c3, c4, c5);
wire d1, d2, d3, d4, d5, d6, s3;
nand nand28(d1, nsum0, sum[1], sum[2]);
nand nand29(d2, sum[1], nsum2, nsum3);
nand nand30(d3, sum[0], sum[1], nsum2);
nand nand31(d4, sum[0], nsum1, sum[2]);
nand nand32(d5, nsum0, nsum1, nsum2);
nand nand33(d6, nsum1, sum[3]);
nand nand34(s3, d1, d2, d3, d4, d5, d6);
wire e1, e2, e3, e4, e5, s4;
nand nand35(e1, sum[2], sum[3]);
nand nand36(e2, nsum0, sum[1]);
nand nand37(e3, sum[1], sum[3]);
nand nand38(e4, nsum0, nsum1, sum[3]);
nand nand39(e5, nsum0, nsum1, nsum2);
nand nand40(s4, e1, e2, e3, e4, e5);
wire f1, f2, f3, f4, f5, s5;
nand nand41(f1, nsum0, sum[2]);
nand nand42(f2, sum[1], sum[3]);
nand nand43(f3, nsum2, sum[3]);
nand nand44(f4, nsum0, nsum1);
nand nand45(f5, nsum1, sum[2], nsum3);
nand nand46(s5, f1, f2, f3, f4, f5);
wire g1, g2, g3, g4, g5, g6, s6;
nand nand47(g1, nsum1, sum[2], nsum3);
nand nand48(g2, sum[1], nsum2);
nand nand49(g3, sum[0], sum[3]);
nand nand50(g4, sum[1], sum[3]);
nand nand51(g5, nsum0, sum[1]);
nand nand52(g6, nsum2, sum[3]);
nand nand53(s6, g1, g2, g3, g4, g5, g6);

nand nand54(seg[0], s0);
nand nand55(seg[1], s1);
nand nand56(seg[2], s2);
nand nand57(seg[3], s3);
nand nand58(seg[4], s4);
nand nand59(seg[5], s5);
nand nand60(seg[6], s6);
endmodule

