`timescale 1ns/1ps

module Decode_and_Execute (op_code, rs, rt, rd);
input [3-1:0] op_code;
input [4-1:0] rs, rt;
output [4-1:0] rd;
wire [4-1:0] f1, f2, f3, f4, f5, f6, f7, f8;
wire [4-1:0] w1, w2;
// function 
add fun1(rs, rt, f1);
sub fun2(rs, rt, f2);
inc fun3(rs, rt, f3);
bitwise_nor fun4(rs, rt, f4);
bitwise_nand fun5(rs, rt, f5);
rs_div_4 fun6(rs, f6);
rs_mul_2 fun7(rs, f7);
mul fun8(rs, rt, f8);
// mux
Mux_2sel_4bits fun9(f1, f2, f3, f4, op_code[0], op_code[1], w1);
Mux_2sel_4bits fun10(f5, f6, f7, f8, op_code[0], op_code[1], w2);
Mux_1sel_4bits fun11(w1, w2, op_code[2], rd);
endmodule


// op_code = 000 / add function
module add(a, b, f);
input [4-1:0] a, b;
output [4-1:0] f;
wire [4-1:0] w;
fulladder fun1(a[0], b[0], 0, f[0], w[0]);                                           
fulladder fun2(a[1], b[1], w[0], f[1], w[1]);
fulladder fun3(a[2], b[2], w[1], f[2], w[2]);
fulladder fun4(a[3], b[3], w[2], f[3], w[3]);
endmodule
// op_code = 001 / sub function
module sub(a, b, f);
input [4-1:0] a, b;
output [4-1:0] f;
wire [4-1:0] tem;
wire [4-1:0] w;
xor_ fun1(b[0], 1, tem[0]);
xor_ fun2(b[1], 1, tem[1]);
xor_ fun3(b[2], 1, tem[2]);
xor_ fun4(b[3], 1, tem[3]);
fulladder fun5(a[0], tem[0], 1, f[0], w[0]);                                           
fulladder fun6(a[1], tem[1], w[0], f[1], w[1]);
fulladder fun7(a[2], tem[2], w[1], f[2], w[2]);
fulladder fun8(a[3], tem[3], w[2], f[3], w[3]);
endmodule
// op_code = 010 / inc function
module inc(a, b, f);
input [4-1:0] a, b;
output [4-1:0] f;
wire [4-1:0] w;
fulladder fun1(a[0], 1, 0, f[0], w[0]);                                           
fulladder fun2(a[1], 0, w[0], f[1], w[1]);
fulladder fun3(a[2], 0, w[1], f[2], w[2]);
fulladder fun4(a[3], 0, w[2], f[3], w[3]);
endmodule
// op_code = 011 / bitwise_nor function
module bitwise_nor(a, b, f);
input [4-1:0] a, b;
output [4-1:0] f;
nor nor1(f[0], a[0], b[0]);
nor nor2(f[1], a[1], b[1]);
nor nor3(f[2], a[2], b[2]);
nor nor4(f[3], a[3], b[3]);
endmodule
// op_code = 100 / bitwise_nand function
module bitwise_nand(a, b, f);
input [4-1:0] a, b;
output [4-1:0] f;
nand nand1(f[0], a[0], b[0]);
nand nand2(f[1], a[1], b[1]);
nand nand3(f[2], a[2], b[2]);
nand nand4(f[3], a[3], b[3]);
endmodule
// op_code = 101 / rs_div_4 function
module rs_div_4(a, f);
input [4-1:0] a;
output [4-1:0] f;
wire [2-1:0] w, w1;
or or1(w[1], a[3], 0);
or or2(w[0], a[2], 0);
or or3(f[0], w[0], 0);
or or4(f[1], w[1], 0);
and and3(f[2], 0, 0);
and and4(f[3], 0, 0);
endmodule
// op_code = 110 / rs_mul_2 function
module rs_mul_2(a, f);
input [4-1:0] a;
output [4-1:0] f;
wire [3-1:0] w;
or or1(w[2], a[2], 0);
or or2(w[1], a[1], 0);
or or3(w[0], a[0], 0);
or or4(f[3], w[2], 0);
or or5(f[2], w[1], 0);
or or6(f[1], w[0], 0);
and and1(f[0], 0, 0);
endmodule
// op_code = 111 / mul function
module mul(a, b, f);
input [4-1:0] a, b;
output [4-1:0] f;
wire [4-1:0] u, i, o, w, fl;
wire [6-1:0] sum;
wire cout1, cout2;
and and1(f[0], a[0], b[0]);
and and2(u[0], a[1], b[0]);
and and3(u[1], a[2], b[0]);
and and4(u[2], a[3], b[0]);
and and5(i[0], a[0], b[1]);
and and6(i[1], a[1], b[1]);
and and7(i[2], a[2], b[1]);
and and8(i[3], a[3], b[1]);
and and9(o[0], a[0], b[2]);
and and10(o[1], a[1], b[2]);
and and11(o[2], a[2], b[2]);
and and12(o[3], a[3], b[2]);
and and13(w[0], a[0], b[3]);
and and14(w[1], a[1], b[3]);
and and15(w[2], a[2], b[3]);
and and16(w[3], a[3], b[3]);
ripple_carry_adder r1(u[0], u[1], u[2], 0, i[0], i[1], i[2], i[3], f[1], sum[0], sum[1], sum[2], cout1);
ripple_carry_adder r2(sum[0], sum[1], sum[2], cout1, o[0], o[1], o[2], o[3], f[2], sum[3], sum[4], sum[5], cout2);
ripple_carry_adder r3(sum[3], sum[4], sum[5], cout2, w[0], w[1], w[2], w[3], f[3], fl[0], fl[1], fl[2], fl[3]);
endmodule



















module fulladder(a, b, cin, sum, cout);
input a, b, cin;
output sum, cout;
wire [3-1:0] w;
xor_ fun1(a, b, w[0]);
xor_ fun2(w[0], cin, sum);
and and1(w[1], cin, w[0]);
and and2(w[2], a, b);
or or1(cout, w[1], w[2]);
endmodule

module ripple_carry_adder(a1, a2, a3, a4, b1, b2, b3, b4, sum1, sum2, sum3, sum4, cout);
input a1, a2, a3, a4, b1, b2, b3, b4;
output sum1, sum2, sum3, sum4;
output cout;
wire [3-1:0] w;
fulladder fun1(a1, b1, 0, sum1, w[0]);                                           
fulladder fun2(a2, b2, w[0], sum2, w[1]);
fulladder fun3(a3, b3, w[1], sum3, w[2]);
fulladder fun4(a4, b4, w[2], sum4, cout);
endmodule

module xor_(a, b, f);
input a, b;
output f;
wire [4-1:0] w;
not not1(w[0], a);
not not2(w[1], b);
and and1(w[2], b, w[0]);
and and2(w[3], a, w[1]);
or or1(f, w[2], w[3]);
endmodule














module Mux_1sel_1bit(a, b, sel, f);         
input a, b;
input sel;
output f;
wire [2-1:0] w;
wire neg_sel;
not not1(neg_sel, sel);
and and1(w[0], a, neg_sel);             
and and2(w[1], b, sel);                
or or1(f, w[0], w[1]);               
endmodule

module Mux_1sel_4bits(a, b, sel, f);
input [4-1:0] a, b;
input sel;
output [4-1:0] f;
Mux_1sel_1bit fun11(a[0], b[0], sel, f[0]);
Mux_1sel_1bit fun12(a[1], b[1], sel, f[1]);
Mux_1sel_1bit fun13(a[2], b[2], sel, f[2]);
Mux_1sel_1bit fun14(a[3], b[3], sel, f[3]);
endmodule

module Mux_2sel_4bits(a, b, c, d, sel1, sel2, f);      
input [4-1:0] a, b, c, d;
input sel1, sel2;
output [4-1:0] f;
wire [4-1:0] w1, w2;
Mux_1sel_4bits fun1(a, b, sel1, w1);
Mux_1sel_4bits fun2(c, d, sel1, w2);
Mux_1sel_4bits fun3(w1, w2, sel2, f);
endmodule