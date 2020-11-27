`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2020 05:59:41 PM
// Design Name: 
// Module Name: decoder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module decoder(

input [7:0]hours_in,
input [7:0]minutes_in,
input [7:0]seconds_in,
output reg[7:0]hours_out,
output reg[7:0]minutes_out,
output reg[7:0]seconds_out,
output reg PM_LED
    );
    
always @ (*)begin
    if (hours_in == 0) begin
        hours_out = 12;
        minutes_out = minutes_in;
        seconds_out = seconds_in;
        PM_LED = 0;
    end // end hours_in == 0
    if (hours_in > 0 && hours_in < 12) begin
        hours_out = hours_in;
        minutes_out = minutes_in;
        seconds_out = seconds_in;
        PM_LED = 0;
    end // end hours_in < 12 && >0
    if (hours_in == 12) begin
        hours_out = 12;
        minutes_out = minutes_in;
        seconds_out = seconds_in;
        PM_LED = 1;
    end // end hours_in ==12
    if (hours_in > 12) begin
        hours_out = hours_in - 12;
        minutes_out = minutes_in;
        seconds_out = seconds_in;
        PM_LED = 1;
    end // end hours_in > 12
end // end always
endmodule
