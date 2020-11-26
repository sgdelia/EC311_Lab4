`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/25/2020 04:36:41 PM
// Design Name: 
// Module Name: set_alarm
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


module set_alarm(
input [1:0]position,
input [7:0]set_hour, // input from a set_time function used for the alarm
input [7:0]set_minute,
input [7:0]set_second,
input reset,
input turn_on,
input [7:0]current_hours, // input from the counter
input [7:0]current_minutes,
input [7:0]current_seconds,
output reg alarm_going_off
    );

always @ (reset) begin
    alarm_going_off = 0;
end
    
    // use a set time function in the top module to set the alarm inputs
    always @ (*) begin
        if (turn_on == 1) begin // if the alarm is turned on
            if ((( current_hours == set_hour) && (current_minutes == set_minute)) && (current_seconds == set_second)) begin
            // if it's the right time
                alarm_going_off = 1;
            end // end check time
        end // end turn_on
        if (turn_on == 0) begin
            alarm_going_off = 0;
        end
    end // end always
    
    
endmodule
