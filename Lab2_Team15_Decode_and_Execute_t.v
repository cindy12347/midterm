`timescale 1ns / 1ps
module Decode_and_Execute_t();
reg [3-1:0] op_code;
reg [4-1:0] rs, rt;
wire [4-1:0] rd;
Decode_and_Execute fun1(op_code, rs, rt, rd);
    initial begin
        op_code = 3'b111;
        repeat (2 ** 3) begin
            op_code = op_code + 3'b1;
            rs = 4'b1000;rt = 4'b0001;#5;
        end
        
        op_code = 3'b111;
        repeat (2 ** 3) begin
            op_code = op_code + 3'b1;
            rs = 4'b1111;rt = 4'b1100;#5;
        end
        
        op_code = 3'b111;
        repeat (2 ** 3) begin
            op_code = op_code + 3'b1;
            rs = 4'b1011;rt = 4'b0101;#5;
        end
    end
endmodule
