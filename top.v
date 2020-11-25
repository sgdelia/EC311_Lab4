`timescale 1ns / 1ps

module top(
 input CLK100MHZ,
 input [7:0]test_inpt,
 input mode,
 input reset, 
 output [5:0]anode,
 output [6:0]LED_seg 
    );
    
    reg [7:0] n_hours = 8'b00000000;
    reg [7:0] n_minutes = 8'b00000000;
    reg [7:0] n_seconds = 8'b00000000;
    
    wire [7:0] hours, minutes, seconds;
    
 counter_alu count (.CLK100MHZ(CLK100MHZ),
                    .newHours(n_hours), 
                    .newMinutes(n_minutes), 
                    .newSeconds(n_seconds),
 
                    .reset(reset), 
                    .hours(hours),
                    
.minutes(minutes),
                    
.seconds(seconds));
    
  display_outline dsp (.CLK100MHZ(CLK100MHZ), 
                    .mode(mode), 
                    .hours(hours), 
                    .minutes(minutes), 
                    .seconds(seconds), 
                    .anode(anode), 
                    .LED_out(LED_seg));
                    
          
endmodule
