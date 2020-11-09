`timescale 1ns / 1ps

module half_adder(a,b,sum,c_out);
input a;
input b;
output sum, c_out;

    xor G1(sum, a, b);
    and G2(c_out, a, b);
 endmodule