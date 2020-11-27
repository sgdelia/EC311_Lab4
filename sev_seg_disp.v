`timescale 1ns / 1ps

module sev_seg_disp (
input wire clk,
input [3:0] digit0,
            digit1,
            digit2,
            digit3,
            digit4,
            digit5,
            digit6,
            digit7,
output wire [7:0] anode,
output wire [6:0] LED_seg

);

wire refresh_clock;
wire [2:0] refresh_count ;
wire [3:0] digit;

//clock divider reducing 100MHZ to 10KHZ for refresh rate
refresh_clk refresh_clk_gen (.clk(clk),                 
                             .CLK10KHZ(refresh_clock)); 


//uses 10KHZ clock to increment a 3-bit counter to keep everything in sync
refresh_counter refresh_count_wrapper (.refresh_clock(refresh_clock),  
                                       .refresh_count(refresh_count));
                                       
//syncs with the refresh counter to control which anode to activate
anode_control anode_contr_wrapper (.refresh_count(refresh_count), 
                                   .anode(anode));

//syncs with the refresh counter to output the correct digit on the segment
BCD_control BCD_control_wrapper (.refresh_count(refresh_count),
                                 .digit0(digit0), 
                                 .digit1(digit1),
                                 .digit2(digit2),
                                 .digit3(digit3),
                                 .digit4(digit4),
                                 .digit5(digit5),
                                 .digit6(digit6),
                                 .digit7(digit7),
                                 .display_digit(digit));

//converts the BCD input to a decimal number on the segment's display
BCD_to_segments (.digit(digit), .LED_out(LED_seg));
                                 

endmodule