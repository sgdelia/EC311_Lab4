`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/13/2020 10:15:14 AM
// Design Name: 
// Module Name: full_alu
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


module full_alu(
input [7:0] a,
input [7:0] b,
input c_in,
input [2:0] Op,
input mode,
output reg [7:0] out,
output reg c_out
    );
wire [7:0]final_out[1:0];
wire final_c_out[1:0];

    arithmetic_alu a1(.a(a), .b(b), .c_in(c_in), .Op(Op), .out(final_out[0]), .c_out(final_c_out[0]));
    logical_alu l1(.a(a), .b(b), .c_in(c_in), .Op(Op), .out(final_out[1]), .c_out(final_c_out[1]));
    
    always @ (*) begin
        case(mode)
           1'b1: begin
           out <= final_out[0];
           c_out <= final_c_out[0];
           end
           1'b0: begin
           out <= final_out[1];
           c_out <= final_c_out[1];
           end
         endcase
    end
    
endmodule
