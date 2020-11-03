`timescale 1ns/1ps

module try (a, b, try);           //  try module
input a, b;
output try; 
wire an, bn;
not not1(an, a);
not not2(bn, b);
wire x, in, ward;
and and1(in, a, b);              // = ab
and and2(ward, an, bn);          // = a'b'
or or1(try, in, ward);           // try =  ab + a'b'
endmodule

module equal (a, b, equal);      //  equal module
input [4-1:0] a, b;
output equal;
wire [6-1:0] x;
try name0(a[0], b[0], x[0]);     // x[0] = a[0]b[0] + a[0]' b[0]'
try name1(a[1], b[1], x[1]);     // x[1] = a[1]b[1] + a[1]' b[1]'
try name2(a[2], b[2], x[2]);     // x[2] = a[1]b[2] + a[2]' b[2]'
try name3(a[3], b[3], x[3]);     // x[3] = a[1]b[3] + a[3]' b[3]'
and and1(equal, x[0], x[1], x[2], x[3]);   // equal = x[0] + x[1] + x[2] + x[3]
endmodule

module larger (a, b, larger);     // larger module
input [4-1:0] a, b;
output larger;
wire [4-1:0] bn;
not not0(bn[0], b[0]);
not not1(bn[1], b[1]);
not not2(bn[2], b[2]);
not not3(bn[3], b[3]);
wire [4-1:0] x;
try name0(a[0], b[0], x[0]);     // x[0] = a[0]b[0] + a[0]' b[0]'
try name1(a[1], b[1], x[1]);     // x[1] = a[1]b[1] + a[1]' b[1]'
try name2(a[2], b[2], x[2]);     // x[2] = a[1]b[2] + a[2]' b[2]'
try name3(a[3], b[3], x[3]);     // x[3] = a[1]b[3] + a[3]' b[3]'
wire [4-1:0] w;
and and0(w[0], a[3], bn[3]);                     // w[0] = a[3]b[3]'
and and1(w[1], x[3], a[2], bn[2]);               // w[1] = x[3]a[2]b[2]'
and and2(w[2], x[3], x[2], a[1], bn[1]);         // w[2] = x[3]x[2]a[1]b[1]'
and and3(w[3], x[3], x[2], x[1], a[0], bn[0]);   // w[3] = x[3]x[2]x[1]a[0]b[0]'
or or1(larger, w[0], w[1], w[2], w[3]);          // larger = w[0] + w[1] + w[2] + w[3]
endmodule

module less(a, b, less);                  // less module
input [4-1:0] a, b;
output less;
wire [4-1:0] an;
not not0(an[0], a[0]);
not not1(an[1], a[1]);
not not2(an[2], a[2]);
not not3(an[3], a[3]);
wire [4-1:0] x;
try name0(a[0], b[0], x[0]);     // x[0] = a[0]b[0] + a[0]' b[0]'
try name1(a[1], b[1], x[1]);     // x[1] = a[1]b[1] + a[1]' b[1]'
try name2(a[2], b[2], x[2]);     // x[2] = a[1]b[2] + a[2]' b[2]'
try name3(a[3], b[3], x[3]);     // x[3] = a[1]b[3] + a[3]' b[3]'
wire [4-1:0] w;
and and9(w[0], an[3], b[3]);                       // w[0] = a[3]'b[3]
and and10(w[1], x[3], an[2], b[2]);                // w[1] = x[3]a[2]'b[2]
and and12(w[2], x[3], x[2], an[1], b[1]);          // w[2] = x[3]x[2]a[1]'b[1]
and and13(w[3], x[3], x[2], x[1], an[0], b[0]);    // w[3] = x[3]x[2]x[1]a[0]'b[0]
or or1(less, w[0], w[1], w[2], w[3]);              // less = w[0] + w[1] + w[2] + w[3]
endmodule

module Comparator_4bits (a, b, a_lt_b, a_gt_b, a_eq_b);     //   comparator module
input [4-1:0] a, b;
output a_lt_b, a_gt_b, a_eq_b;
equal name1(a, b, a_eq_b);
larger name2(a, b, a_gt_b);
less name3(a, b, a_lt_b);
endmodule

module top_module(a, b, ledeq, ledgt, ledlt);
input [4-1:0]a, b;
output  [8-1:0]ledeq;
output [4-1:0]ledgt, ledlt;

Comparator_4bits name(a, b, a_lt_b, a_gt_b, a_eq_b);

wire [8-1:0]eq;
wire [4-1:0]gt, lt;

not not1(eq[0], eq[1], eq[2], eq[3], eq[4], eq[5], eq[6], eq[7], a_eq_b);
not not2(ledeq[0], eq[0]);
not not3(ledeq[1], eq[1]);
not not4(ledeq[2], eq[2]);
not not5(ledeq[3], eq[3]);
not not6(ledeq[4], eq[4]);
not not7(ledeq[5], eq[5]);
not not8(ledeq[6], eq[6]);
not not9(ledeq[7], eq[7]);

not not10(gt[0], gt[1], gt[2], gt[3], a_gt_b);
not not11(ledgt[0], gt[0]);
not not12(ledgt[1], gt[1]);
not not13(ledgt[2], gt[2]);
not not14(ledgt[3], gt[3]);

not not15(lt[0], lt[1], lt[2], lt[3], a_lt_b);
not not16(ledlt[0], lt[0]);
not not17(ledlt[1], lt[1]);
not not18(ledlt[2], lt[2]);
not not19(ledlt[3], lt[3]);

endmodule

