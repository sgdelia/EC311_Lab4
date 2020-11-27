`timescale 1ns / 1ps

module mode_select(
input clk,
input bttn,
output reg [1:0] current_mode = 2'b00);

wire slw_clk;
wire Q1, Q2, Q2_bar;
wire bttn_out;

clock_divider clk_div (.clk(clk), .divided_clk(slw_clk));

sm_ff d1 (.clk(slw_clk), .D(bttn), .Q(Q1));
sm_ff d2 (.clk(slw_clk), .D(Q1), .Q(Q2));

assign Q2_bar = ~Q2;
assign bttn_out = Q1 & Q2_bar;

always @(posedge slw_clk) 
    begin
    if (bttn_out == 1'b1)
    current_mode <= current_mode +1;
    else
    current_mode <= current_mode;
    end
    
endmodule
