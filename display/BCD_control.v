`timescale 1ns / 1ps


module BCD_control (
input [2:0] refresh_count,
input [3:0] digit0,
            digit1,
            digit2,
            digit3,
            digit4,
            digit5,
            digit6,
            digit7,
output reg [3:0] display_digit //choose which digit to display
);

always @(refresh_count)
begin
    case(refresh_count)
        3'b000:
            display_digit = digit0; //digit 0 ON
        3'b001:
            display_digit = digit1; //digit 1 ON
        3'b010:
            display_digit = digit2; //digit 2 ON
        3'b011:
            display_digit = digit3; //digit 3 ON
        3'b100:
            display_digit = digit4; //digit 4 ON
        3'b101:
            display_digit = digit5; //digit 5 ON
        3'b110:
            display_digit = digit6; //digit 6 ON
        3'b111:
            display_digit = digit7; //digit 7 ON
    endcase

end

endmodule