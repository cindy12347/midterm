`timescale 1ns/1ps

module FullAdder (a, b, cin, cout, sum);
input a, b;
input cin;
output sum;
output cout;

wire nor_ab, nand_ab, w3; 
nor nor1(nor_ab, a, b);
and and1(nand_ab, a, b);
or or1(w3, nor_ab, nand_ab);

wire nor_w3cin, nand_w3cin;
nor nor2(nor_w3cin, w3, cin);
and and2(nand_w3cin, w3, cin);
or or2(sum, nand_w3cin, nor_w3cin);

wire and_aw3, and_cinnw3, nw3;
and and3(and_aw3, a, w3);
and and4(and_cinnw3, cin, nw3);
not not1(nw3, w3);
or or3(cout, and_aw3, and_cinnw3);

endmodule

module RippleCarryAdder (a, b, cin, cout, sum);
input [8-1:0] a, b;
input cin;
output [8-1:0] sum;
output cout;

wire w1, w2, w3, w4, w5, w6, w7; 
FullAdder a1(a[0], b[0], cin, w1, sum[0]);
FullAdder a2(a[1], b[1], w1, w2, sum[1]);
FullAdder a3(a[2], b[2], w2, w3, sum[2]);
FullAdder a4(a[3], b[3], w3, w4, sum[3]);
FullAdder a5(a[4], b[4], w4, w5, sum[4]);
FullAdder a6(a[5], b[5], w5, w6, sum[5]);
FullAdder a7(a[6], b[6], w6, w7, sum[6]);
FullAdder a8(a[7], b[7], w7, cout, sum[7]);


endmodule
