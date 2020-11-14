`timescale 1ns / 1ps

module four_and(a, b, out);

input [7:0]a;
input [7:0]b;
output [7:0]out;

and  zero(out[0], a[0]);
and one(out[1], a[1]);
and two(out[2], a[2]);
and three(out[3], a[3]);
and four(out[4], a[4]);
and five(out[5], a[5]);
and six(out[6], a[6]);
and seven(out[7], a[7]);
endmodule
// When 0000 and 0000 at end, get 1111. Why?