`timescale 1ns/1ps

module NAND_Implement (a, b, sel, out);             // nand_inplement
input a, b;
input [3-1:0] sel;
output out;
wire [8-1:0]f;
wire w1, w2;
inverter_nand fun1(a, f[0]);
nor_nand fun2(a, b, f[1]);
and_nand fun3(a, b, f[2]);
or_nand fun4(a, b, f[3]);
xor_nand fun5(a, b, f[4]);
xnor_nand fun6(a, b, f[5]);
nand nand1(f[6], a, b);
nand nand2(f[7], a, b);
Mux_2sel m1(f[0], f[1], f[2], f[3], sel[0], sel[1], w1);
Mux_2sel m2(f[4], f[5], f[6], f[7], sel[0], sel[1], w2);
Mux_1sel m3(w1, w2, sel[2], out);
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
wire w1, w2;
Mux_1sel fun1(a, b, sel1, w1);
Mux_1sel fun2(c, d, sel1, w2);
Mux_1sel fun3(w1, w2, sel2, f);
endmodule

module inverter_nand(a, f);                      // inverter_nand
input a;
output f;
nand nand1(f, a, a);
endmodule

module nor_nand(a, b, f);                         // nor_nand
input a, b;
output f;
wire w1;
or_nand fun1(a, b, w1);
inverter_nand fun2(w1, f);
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
wire [4-1:0] w;
inverter_nand fun1(a, w[0]);
inverter_nand fun2(b, w[1]);
and_nand fun3(w[0], b, w[2]);
and_nand fun4(w[1], a, w[3]);
or_nand fun5(w[2], w[3], f);
endmodule

module xnor_nand(a, b, f);                             // xnor_nand
input a, b;
output f;
wire w1;
xor_nand fun1(a, b, w1);
inverter_nand fun2(w1, f);
endmodule

