`timescale 1ns / 1ps

module full_disp(
                    input CLK100MHZ,
                    input [7:0] hours,
                    input [7:0] minutes,
                    input [7:0] seconds,
                    output [7:0]anode,
                    output [6:0]LED_seg

    );
    
    reg [7:0] blank = 8'b00000000;
    
    display_outline dsp1 (.CLK100MHZ(CLK100MHZ),  
                    .leftDigits(minutes), 
                    .rightDigits(seconds), 
                    .anode(anode[3:0]), 
                    .LED_out(LED_seg));
  
    display_outline dsp2 (.CLK100MHZ(CLK100MHZ),  
                    .leftDigits(blank), 
                    .rightDigits(hours), 
                    .anode(anode[7:4]), 
                    .LED_out(LED_seg));
endmodule
