`timescale 1ns / 1ps

module four_or(a, b, out);

input [7:0]a;
input [7:0]b;
output [7:0]out;

or  zero(out[0], a[0]);
or one(out[1], a[1]);
or two(out[2], a[2]);
or three(out[3], a[3]);
or four(out[4], a[4]);
or five(out[5], a[5]);
or six(out[6], a[6]);
or seven(out[7], a[7]);

endmodule
// When 0000 and 0000 at end, get 1111. Why?