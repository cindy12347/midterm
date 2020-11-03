`timescale 1ns / 1ps

module Lab1_TeamX_RippleCarryAdder_t();
reg [8-1:0] a,b;
reg cin;
wire [8-1:0] sum;
wire cout;

RippleCarryAdder name(a, b, cin, cout, sum);
    initial begin
    a = 8'b00001101;
    b = 8'b00000101;
    cin = 1'b1;
    #100;
    a = 8'b00001011;
    b = 8'b00000100;
    cin = 1'b0;
    #100;
    a = 8'b10000000;
    b = 8'b10000000;
    cin  = 1'b1;
    #100;
    end
endmodule
