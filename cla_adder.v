`timescale 1ns / 1ps


module cla_adder(
    input [7:0] a,
    input [7:0] b,
    input c_in,
    output [7:0] sum,
    output c_out
    );
    
wire [7:0] p,g;
wire [8:0] c;

assign p[7:0] = a[7:0]^b[7:0];
assign g[7:0] = a[7:0]&b[7:0];

eight_bit_cla adder1 (.p(p),.g(g),.cin(c_in),.c(c));

assign sum [7:0] = p[7:0] ^ c [7:0];
assign c_out = c[8];
endmodule

