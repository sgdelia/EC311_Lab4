
`timescale 1ns / 1ps

module four_not_a(a, out);

input [7:0]a;
output [7:0]out;

not  zero(out[0], a[0]);
not one(out[1], a[1]);
not two(out[2], a[2]);
not three(out[3], a[3]);
not four(out[4], a[4]);
not five(out[5], a[5]);
not six(out[6], a[6]);
not seven(out[7], a[7]);

endmodule
// When 0000 and 0000 at end, get 1111. Why?