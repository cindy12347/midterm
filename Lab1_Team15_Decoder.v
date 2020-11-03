`timescale 1ns/1ps

module Decoder (din, dout);
input [4-1:0] din;
output [16-1:0] dout;

wire w0, w1, w2, w3;
not not1(w0, din[0]);
not not2(w1, din[1]);
not not3(w2, din[2]);
not not4(w3, din[3]);

wire x0, x1; 
and and1(x0, w0, w1, w2, w3);
and and2(x1, din[0], din[1], din[2], din[3]);
or or1(dout[0], x0, x1);

wire x2, x3; 
and and3(x2, din[0], w1, w2, w3);
and and4(x3, w0, din[1], din[2], din[3]);
or or2(dout[1], x2, x3);

wire x4, x5;
and and5(x4, w0, din[1], w2, w3);
and and6(x5, din[0], w1, din[2], din[3]);
or or3(dout[2], x4, x5);

wire x6, x7;
and and7(x6, din[0], din[1], w2, w3);
and and8(x7, w0, w1, din[2], din[3]);
or or4(dout[3], x6, x7);

wire x8, x9;
and and9(x8, w0, w1, din[2], w3);
and and10(x9, din[0], din[1], w2, din[3]);
or or5(dout[4], x8, x9);

wire x10, x11;
and and11(x10, din[0], w1, din[2], w3);
and and12(x11, w0, din[1], w2, din[3]); 
or or6(dout[5], x10, x11);

wire x12, x13;
and and13(x12, w0, din[1], din[2], w3); 
and and14(x13, din[0], w1, w2, din[3] ); 
or or7(dout[6], x12, x13);

wire x14, x15;
and and15(x14, din[0], din[1], din[2], w3);
and and16(x15, w0, w1, w2, din[3]);
or or8(dout[7], x14, x15);

wire z0, z1; 
and and17(z0, w0, w1, w2, w3);
and and18(z1, din[0], din[1], din[2], din[3]);
or or9(dout[8], z0, z1);

wire z2, z3; 
and and19(z2, din[0], w1, w2, w3);
and and20(z3, w0, din[1], din[2], din[3]);
or or10(dout[9], z2, z3);

wire z4, z5;
and and21(z4, w0, din[1], w2, w3);
and and22(z5, din[0], w1, din[2], din[3]);
or or11(dout[10], z4, z5);

wire z6, z7;
and and23(z6, din[0], din[1], w2, w3);
and and24(z7, w0, w1, din[2], din[3]);
or or12(dout[11], z6, z7);

wire z8, z9;
and and25(z8, w0, w1, din[2], w3);
and and26(z9, din[0], din[1], w2, din[3]);
or or13(dout[12], z8, z9);

wire z10, z11;
and and27(z10, din[0], w1, din[2], w3);
and and28(z11, w0, din[1], w2, din[3]); 
or or14(dout[13], z10, z11);

wire z12, z13;
and and29(z12, w0, din[1], din[2], w3); 
and and30(z13, din[0], w1, w2, din[3] ); 
or or15(dout[14], z12, z13);

wire z14, z15;
and and31(z14, din[0], din[1], din[2], w3);
and and32(z15, w0, w1, w2, din[3]);
or or16(dout[15], z14, z15);

 endmodule
