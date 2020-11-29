`timescale 1ns / 1ps

module four_nand(a, b, out);

input [7:0]a;
input [7:0]b;
output [7:0]out;

nand  zero(out[0], a[0]);
nand one(out[1], a[1]);
nand two(out[2], a[2]);
nand three(out[3], a[3]);
nand four(out[4], a[4]);
nand five(out[5], a[5]);
nand six(out[6], a[6]);
nand seven(out[7], a[7]);

endmodule
// When 0000 and 0000 at end, get 1111. Why?