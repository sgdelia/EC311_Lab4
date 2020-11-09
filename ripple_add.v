`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/29/2020 03:44:25 PM
// Design Name: 
// Module Name: ripple_add
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


module ripple_add(a, b , c_in, sum, c_out);
input [2:0] a;
input [2:0] b;
input c_in;
output [2:0] sum;
output c_out;

wire w1, w2;
full_adder f1(.a(a[0]), .b(b[0]), .c_in(c_in), .sum(sum[0]), .c_out(w1));

full_adder f2(.a(a[1]), .b(b[1]), .c_in(w1), .sum(sum[1]), .c_out(w2));

full_adder f3(.a(a[2]), .b(b[2]), .c_in(w2), .sum(sum[2]), .c_out(c_out));

endmodule
