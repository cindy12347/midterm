`timescale 1ns / 1ps


module Lab1_TeamX_Decoder_t();
    reg [4-1:0] din;
    wire [16-1:0] dout;
    
    Decoder name(din, dout);
    initial begin   
    din = 4'b0000;#100;
    din = 4'b0001;#100;
    din = 4'b0010;#100;
    din = 4'b0011;#100;
    din = 4'b0100;#100;
    din = 4'b0101;#100;
    din = 4'b0110;#100;
    din = 4'b0111;#100;
    din = 4'b1000;#100;
    din = 4'b1001;#100;
    din = 4'b1010;#100;
    din = 4'b1011;#100;
    din = 4'b1100;#100;
    din = 4'b1101;#100;
    din = 4'b1110;#100;
    din = 4'b1111;#100;
    end
endmodule
