`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/28/2020 01:39:48 PM
// Design Name: 
// Module Name: full_adder
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


module full_adder(
    input a,
    input b,
    input c_in,
    output sum,
    output c_out
    );
    
    wire w1, w2, w3;
   or(c_out, w3, w2);
   half_adder M3(c_in, w1, sum, w3);
   half_adder M2(a, b, w1, w2);
   // input, input, xor, and
   // w1 = 0, w2 = 1
   // sum = 0, w3 = 0
   
    
endmodule
