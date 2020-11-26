`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/25/2020 05:12:06 PM
// Design Name: 
// Module Name: set_alarm_test
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


module set_alarm_test(

    );
    
    reg [1:0]position;
    reg [7:0]set_hour;
    reg [7:0]set_minute;
    reg [7:0]set_second;
    reg reset;
    reg turn_on;
    reg [7:0]hours;
    reg [7:0]minutes;
    reg [7:0]seconds;
    wire alarm_going_off;
    
    set_alarm testSetAlarm(.position(position), .set_hour(set_hour), .set_minute(set_minute), 
    .set_second(set_second), .current_hours(hours), .current_minutes(minutes), .current_seconds(seconds),
    .reset(reset), .turn_on(turn_on), .alarm_going_off(alarm_going_off));
    
    initial begin
        turn_on = 0;
        reset = 1;
        #10 reset = 0;
        hours = 0;
        minutes = 0;
        seconds = 0;
    end
    //always #5 add_press = ~add_press;
    //always #150 sub_press = ~sub_press;
    always begin
    // every ten ms, change one of the inputs
    // then change position
    // Just change variables one at a time
    #500 turn_on = 1;
    #10 hours = hours + 1;
    #10 seconds = seconds + 1;
    #10 minutes = minutes + 1;
    position = 0;
    set_hour = 6;
    #10 position = 1;
    #10 set_minute = 6;
    #10 position = 2;
    #10 set_second = 6;
    #1600 turn_on = 0;  
    end
    
    
endmodule
