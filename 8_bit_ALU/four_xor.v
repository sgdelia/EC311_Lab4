`timescale 1ns / 1ps

module four_xor(a, b, out);

input [7:0]a;
input [7:0]b;
output [7:0]out;

xor  zero(out[0], a[0]);
xor one(out[1], a[1]);
xor two(out[2], a[2]);
xor three(out[3], a[3]);
xor four(out[4], a[4]);
xor five(out[5], a[5]);
xor six(out[6], a[6]);
xor seven(out[7], a[7]);

endmodule
// When 0000 and 0000 at end, get 1111. Why?