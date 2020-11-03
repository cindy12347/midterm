`timescale 1ns/1ps 

module Parameterized_Ping_Pong_Counter (clk, rst_n, enable, flip, max, min, direction, out);
input clk, rst_n;
input enable;
input flip;
input [4-1:0] max;
input [4-1:0] min;
output direction;
output [4-1:0] out;

reg direction;
reg [4-1:0] out;
reg next_direction;
reg [4-1:0] next_out;

// for out and direction
////////////////////////////
always @(posedge clk) begin
    if(~rst_n)
        begin
        out <= min;
        direction <= 1'b1;
        end
    else
        begin
        out <= next_out;
        direction <= next_direction;
        end
end

// for next_out
///////////////////////////
always @(*) begin
    if (~enable)
        begin
        next_out = out;
        end
    else if (enable)
        begin
        if (max <= min)
            begin
            next_out = out;
            end
        else if (max > min)
            begin
            if (out > max)
                begin
                next_out = out;
                end
            else if (out < min)
                begin
                next_out = out;
                end
            else if (out <= max || out >= min)
                begin
                if (next_direction)
                    begin
                    next_out = out + 1'b1;
                    end
                else if (~next_direction)
                    begin
                    next_out = out - 1'b1;
                    end   
                end

            end
        end 
end

// for next_direction
//////////////////////////
always @(*) begin
    if (~enable)
        begin
        next_direction = direction;
        end
    else if (enable)
        begin
        if (max <= min)
            begin
            next_direction = direction;
            end
        else if (max > min)
            begin
            if (out == max)
                begin
                next_direction = 1'b0;
                end
            else if (out == min)
                begin
                next_direction = 1'b1;
                end
            else if (out > max || out < min)
                begin
                next_direction = direction;
                end
            else
                begin
                if (flip)
                    begin
                    next_direction = ~direction;
                    end
                else
                    begin
                    next_direction = direction;
                    end
                end
            end
        end

end

endmodule
