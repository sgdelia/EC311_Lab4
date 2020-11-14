`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/09/2020 11:56:11 AM
// Design Name: 
// Module Name: cla_block
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
