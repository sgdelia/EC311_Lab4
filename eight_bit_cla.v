`timescale 1ns / 1ps


module eight_bit_cla(
    input [7:0] p,g,
    input cin,
    output [8:0] c
    );

assign c[0] = cin;
assign c[1] = g[0] | (p[0] & cin);
assign c[2] = g[1] | (p[1]&g[0]) |  (p[1]&p[0]&cin);
assign c[3] = g[2] | (p[2]&g[1]) | (p[2]&p[1]&g[0]) | (p[2]&p[1]&p[0]&cin);
assign c[4] = g[3] | (p[3]&g[2]) | (p[3]&p[2]&g[1]) | (p[3]&p[2]&p[1]&g[0]) | (p[3]&p[2]&p[1]&p[0]&cin);
assign c[5] = g[4] | (p[4]&g[3]) | (p[4]&p[3]&g[2]) | (p[4]&p[3]&p[2]&p[1]&g[0]) | (p[4]&p[3]&p[2]&p[1]&p[0]&cin);
assign c[6] = g[5] | (p[5]&g[4]) | (p[5]&p[4]&g[3]) | (p[5]&p[4]&p[3]&g[2]) | (p[5]&p[4]&p[3]&p[2]&p[1]&g[0]) | (p[5]&p[4]&p[3]&p[2]&p[1]&p[0]&cin);
assign c[7] = g[6] | (p[6]&g[5]) 
                   | (p[6]&p[5]&g[4]) 
                   | (p[6]&p[5]&p[4]&g[3]) 
                   | (p[6]&p[5]&p[4]&p[3]&g[2]) 
                   | (p[6]&p[5]&p[4]&p[3]&p[2]&p[1]&g[0]) 
                   | (p[6]&p[5]&p[4]&p[3]&p[2]&p[1]&p[0]&cin);

assign c[8] = g[7] | (p[7]&g[6]) 
                   | (p[6]&g[5]) 
                   | (p[7]&p[6]&p[5]&g[4]) 
                   | (p[7]&p[6]&p[5]&p[4]&g[3]) 
                   | (p[7]&p[6]&p[5]&p[4]&p[3]&g[2]) 
                   | (p[7]&p[6]&p[5]&p[4]&p[3]&p[2]&p[1]&g[0]) 
                   | (p[7]&p[6]&p[5]&p[4]&p[3]&p[2]&p[1]&p[0]&cin);
endmodule
