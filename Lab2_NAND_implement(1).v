`timescale 1ns/1ps

module NAND_Implement (a, b, sel, out);             // nand_inplement
input a, b;
input [3-1:0] sel;
output out;
wire [8-1:0]f;
wire f1, f2;
inverter_nand fun1(a, f[0]);
nor_nand fun2(a, b, f[1]);
and_nand fun3(a, b, f[2]);
or_nand fun4(a, b, f[3]);
xor_nand fun5(a, b, f[4]);
xnor_nand fun6(a, b, f[5]);
nand nand1(a, b, f[6]);
nand nand2(a, b, f[7]);
Mux_2sel m1(f[0], f[1], f[2], f[3], sel[0], sel[1], f1);
Mux_2sel m2(f[4], f[5], f[6], f[7], sel[0], sel[1], f2);
Mux_1sel m3(f1, f2, sel[2], out);
assign out = 1'b1;
endmodule

module Mux_1sel(a, b, sel, f);                  // mux_1sel
input a, b;
input sel;
output f;
wire [1:0] w;
wire neg_sel;
inverter_nand fun1(sel, neg_sel);
and_nand fun2(a, neg_sel, w[0]);                 // w[0] = a.sel'
and_nand fun3(b, sel, w[1]);                     // w[1] = b.sel
or_nand fun4(w[0], w[1], f);                     // f = a.sel' + bsel
endmodule

module Mux_2sel(a, b, c, d, sel1, sel2, f);      // mux_2sel
input a, b, c, d;
input sel1, sel2;
output f;
wire [4-1:0] w1;
wire [2-1:0] w2;
wire neg_sel1, neg_sel2;
inverter_nand fun1(sel1, neg_sel1);
inverter_nand fun2(sel2, neg_sel2);
and_nand fun3(neg_sel1, neg_sel2, w1[0]);       
and_nand fun4(w1[0], a, w1[4]);                        // w[4] = a.sel1'.sel2'
and_nand fun5(neg_sel1, sel2, w1[1]);
and_nand fun6(w1[1], b, w1[5]);                        // w[5] = b.sel1'.sel2
and_nand fun7(sel1, neg_sel2, w1[2]);
and_nand fun8(w1[2], c, w1[6]);                        // w[6] = c.sel1.sel2'
and_nand fun9(sel1, sel2, w1[3]);
and_nand fun10(w1[3], d, w1[7]);                       // w[7] = d.sel1.sel2
or_nand fun11(w1[4], w1[5], w2[0]);
or_nand fun12(w2[0], w1[6], w2[1]);
or_nand fun13(w2[1], w1[7], f);                        //  f = w[4] + w[5] + w[6] + w[7]
endmodule

module inverter_nand(a, f);                      // inverter_nand
input a;
output f;
nand nand1(f, a, a);
endmodule

module nor_nand(a, b, f);                         // nor_nand
input a, b;
output f;
wire [3-1:0] w;
nand nand1(w[0], a, a);
nand nand2(w[1], b, b);
nand nand3(w[2], w[0], w[1]);
nand nand4(f, w[2], w[2]);
endmodule

module and_nand(a, b, f);                            // and_nand
input a, b;
output f;
wire w1;
nand nand1(w1, a, b);
nand nand2(f, w1, w1);
endmodule

module or_nand(a, b, f);                         // or_nand
input a, b;
output f;
wire [2-1:0] w;
nand nand1(w[0], a, a);
nand nand2(w[1], b, b);
nand nand3(f, w[0], w[1]);
endmodule

module xor_nand(a, b, f);                          // xor_nand
input a, b;
output f;
wire [6-1:0] w;
nand nand1(w[0], a, a);
nand nand2(w[1], w[0], b);
nand nand3(w[2], b, b);
nand nand4(w[3], w[2], a);
nand nand6(w[4], w[1], w[1]);
nand nand7(w[5], w[3], w[3]);
nand nand8(f, w[4], w[5]);
endmodule

module xnor_nand(a, b, f);                             // xnor_nand
input a, b;
output f;
wire [7-1:0] w;
nand nand1(w[0], a, a);
nand nand2(w[1], w[0], b);
nand nand3(w[2], b, b);
nand nand4(w[3], w[2], a);
nand nand6(w[4], w[1], w[1]);
nand nand7(w[5], w[3], w[3]);
nand nand8(w[6], w[4], w[5]);
nand nand9(f, w[6], w[6]);
endmodule

