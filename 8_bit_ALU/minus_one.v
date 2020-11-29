`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/12/2020 10:48:51 AM
// Design Name: 
// Module Name: minus_one
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


module minus_one(
    input [3:0] a,
    input c_in,
    output [3:0] out
    );
    
    wire cout;
    
    cla_subtract sub1 (.a(a), .b(4'b0001), .cin(c_in), .sum(out), .cout(cout));
    
        
endmodule
