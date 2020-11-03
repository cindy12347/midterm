`timescale 1ns/1ps

module Binary_to_Grey (din, dout);
input [4-1:0] din;
output [4-1:0] dout;

wire w1, w2, w3;
nand nand1(w1, din[0], din[1]);
nand nand2(w2, w1, din[0]);
nand nand3(w3, w1, din[1]);
nand nand4(dout[0], w2, w3);
wire w4, w5, w6;
nand nand5(w4, din[1], din[2]);
nand nand6(w5, w4, din[1]);
nand nand7(w6, w4, din[2]);
nand nand8(dout[1], w5, w6);
wire w7, w8, w9;
nand nand9(w7, din[2], din[3]);
nand nand10(w8, w7, din[2]);
nand nand11(w9, w7, din[3]);
nand nand12(dout[2], w8, w9);
wire w10;
nand nand13(w10, din[3]);
nand nand14(dout[3], w10); 
endmodule
