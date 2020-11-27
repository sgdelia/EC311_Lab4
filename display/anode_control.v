`timescale 1ns / 1ps


module anode_control(
input [2:0] refresh_count,
output reg [7:0] anode
);

always @(refresh_count)
begin
    case(refresh_count)
        3'b000:
            anode = 8'b01111111; //far left anode 0
        3'b001:
            anode = 8'b10111111; // anode 1
        3'b010:
            anode = 8'b11011111; // anode 2
        3'b011:
            anode = 8'b11101111; // anode 3
        3'b100:
            anode = 8'b11110111; // anode 4
        3'b101:
            anode = 8'b11111011; // anode 5
        3'b110:
            anode = 8'b11111101; // anode 6
        3'b111:
            anode = 8'b11111110; //far right anode 7
    endcase
end
endmodule
