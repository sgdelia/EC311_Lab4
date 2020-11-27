`timescale 1ns / 1ps


module BCD_to_segments (
input [3:0] digit,
output reg [6:0] LED_out

);

always@(digit)
    begin
    case(digit)
                    4'b0000 : LED_out = 7'b0000001;
                    4'b0001 : LED_out = 7'b1001111;
                    4'b0010 : LED_out <= 7'b0010010;
                    4'b0011 : LED_out <= 7'b0000110;
                    4'b0100 : LED_out <= 7'b1001100;          
                    4'b0101 : LED_out <= 7'b0100100;
                    4'b0110 : LED_out <= 7'b0100000;
                    4'b0111 : LED_out <= 7'b0001111;
                    4'b1000 : LED_out <= 7'b0000000;
                    4'b1001 : LED_out <= 7'b0000100;
                    4'b1010 : LED_out <= 7'b0001000;
                    4'b1011 : LED_out <= 7'b1100000;
                    4'b1100 : LED_out <= 7'b0110001;
                    4'b1101 : LED_out <= 7'b1000010;
                    4'b1110 : LED_out <= 7'b0110000;
                    4'b1111 : LED_out <= 7'b0111000; 
                    default : LED_out <= 7'b0000001;
             endcase  
           end

endmodule