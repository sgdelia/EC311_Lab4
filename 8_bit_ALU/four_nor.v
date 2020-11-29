`timescale 1ns / 1ps

module four_nor(a, b, out);

input [7:0]a;
input [7:0]b;
output [7:0]out;

nor  zero(out[0], a[0]);
nor one(out[1], a[1]);
nor two(out[2], a[2]);
nor three(out[3], a[3]);
nor four(out[4], a[4]);
nor five(out[5], a[5]);
nor six(out[6], a[6]);
nor seven(out[7], a[7]);

endmodule
// When 0000 and 0000 at end, get 1111. Why?