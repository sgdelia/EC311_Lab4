`timescale 1ns / 1ps

module top(
 input CLK100MHZ,
 input mode_bttn,
 input [1:0]position,
 input activation,
 input add_press, sub_press,
 input reset, 
 output [7:0]anode,
 output [6:0]LED_seg
    );
    
    //holds the values of the set-time output
    wire [7:0] n_hours;
    wire [7:0] n_minutes;
    wire [7:0] n_seconds;
    
    //leading zero inputs for the unused first two digits of display
    reg [3:0] digit0 = 4'b0000;
    reg [3:0] digit1 = 4'b0000;
    
    //holds the value of the BCD digits sent to the seven-segment display
    reg [3:0]  digit2,
               digit3,
               digit4,
               digit5,
               digit6,
               digit7;
    
    //holds the value of the current mode
    wire [1:0] current_mode;
    
    //cycles the mode setting based on button input
    mode_select selector (.clk(CLK100MHZ), .bttn(mode_bttn), .current_mode(current_mode));
    
    
    
    //outputs for 24-hour time display mode
    wire [3:0] hoursTens,
               hoursOnes,
               minutesTens, 
               minutesOnes,
               secondsTens,
               secondsOnes;
     
     //outputs for set-time display          
     wire [3:0] n_hoursTens,
                n_hoursOnes,
                n_minutesTens, 
                n_minutesOnes,
                n_secondsTens,
                n_secondsOnes;
 
 //24-hour clock/counter
 counter_alu clock_controller (.CLK100MHZ(CLK100MHZ),
                               .reset(reset),
                               .newHours(n_hours), 
                               .newMinutes(n_minutes), 
                               .newSeconds(n_seconds),
                               .hoursTens(hoursTens),
                               .hoursOnes(hoursOnes),
                               .minutesTens(minutesTens),
                               .minutesOnes(minutesOnes),
                               .secondsTens(secondsTens),
                               .secondsOnes(secondsOnes));
 
 //holds the output of debounced buttons
 wire add,
      subtract;
 
 //debouncer for the add 1 button
 nw_db add_press_db (.clk(CLK100MHZ), .bttn(add_press), .bttn_out(add));
 
 //debouncer for the subtract 1 button
 nw_db sub_press_db (.clk(CLK100MHZ), .bttn(sub_press), .bttn_out(subtract));
 
 //set-time controller                    
 set_time set_time_controller (.position(position),
                            .add_press(add),
                            .sub_press(sub),
                            .activation(activation),
                            .hours(n_hours),
                            .minutes(n_minutes),
                            .seconds(n_seconds));
  
always @(*) //change input to the seven-segment display based on the mode
begin
    case (current_mode)
    2'b00: //if in 24-hour display mode
        begin
        digit2 <= hoursTens;
        digit3 <= hoursOnes;
        digit4 <= minutesTens;
        digit5 <= minutesOnes;
        digit6 <= secondsTens;
        digit7 <= secondsOnes;
        end
     2'b01: //if in set-time mode
        begin
        digit2 <= n_hoursTens;
        digit3 <= n_hoursOnes;
        digit4 <= n_minutesTens;
        digit5 <= n_minutesOnes;
        digit6 <= n_secondsTens;
        digit7 <= n_secondsOnes;
        end
    2'b10: //if in set-alarm mode
        begin
        digit2 <= hoursTens;
        digit3 <= hoursOnes;
        digit4 <= minutesTens;
        digit5 <= minutesOnes;
        digit6 <= secondsTens;
        digit7 <= secondsOnes;
        end
     2'b11: //if in 12-hour display mode
        begin
        digit2 <= hoursTens;
        digit3 <= hoursOnes;
        digit4 <= minutesTens;
        digit5 <= minutesOnes;
        digit6 <= secondsTens;
        digit7 <= secondsOnes;
        end    
    endcase
end

  
  //sends t he output values to the seven-segment display
  sev_seg_disp disp_out (.clk(CLK100MHZ), 
                           .digit0(digit0), 
                           .digit1(digit1),             
                           .digit2(digit2),
                           .digit3(digit3),
                           .digit4(digit4),
                           .digit5(digit5),
                           .digit6(digit6),
                           .digit7(digit7),
                           .anode(anode),
                           .LED_seg(LED_seg));               
           
endmodule
