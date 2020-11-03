`timescale 1ns / 1ps

module Lab2_Team15_Carry_Look_Ahead_Adder_t( );
reg [4-1:0] a, b;
reg cin;
wire [4-1:0] sum;
wire cout;

Carry_Look_Ahead_Adder name(a, b, cin, cout, sum);       
initial begin
a = 4'b1101;
b = 4'b0101;
cin = 1'b1;
#100;
a = 4'b1011;
b = 4'b0100;
cin = 1'b0;
#100;
a = 4'b1000;
b = 4'b1000;
cin = 1'b0;
#100;
end
endmodule
