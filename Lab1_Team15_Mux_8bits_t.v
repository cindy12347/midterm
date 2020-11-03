`timescale 1ns / 1ps

module Mux_8bits_test();
reg [8-1:0] a, b, c, d;
reg sel1, sel2, sel3;
wire [8-1:0] f;

Mux_8bits M1(a, b, c, d, sel1, sel2, sel3, f);
initial begin
a = 8'b00000000;
b = 8'b00000001;
c = 8'b00000010;
d = 8'b00000011;
sel1 = 1'b0;
sel2 = 1'b0;
sel3 = 1'b0;#100;
sel1 = 1'b1;
sel2 = 1'b1;
sel3 = 1'b0;#100;
sel1 = 1'b0;
sel2 = 1'b0;
sel3 = 1'b1;#100;
sel1 = 1'b1;
sel2 = 1'b1;
sel3 = 1'b1;#100;
end
endmodule


