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
input [7:0] a;
input [7:0] b;
input c_in;
output [7:0] sum;
output c_out;

wire w1, w2, w3, w4, w5, w6, w7;
full_adder f0(.a(a[0]), .b(b[0]), .c_in(c_in), .sum(sum[0]), .c_out(w1));

full_adder f1(.a(a[1]), .b(b[1]), .c_in(w1), .sum(sum[1]), .c_out(w2));

full_adder f2(.a(a[2]), .b(b[2]), .c_in(w2), .sum(sum[2]), .c_out(w3));

full_adder f3(.a(a[3]), .b(b[3]), .c_in(w3), .sum(sum[3]), .c_out(w4));

full_adder f4(.a(a[4]), .b(b[4]), .c_in(w4), .sum(sum[4]), .c_out(w5));

full_adder f5(.a(a[5]), .b(b[5]), .c_in(w5), .sum(sum[5]), .c_out(w6));

full_adder f6(.a(a[6]), .b(b[6]), .c_in(w6), .sum(sum[6]), .c_out(w7));

full_adder f7(.a(a[7]), .b(b[7]), .c_in(w7), .sum(sum[7]), .c_out(c_out));

endmodule
