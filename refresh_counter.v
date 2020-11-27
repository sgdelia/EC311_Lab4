`timescale 1ns / 1ps

module refresh_counter (
input refresh_clock,
output reg [2:0] refresh_count
);

always @(posedge refresh_clock) refresh_count <= refresh_count +1;

endmodule