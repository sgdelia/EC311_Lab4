`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2020 10:25:27 AM
// Design Name: 
// Module Name: logical_alu
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module logical_alu(
input [3:0]a,
input [3:0]b,
input c_in,
input [2:0]Op,
output reg [3:0]out,
output c_out
);
wire [3:0]final_out[7:0]; // 4 bit output, 8 out options. Side note: This is how you do a 2D array!
reg [6:0]seven_out;
reg [3:0] anodes;
four_and f0(.a(a), .b(b), .out(final_out[0]));
four_or f1(.a(a), .b(b), .out(final_out[1]));
four_nand f2(.a(a), .b(b), .out(final_out[2]));
four_nor f3(.a(a), .b(b), .out(final_out[3]));
four_xor f4(.a(a), .b(b), .out(final_out[4]));
four_xnor f5(.a(a), .b(b), .out(final_out[5]));
four_not_a f6(.a(a), .out(final_out[6]));
four_not_b f7(.b(b), .out(final_out[7]));

// Works with LEDs
always @(*) begin
    case(Op)
       3'b000: out <= final_out[0]; // and
       3'b001: out <= final_out[1]; // or
       3'b010: out <= final_out[2]; // nand
       3'b011: out <= final_out[3]; // nor
       3'b100: out <= final_out[4]; // xor
       3'b101: out <= final_out[5]; // xnor
       3'b110: out <= final_out[6]; // not a
       3'b111: out <= final_out[7]; // not b
    endcase
end        
endmodule

