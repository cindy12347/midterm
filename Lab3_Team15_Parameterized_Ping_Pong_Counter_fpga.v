`timescale 1ns/1ps 

module Parameterized_Ping_Pong_Counter_fpga(clk, reset, flip, SW, an, segment);
input clk;
input reset;
input flip;
input [15:7] SW;
output [4-1:0] an;
output [8-1:0] segment;
wire clk_div25;
wire direction;
wire [4-1:0] digits;
wire debounced_reset;
wire debounced_flip;
wire onepulsed_reset;
wire onepulsed_flip;
clockdivider25 clkdiv25(.clk(clk), .clk_div(clk_div25));
Parameterized_Ping_Pong_Counter designp
(
    .clk(clk_div25), 
    .rst_n(~onepulsed_reset), 
    .enable(SW[15]), 
    .flip(onepulsed_flip), 
    .max(SW[14:11]), 
    .min(SW[10:7]), 
    .direction(direction),
    .out(digits)
);
seven_segment_display seven
(
    .clk(clk),
    .direction(direction),
    .digits(digits),
    .an(an),
    .segment(segment)
);
debounce deb_reset
(
    .pb_debounced(debounced_reset),
    .pb(reset),
    .clk(clk)
);
onepulse pulse_reset
(
    .PB_debounced(debounced_reset),
    .CLK(clk_div25),
    .PB_one_pulse(onepulsed_reset)
);
debounce deb_flip
(
    .pb_debounced(debounced_flip),
    .pb(flip),
    .clk(clk)
);
onepulse pulse_flip
(
    .PB_debounced(debounced_flip),
    .CLK(divided_clk25),
    .PB_one_pulse(onepulsed_flip)
);
endmodule
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module seven_segment_display(clk,direction,digits,an,segment);
input clk;
input direction;
input [3:0] digits;
output [3:0] an;
output [7:0] segment;
reg [3:0] an = 4'b1110;
reg [7:0] segment;
reg [7:0] four_digit [3:0];
wire clk_div17;
clockdivider17 clkdiv17(.clk(clk),.clk_div(clk_div17));
always @(posedge clk_div17)
begin
    an <= {an[2:0],an[3]};    
end
always @(*)
begin
    if(digits >= 4'b1010) 
        four_digit[3] = 8'b11111001;   
    else 
        four_digit[3] = 8'b11000000;    
    case(digits % 10)
        0: four_digit[2] = 8'b11000000;
        1: four_digit[2] = 8'b11111001;
        2: four_digit[2] = 8'b10100100;
        3: four_digit[2] = 8'b10110000;
        4: four_digit[2] = 8'b10011001;
        5: four_digit[2] = 8'b10010010;
        6: four_digit[2] = 8'b10000010;
        7: four_digit[2] = 8'b11111000;
        8: four_digit[2] = 8'b10000000;
        9: four_digit[2] = 8'b10010000;
        default : four_digit[2] = 8'b11000000;
    endcase
end
always @(*)
begin
    if(direction == 1) begin
        four_digit[0] = 8'b11011100;
        four_digit[1] = 8'b11011100;
    end
    else if(direction == 0) begin
        four_digit[0] = 8'b11100011;
        four_digit[1] = 8'b11100011;
    end
end
always @(*) begin
    case(an)
        4'b1110:segment = four_digit[0]; 
        4'b1101:segment = four_digit[1]; 
        4'b1011:segment = four_digit[2]; 
        4'b0111:segment = four_digit[3];
        default :segment = four_digit[0];
    endcase 
end
endmodule
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module clockdivider17(clk, clk_div);   
input clk;
output clk_div;

reg [17-1:0] count;
wire [17-1:0] nextcount;

always @(posedge clk) begin
    count <= nextcount;
end

assign nextcount = count + 1;
assign divided_clk = count[17-1];

endmodule
/////////////////////////////////
module clockdivider25(clk, clk_div);  
input clk;
output clk_div;

reg [25-1:0] count;
wire [25-1:0] nextcount;

always @(posedge clk) begin
    count <= nextcount;
end

assign nextcount = count + 1;
assign divided_clk = count[25-1];

endmodule
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module debounce(pb_debounced,pb,clk);

output pb_debounced;   
input pb;  
input clk;   
reg [1:0] DFF; 
always @(posedge clk) begin
    DFF[1] <= DFF[0];
    DFF[0] <= pb;
end
assign pb_debounced = ((DFF == 2'b11) ? 1'b1 : 1'b0);
endmodule
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module onepulse(PB_debounced,CLK,PB_one_pulse);
input PB_debounced;
input CLK;
output PB_one_pulse;
reg PB_one_pulse;
reg PB_debounced_delay;
always @(posedge CLK)  begin
    PB_one_pulse <= PB_debounced & (!PB_debounced_delay);
    PB_debounced_delay <= PB_debounced;
end
endmodule
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
    if(enable == 0) nextout = out;
    else begin     
        if(max <= min) nextout = out;
        else begin 
            if(out > max) nextout = out;
            else if(out < min) nextout = out;
            else begin  
                if(nextdirection==1) nextout = out + 1;
                else nextout = out - 1; 
            end
        end
    end
end
always @(*) begin
    if(enable == 0) nextdirection = direction;
    else begin  
        if(max <= min) nextdirection = direction;
        else begin 
            if (out > max) nextdirection = direction;
            else if(out < min) nextdirection = direction;
            else if(out == max) nextdirection = 0;
            else if(out == min) nextdirection = 1;
            else begin
                if(flip == 1) nextdirection = ~direction;
                else nextdirection = direction; 
            end
        end
    end
end
endmodule
////////////////////////////////////////////////////////////////////////////////////////////////////////
//the end