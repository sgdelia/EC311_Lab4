`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2020 10:30:56 AM
// Design Name: 
// Module Name: counter_alu
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


module counter_alu(
input CLK100MHZ,
input [7:0]newHours, // used for setting time
input [7:0]newSeconds, // used for setting time
input [7:0]newMinutes, // used for setting time
input reset, // Used for initializing at zero
output reg [7:0]hours,
output reg [7:0]minutes,
output reg [7:0]seconds
// outputs answer in BCD; uncomment lines 29-31 for 8-bit output
/*
output [3:0]hoursTens,
output [3:0]hoursOnes,
output [3:0]minutesTens,
output [3:0]minutesOnes,
output [3:0]secondsTens,
output [3:0]secondsOnes
*/
    );
   /* 
   reg [7:0]seconds;
   reg [7:0]minutes;
   reg [7:0]hours;
   */     
    // counts until 24:60:60
    // 8 bit in/out so it's compatible with the ALU
    // Eventually, this is going to use the add 1 function from the ALU. Until then, I'm just adding one so we have 
    // Something to test
    // https://www.fpga4student.com/2016/11/verilog-code-for-alarm-clock-on-fpga.html
    // https://vhdlwhiz.com/create-timer/
    // https://verilogcodes.blogspot.com/2015/10/verilog-code-for-digital-clock.html
    // https://riptutorial.com/verilog/example/8307/simple-counter

    always @ (posedge CLK100MHZ) begin // Sub in slow clock when we can
    // make sure divider is dividing so you end up with the right time
        if (reset) begin
         seconds <= newSeconds;
         minutes <= newMinutes;
         hours <= newHours;
        end
        else if (CLK100MHZ)begin
        
            if ( seconds < 8'b00111100 )begin // if seconds < 60, increment
                seconds <= seconds + 8'b00000001;
                
            end if (seconds >= 8'b00111100) begin
                seconds <= 8'b00000000; // else, seconds goes to zero, minutes increments
                minutes <= minutes + 1;
            end
            if (minutes >= 8'b00111100) begin // If minutes = 60, reset to zero, increment hours
                minutes <= 8'b00000000;
                hours <= hours + 1;
            end
            if (hours >= 8'b00011000) begin // if 24 hours, reset hours to zero
                hours <= 8'b00000000;
            end 
        end // end of else if                 
    end
    // BCD conversion
   /*
    BCD hoursOut(.binary(hours), .tens(hoursTens), .ones(hoursOnes));
    BCD minutesOut(.binary(minutes), .tens(minutesTens), .ones(minutesOnes));
    BCD secondsOut(.binary(seconds), .tens(secondsTens), .ones(secondsOnes));
   */
    
endmodule
