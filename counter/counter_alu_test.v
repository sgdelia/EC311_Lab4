`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2020 10:56:29 AM
// Design Name: 
// Module Name: counter_alu_test
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


module counter_alu_test();
reg CLK100MHZ;
reg reset;
reg [7:0]newSeconds;
reg [7:0]newMinutes;
reg [7:0]newHours;
wire [7:0]hours;
wire [7:0]seconds;
wire [7:0]minutes;
// I am so sorry this is so long
counter_alu test_count(.reset(reset), .newSeconds(newSeconds), .newMinutes(newMinutes), .newHours(newHours), 
.hours(hours), .minutes(minutes), .seconds(seconds),.CLK100MHZ(CLK100MHZ));

initial begin
    CLK100MHZ = 0;
    newSeconds = 0;
    newMinutes = 0;
    newHours = 0;
    reset = 1;
    #10 reset = 0; // waits ten seconds, set reset to zero
end

always  #5 CLK100MHZ = ~CLK100MHZ; 

always begin
#10 {newHours, newMinutes, newSeconds } = {newHours, newMinutes, newSeconds} + 1;
// lines up with "positive edge" of the clock
// Toggled every 5 ns, total cycle takes 10
    if ({newHours, newMinutes, newSeconds} == 0)
      begin  $finish;
    end
end

endmodule
