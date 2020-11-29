`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Ian Chadwick
// 
// Create Date: 10/10/2020 10:33:35 PM
// Design Name: 
// Module Name: cla_subtract
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


module cla_subtract(
    input [3:0] a,
    input [3:0] b,
    input cin,
    output [3:0] sum,
    output cout
    );
wire [3:0] p,g;
wire [4:0] c;
wire [3:0] negative_b;


assign p = a ^ (negative_b);
assign g = a & (negative_b);

negate twos_comp (.a(b), .out(negative_b));

cla_block main (p,g,cin,c);

assign sum = p ^ c [3:0];
assign cout = c[4];
endmodule


/*module cla_block (
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