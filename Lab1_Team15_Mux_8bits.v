`timescale 1ns / 1ps

module Mux_1bit (a, b, sel, f);
input a, b;
input sel;
output f;

wire w1, w2, neg_sel;   
and(w1, a, sel);
and(w2, b, neg_sel);
not(neg_sel, sel);
or(f, w1, w2);

endmodule

module Mux_8bits (a, b, c, d, sel1, sel2, sel3, f);
input [8-1:0] a, b, c, d;
input sel1, sel2, sel3;
output [8-1:0] f;

wire [8-1:0] w1, w2;
Mux_1bit a1(a[0], b[0], sel1, w1[0]);
Mux_1bit a2(a[1], b[1], sel1, w1[1]);
Mux_1bit a3(a[2], b[2], sel1, w1[2]);
Mux_1bit a4(a[3], b[3], sel1, w1[3]);
Mux_1bit a5(a[4], b[4], sel1, w1[4]);
Mux_1bit a6(a[5], b[5], sel1, w1[5]);
Mux_1bit a7(a[6], b[6], sel1, w1[6]);
Mux_1bit a8(a[7], b[7], sel1, w1[7]);

Mux_1bit b1(c[0], d[0], sel2, w2[0]);
Mux_1bit b2(c[1], d[1], sel2, w2[1]);
Mux_1bit b3(c[2], d[2], sel2, w2[2]);
Mux_1bit b4(c[3], d[3], sel2, w2[3]);
Mux_1bit b5(c[4], d[4], sel2, w2[4]);
Mux_1bit b6(c[5], d[5], sel2, w2[5]);
Mux_1bit b7(c[6], d[6], sel2, w2[6]);
Mux_1bit b8(c[7], d[7], sel2, w2[7]);

Mux_1bit c1(w1[0], w2[0], sel3, f[0]);
Mux_1bit c2(w1[1], w2[1], sel3, f[1]);
Mux_1bit c3(w1[2], w2[2], sel3, f[2]);
Mux_1bit c4(w1[3], w2[3], sel3, f[3]);
Mux_1bit c5(w1[4], w2[4], sel3, f[4]);
Mux_1bit c6(w1[5], w2[5], sel3, f[5]);
Mux_1bit c7(w1[6], w2[6], sel3, f[6]);
Mux_1bit c8(w1[7], w2[7], sel3, f[7]);

endmodule

