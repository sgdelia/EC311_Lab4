
`timescale 1ns / 1ps

module four_not_b(b, out);

input [7:0]b;
output [7:0]out;

not  zero(out[0], b[0]);
not one(out[1], b[1]);
not two(out[2], b[2]);
not three(out[3], b[3]);
not four(out[4], b[4]);
not five(out[5], b[5]);
not six(out[6], b[6]);
not seven(out[7], b[7]);
endmodule
// When 0000 and 0000 at end, get 1111. Why?