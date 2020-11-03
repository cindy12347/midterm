module Parameterized_Ping_Pong_Counter (clk, rst_n, enable, flip, max, min, direction, out);
input clk, rst_n;
input enable;
input flip;
input [4-1:0] max;
input [4-1:0] min;
output direction;
output [4-1:0] out;
reg [4-1:0] nextout;
reg [4-1:0] out;
reg nextdirection;

reg direction = 1'b1;
always @(posedge clk) begin
    if(rst_n == 0) begin
        out <= min;
        direction <= 1'b1;
    end 
    else begin
        out <= nextout;
        direction <= nextdirection;
    end
end
always @(*) begin
    if (~enable) nextout = out;
    else begin     
        if (max <= min) nextout = out;
        else begin 
            if (out > max) nextout = out;
            else if (out < min) nextout = out;
            else begin  
                if (nextdirection==1) nextout = out + 1;
                else nextout = out - 1; 
            end
        end
    end
end
always @(*) begin
    if(~enable) nextdirection = direction;
    else begin  
        if(max <= min) nextdirection = direction;
        else begin 
            if (out > max) nextdirection = direction;
            else if (out < min) nextdirection = direction;
            else if (out == max) nextdirection = 0;
            else if (out == min) nextdirection = 1;
            else begin
                if (flip == 1) nextdirection = ~direction;
                else nextdirection = direction; 
            end
        end
    end
end
endmodule