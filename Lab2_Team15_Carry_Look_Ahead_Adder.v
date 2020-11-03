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


