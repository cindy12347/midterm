`timescale 1ns / 1ps

module Comparator_4bits_t();
reg [4-1:0] a, b;
wire a_lt_b, a_gt_b, a_eq_b;

Comparator_4bits name(a, b, a_lt_b, a_gt_b, a_eq_b);
initial begin
a = 4'b0010;
b = 4'b0001;#100;
a = 4'b1000;
b = 4'b1001;#100;
a = 4'b0100;
b = 4'b0100;#100;
end 
endmodule
