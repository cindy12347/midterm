`timescale 1ns/1ps

module Multiplier (a, b, p);
input [4-1:0] a, b;
output [8-1:0] p;
wire [4-1:0] u, i, o ,w;
wire [6-1:0] sum;
wire cout1, cout2;
and_nor and1(a[0], b[0], p[0]);
and_nor and2(a[1], b[0], u[0]);
and_nor and4(a[2], b[0], u[1]);
and_nor and6(a[3], b[0], u[2]);
and_nor and3(a[0], b[1], i[0]);
and_nor and5(a[1], b[1], i[1]);
and_nor and7(a[2], b[1], i[2]);
and_nor and8(a[3], b[1], i[3]);
and_nor and9(a[0], b[2], o[0]);
and_nor and10(a[1], b[2], o[1]);
and_nor and11(a[2], b[2], o[2]);
and_nor and12(a[3], b[2], o[3]);
and_nor and13(a[0], b[3], w[0]);
and_nor and14(a[1], b[3], w[1]);
and_nor and15(a[2], b[3], w[2]);
and_nor and16(a[3], b[3], w[3]);
ripple_carry_adder r1(u[0], u[1], u[2], 0, i[0], i[1], i[2], i[3], p[1], sum[0], sum[1], sum[2], cout1);
ripple_carry_adder r2(sum[0], sum[1], sum[2], cout1, o[0], o[1], o[2], o[3], p[2], sum[3], sum[4], sum[5], cout2);
ripple_carry_adder r3(sum[3], sum[4], sum[5], cout2, w[0], w[1], w[2], w[3], p[3], p[4], p[5], p[6], p[7]);
endmodule

module fulladder(a, b, cin, sum, cout);
input a, b, cin;
output sum, cout;
wire [3-1:0] w;
xor_nor fun1(a, b, w[0]);
xor_nor fun2(w[0], cin, sum);
and_nor fun3(w[0], cin, w[1]);
and_nor fun4(a, b, w[2]);
or_nor fun5(w[1], w[2], cout);
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

