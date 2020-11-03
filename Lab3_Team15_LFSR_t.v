`timescale 1ns / 1ps

module Lab3_Team15_LFSR_t();
reg clk = 1'b1 ;
reg rst_n = 1'b1;
wire out;
LFSR name(.clk(clk), .rst_n(rst_n), .out(out));

always #2 clk = ~clk;
initial begin
@ (negedge clk)
  rst_n = 1'b0;
@ (negedge clk)
  rst_n = 1'b1;
end
endmodule
