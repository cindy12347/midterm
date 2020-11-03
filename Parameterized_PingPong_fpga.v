`timescale 1ns/1ps
`define zer 7'b1000000
`define one 7'b1111001
`define two 7'b0100100
`define thr 7'b0110000
`define fou 7'b0011001
`define fiv 7'b0010010
`define six 7'b0000010
`define sev 7'b1011000
`define eig 7'b0000000
`define nin 7'b0010000
`define upp 7'b1011100
`define dow 7'b1100011

module Parameterized_Ping_Pong_Counter_fpga(clk, rst_n, enable, flip, max, min, led, an);
input clk, rst_n;
input enable;
input flip;
input [4-1:0] max;
input [4-1:0] min;
output [7-1:0] led;
output [4-1:0] an;

wire clk_div17, clk_div25;
wire rst_n_debounced, rst_n_one_pulse;
wire flip_debounced, flip_one_pulse;
wire direction;
wire [4-1:0] out;
wire [7-1:0] sev_seg_3, sev_seg_2, sev_seg_1, sev_seg_0;
wire [4-1:0] an;


clock_divider_17 fun3(
    .clk(clk), 
    .clk_div17(clk_div17)
);
clock_divider_25 fun4(
    .clk(clk), 
    .clk_div25(clk_div25)
);
debounce debounce_reset(
    .pb(rst_n), 
    .clk(clk), 
    .pb_debounced(rst_n_debounced)
);
onepulse onepluse_reset(
    .pb_debounced(rst_n_debounced), 
    .clk(clk_div25), 
    .pb_one_pulse(rst_n_one_pulse)
);
debounce debounce_enable(
    .pb(flip), 
    .clk(clk), 
    .pb_debounced(flip_debounced)
);
onepulse onepluse_enable(
    .pb_debounced(flip_debounced), 
    .clk(clk_div25), 
    .pb_one_pulse(flip_one_pulse)
);
Parameterized_Ping_Pong_Counter fun0(
    .clk(clk_div25), 
    .rst_n(~rst_n_one_pulse), 
    .enable(enable), 
    .flip(flip_one_pulse), 
    .max(max), 
    .min(min), 
    .direction(direction), 
    .out(out)
);
seven_segment fun1(
    .out(out), 
    .direction(direction),
    .an(an),
    .sev_seg_3(sev_seg_3), 
    .sev_seg_2(sev_seg_2), 
    .sev_seg_1(sev_seg_1), 
    .sev_seg_0(sev_seg_0),
    .led(led)
);
seven_segment_display fun2(
    .clk(clk_div17),
    .sev_seg_3(sev_seg_3), 
    .sev_seg_2(sev_seg_2), 
    .sev_seg_1(sev_seg_1), 
    .sev_seg_0(sev_seg_0), 
    .an(an)
);

endmodule





// decide 7_seg_displayer
///////////////////////////////////////////////////////////////////
module seven_segment_display(clk, sev_seg_3, sev_seg_2, sev_seg_1, sev_seg_0, an);
input clk;
input [7-1:0] sev_seg_3, sev_seg_2, sev_seg_1, sev_seg_0;
output [4-1:0] an;

reg [4-1:0] an = 4'b1110;

always @(posedge clk) begin
    an <= {an[0], an[3:1]};
end

endmodule
// decide 7_seg
/////////////////////////////////////////////////////////////////
module seven_segment(out, direction, an, sev_seg_3, sev_seg_2, sev_seg_1, sev_seg_0, led);
input [4-1:0] an;
input [4-1:0] out;
input direction;
output [7-1:0] sev_seg_3, sev_seg_2, sev_seg_1, sev_seg_0;
output [7-1:0] led;

reg [7-1:0] led;
reg [7-1:0] sev_seg_3, sev_seg_2, sev_seg_1, sev_seg_0;

always @(*) begin
    case(an)
        4'b1110: led <= sev_seg_0;
        4'b1101: led <= sev_seg_1;
        4'b1011: led <= sev_seg_2;
        4'b0111: led <= sev_seg_3;
    endcase
end

always @(*) begin
    if (out >= 4'b1010)
        begin
        sev_seg_3 = `one;
        end
    else if (out < 4'b1010)
        begin
        sev_seg_3 = `zer;
        end
    case(out % 10)
        0 : sev_seg_2 = `zer;
        1 : sev_seg_2 = `one;
        2 : sev_seg_2 = `two;
        3 : sev_seg_2 = `thr;
        4 : sev_seg_2 = `fou;
        5 : sev_seg_2 = `fiv;
        6 : sev_seg_2 = `six;
        7 : sev_seg_2 = `sev;
        8 : sev_seg_2 = `eig;
        9 : sev_seg_2 = `nin;
    endcase
    if (direction)
        begin
        sev_seg_1 = `upp;
        sev_seg_0 = `upp;
        end
    else
        begin
        sev_seg_1 = `dow;
        sev_seg_0 = `dow;
        end
end
endmodule
// clock divider
///////////////////////////////////////////////////////////////////
module clock_divider_17(clk, clk_div17);
input clk;
output clk_div17;
reg [17-1:0] count;
wire [17-1:0] next_count; 
always @(posedge clk) begin
    count <= next_count;
end
assign next_count = count + 17'b1;
assign clk_div17 = count[16];
endmodule

module clock_divider_25(clk, clk_div25);
input clk;
output clk_div25;
reg [25-1:0] count;
wire [25-1:0] next_count;
always @(posedge clk) begin
    count <= next_count;
end
assign next_count = count + 25'b1;
assign clk_div25 = count[24];
endmodule
// one-pulse circuit
//////////////////////////////////////////////////////////////////
module onepulse(pb_debounced, clk, pb_one_pulse);
input pb_debounced;
input clk;
output pb_one_pulse;

reg pb_one_pulse;
reg pb_debounced_delay;

always @(posedge clk) begin
    pb_one_pulse <= pb_debounced & (!pb_debounced_delay);
    pb_debounced_delay <= pb_debounced;
end

endmodule
// debounce circuit
//////////////////////////////////////////////////////////////////
module debounce(pb, clk, pb_debounced);
    input pb;
    input clk;
    output pb_debounced;

    reg [4-1:0] DFF;

    always @(posedge clk) begin
        DFF[3:1] <= DFF[2:0];
        DFF[0] <= pb;
    end
    
    assign pb_debounced = ((DFF == 4'b1111) ? 1'b1 : 1'b0);
endmodule

// main design
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
