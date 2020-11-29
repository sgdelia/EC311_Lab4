`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/12/2020 10:48:51 AM
// Design Name: 
// Module Name: plus_one
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


module plus_one(
    input [7:0] a,
    output cout,
    output [7:0] out
    );
    wire [7:0] one ;
    wire cin;
    assign one = 8'b00000001;
    assign cin = 0;
    
    cla_adder plus1 (.a(a),.b(one), .c_in(cin), .c_out(cout), .sum(out));
    
endmodule
