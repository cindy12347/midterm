`timescale 1ns/1ps 
`define CYC 4

module Parameterized_Ping_Pong_Counter_t();
reg clk, rst_n;
reg enable;
reg flip;
reg [4-1:0] max;
reg [4-1:0] min;
wire direction;
wire [4-1:0] out;
wire [4-1:0] next_out;
wire next_direction;

Parameterized_Ping_Pong_Counter pppc(  
    .clk(clk),
    .rst_n(rst_n), 
    .enable(enable), 
    .flip(flip), 
    .max(max), 
    .min(min), 
    .direction(direction), 
    .out(out),
    .next_out(next_out),
    .next_direction(next_direction)
);

always #(`CYC / 2) clk = ~clk;

initial begin
    clk  = 1'b1;  // test rest = 0
    rst_n = 1'b0;
    enable = 1'b0;
    flip = 1'b0;
    max = 4'b0;
    min = 4'b0;
    #8;
    rst_n = 1'b1; // test enalbe = 0
    enable = 1'b0;
    flip = 1'b0;
    max = 4'b0;
    min = 4'b0;
    #8;
    rst_n = 1'b1; // test max <= min
    enable = 1'b1;
    flip = 1'b0;
    max = 4'b0001;
    min = 4'b0111;
    #40;
    rst_n = 1'b0;  // reset
    enable = 1'b0;
    flip = 1'b0;
    max = 4'b0111;
    min = 4'b0111;
    #8;
    rst_n = 1'b1; // test max = min
    enable = 1'b1;
    flip = 1'b0;
    max = 4'b0111;
    min = 4'b0111;
    #40;
    rst_n = 1'b0;  // reset
    enable = 1'b0;
    flip = 1'b0;
    max = 4'b1000;
    min = 4'b0010;
    #8;
    rst_n = 1'b1;  // max = 8 min = 2
    enable = 1'b1;
    flip = 1'b0;
    max = 4'b1000;
    min = 4'b0010;
    #40;
    rst_n = 1'b0;  // reset
    enable = 1'b0;
    flip = 1'b0;
    max = 4'b1111;
    min = 4'b0110;
    #8;
    rst_n = 1'b1;  // max = 15 min = 6
    enable = 1'b1;
    flip = 1'b0;
    max = 4'b1111;
    min = 4'b0110;
    #40;
    rst_n = 1'b0;  // reset
    enable = 1'b0;
    flip = 1'b0;
    max = 4'b1110;
    min = 4'b0100;
    #8;
    rst_n = 1'b1;  // max = 14 min = 4
    enable = 1'b1;
    flip = 1'b0;
    max = 4'b1110;
    min = 4'b0100;
    #40;
end

endmodule
