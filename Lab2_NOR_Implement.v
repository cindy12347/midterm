`timescale 1ns/1ps

module NOR_Implement (a, b, sel, out);
input a, b;
input [3-1:0] sel;
output out;
wire [8-1:0] f;
inverter_nor fun1(a, f[0]);
nor nor1(f[1], a, b);
and_nor fun2(a, b, f[2]);
or_nor fun3(a, b, f[3]);
xor_nor fun4(a, b, f[4]);
xnor_nor fun5(a, b, f[5]);
nand_nor fun6(a, b, f[6]);
nand_nor fun7(a, b, f[7]);
Mux_2sel_ m1(f[0], f[1], f[2], f[3], sel[0], sel[1], w1);
Mux_2sel_ m2(f[4], f[5], f[6], f[7], sel[0], sel[1], w2);
Mux_1sel_ m3(w1, w2, sel[2], out);
endmodule

module Mux_1sel_(a, b, sel, f);                  // mux_1sel
input a, b;
input sel;
output f;
wire [1:0] w;
wire neg_sel;
inverter_nor fun1(sel, neg_sel);
and_nor fun2(a, neg_sel, w[0]);                 // w[0] = a.sel'
and_nor fun3(b, sel, w[1]);                     // w[1] = b.sel
or_nor fun4(w[0], w[1], f);                     // f = a.sel' + bsel
endmodule

module Mux_2sel_(a, b, c, d, sel1, sel2, f);      // mux_2sel
input a, b, c, d;
input sel1, sel2;
output f;
wire w1, w2;
Mux_1sel fun1(a, b, sel1, w1);
Mux_1sel fun2(c, d, sel1, w2);
Mux_1sel fun3(w1, w2, sel2, f);
endmodule

module inverter_nor(a, f);
input a;
output f;
nor nor1(f, a, a);
endmodule

module and_nor(a, b, f);
input a, b;
output f;
wire [2-1:0] w;
nor nor1(w[0], a, a);
nor nor2(w[1], b, b);
nor nor3(f, w[0], w[1]);
endmodule

module or_nor(a, b, f);
input a, b;
output f;
wire w1;
nor nor1(w1, a, b);
nor nor2(f, w1, w1);
endmodule

module xor_nor(a, b, f);
input a, b;
output f;
wire [4-1:0] w;
inverter_nor fun1(a, w[0]);
inverter_nor fun2(b, w[1]);
and_nor fun3(b, w[0], w[2]);
and_nor fun4(a, w[1], w[3]);
or_nor fun5(w[2], w[3], f);
endmodule

module xnor_nor(a, b, f);
input a, b;
output f;
wire w1;
xor_nor fun1(a, b, w1);
inverter_nor fun2(w1, f);
endmodule

module nand_nor(a, b, f);
input a, b;
output f;
wire w1;
and_nor fun1(a, b, w1);
inverter_nor fun2(w1, f);
endmodule
