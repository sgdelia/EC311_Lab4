`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/12/2020 10:48:51 AM
// Design Name: 
// Module Name: negate
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


module negate(
    input [7:0] a,
    output [7:0] out
    );
    
    //holds intermediate value
    wire [7:0] inv;
    wire cout;
    //inverts a
    four_not_a invert (.a(a), .out(inv));
    //adds one and outputs two's comp
    plus_one add1 (.a(inv), .cout(cout), .out(out));
    
endmodule
