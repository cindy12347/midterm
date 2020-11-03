`timescale 1ns / 1ps
`define CYC 4

module final_ping_pong_tb();
reg clk = 1;
reg rst_n;
reg enable;
reg flip;
reg [4-1:0] max;
reg [4-1:0] min;
wire direction;
wire [4-1:0] out;

always #(`CYC / 2) clk = ~clk;   
Parameterized_Ping_Pong_Counter fun(
    .clk(clk), 
    .rst_n(rst_n), 
    .enable(enable), 
    .flip(flip), 
    .max(max), 
    .min(min), 
    .direction(direction), 
    .out(out));
////////////////////////////////////////////
initial begin
// reset
rst_n = 0;            
enable = 0;
flip = 0;
max = 4'b1111;
min = 4'b1001;         
#(`CYC *20)
// no reset but disable
rst_n = 1;            
enable = 0;
flip = 0;
max = 4'b1111;
min = 4'b1001;
// nornal
#(`CYC *20)
rst_n = 1;            
enable = 1;
flip = 0;
max = 4'b1111;
min = 4'b1001;
#(`CYC *20)
rst_n = 1;            
enable = 1;
flip = 1;
max = 4'b1111;
min = 4'b1001;
#(`CYC *1)
rst_n = 1;            
enable = 1;
flip = 0;
max = 4'b1111;
min = 4'b1001;
#(`CYC *20)
// unnornal max < min
rst_n = 1;            
enable = 1;
max = 4'b1001;
min = 4'b1111;

       

end



endmodule
//////////////////////////////////////////