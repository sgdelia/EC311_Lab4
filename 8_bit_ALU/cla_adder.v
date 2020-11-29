`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/10/2020 08:48:46 PM
// Design Name: 
// Module Name: cla_adder
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
// Note: Formerly a CLA Adder, now an 8 bit carry select

module cla_adder(
input [7:0]a,
input [7:0]b,
input c_in,
output [7:0]sum,
output c_out
);

carry_select ALU_CS(.a(a), .b(b), .c_in(c_in), .sum(sum), .c_out(c_out));

endmodule



// Old CLA code, for reference
/*
module cla_adder(
    input [3:0] a,
    input [3:0] b,
    input cin,
    output [3:0] sum,
    output cout
    );
wire [3:0] p,g;
wire [4:0] c;

assign p = a^b;
assign g = a&b;

cla_block main (p,g,cin,c);

assign sum = p ^ c [3:0];
assign cout = c[4];
endmodule

module cla_block (
    input [3:0] p,g,
    input cin,
    output [4:0] c
    );

assign c[0] = cin;
assign c[1] = g[0] | (p[0] & cin);
assign c[2] = g[1] | (p[1]&g[0]) |  (p[1]&p[0]&cin);
assign c[3] = g[2] | (p[2]&g[1]) | (p[2]&p[1]&g[0]) | (p[2]&p[1]&p[0]&cin);
assign c[4] = g[3] | (p[3]&g[2]) | (p[3]&p[2]&g[1]) | (p[3]&p[2]&p[1]&g[0]) | (p[3]&p[2]&p[1]&p[0]&cin);
endmodule
*/