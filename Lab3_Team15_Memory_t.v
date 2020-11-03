`timescale 1ns / 1ps

module Lab3_Team15_Memory_t();
reg clk = 1'b1 ;
reg ren, wen;
reg [7-1:0] addr;
reg [8-1:0] din;
wire [8-1:0] dout;
Memory name(.clk(clk), .ren(ren), .wen(wen), .addr(addr), .din(din), .dout(dout));

always #5 clk = ~clk;
initial begin
ren = 1'b0;
wen = 1'b0;
addr = 7'b0;
din = 8'b0;
#10;
ren = 1'b0;
wen = 1'b1;
addr = 7'd63;
din = 8'd4;
#10;
ren = 1'b0;
wen = 1'b1;
addr = 7'd45;
din = 8'd8;
#10;
ren = 1'b0;
wen = 1'b1;
addr = 7'd87;
din = 8'd35;
#50;
ren = 1'b1;
wen = 1'b0;
addr = 7'd45;
din = 8'd0;
#10;
ren = 1'b0;
wen = 1'b0;
addr =  7'd33;
din = 8'd0;
#10;
ren = 1'b1;
wen = 1'b1;
addr = 7'd87;
din = 8'd0;
end

endmodule
