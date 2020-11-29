`timescale 1ns / 1ps

module top(
 input CLK100MHZ,
 input mode_bttn, add_press, sub_press, position_set, //button inputs
 input set_time, reset_alarm, set_alarm, //reset/set switch
 output [7:0]anode,
 output [6:0]LED_seg,
 output [3:0] mode_LED,
 output pm_LED, alarm_LED, 
 output hour_pos_LED, minute_pos_LED, second_pos_LED
    );
    
    //outputs from set-time and set-alarm indicating position being set
    wire a_hour_pos,
         a_minute_pos,
         a_second_pos,
         s_hour_pos,
         s_minute_pos,
         s_second_pos;
    
    //for case statement
    reg hour_pos,
        minute_pos,
        second_pos;
    
    //assign values to outputs from case statment    
    assign hour_pos_LED = hour_pos;
    assign minute_pos_LED = minute_pos;
    assign second_pos_LED = second_pos;
    
    //holds the values of the set-time output
    wire [7:0] n_hours;
    wire [7:0] n_minutes;
    wire [7:0] n_seconds;
    
    //holds the values of the set-alarm output for display
    wire [7:0] a_hours;
    wire [7:0] a_minutes;
    wire [7:0] a_seconds;
        
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
    reg [3:0] output_mode;
    assign mode_LED = output_mode;

    
    //cycles the mode setting based on button input
    mode_select selector (.clk(CLK100MHZ), .bttn(mode_bttn), .current_mode(current_mode));
    
    
    
    //outputs for 24-hour time display mode
    wire [3:0] h_hundreds, //unused output
               m_hundreds, //unused output
               s_hundreds, //unused output
               hoursTens,
               hoursOnes,               
               minutesTens, 
               minutesOnes,
               secondsTens,
               secondsOnes;
     
     //outputs for set-time display          
     wire [3:0] n_hoursHundreds,  //unused output
                n_minutesHundreds, //unused output
                n_secondsHundreds, //unused output
                n_hoursTens,
                n_hoursOnes,
                n_minutesTens, 
                n_minutesOnes,
                n_secondsTens,
                n_secondsOnes;
     
     //outputs for set-alarm display
     wire [3:0] a_hoursHundreds,  //unused output
                a_minutesHundreds, //unused output
                a_secondsHundreds, //unused output
                a_hoursTens,
                a_hoursOnes,
                a_minutesTens, 
                a_minutesOnes,
                a_secondsTens,
                a_secondsOnes;
 
 //output from clock/counter to BCD module and alarm module
 wire [7:0] hours,
            minutes,
            seconds;   
 
 //24-hour clock/counter
 counter_alu clock_controller (.CLK100MHZ(CLK100MHZ),
                               .set(set_time),
                               .newHours(n_hours), 
                               .newMinutes(n_minutes), 
                               .newSeconds(n_seconds),
                               .hours(hours),
                               .minutes(minutes),
                               .seconds(seconds));
  
                            

 // BCD conversion for 24-hour clock          
 BCD hoursOut(.binary(hours),.hundreds(h_hundreds), .tens(hoursTens), .ones(hoursOnes));
 BCD minutesOut(.binary(minutes), .hundreds(m_hundreds), .tens(minutesTens), .ones(minutesOnes));
 BCD secondsOut(.binary(seconds), .hundreds(s_hundreds), .tens(secondsTens), .ones(secondsOnes));
 
 //holds the output of debounced buttons
 wire add,
      subtract,
      position;

//debouncer for the set-time and set-alarm position change button
nw_db position_set_db ( .clk(CLK100MHZ), .bttn(position_set), .bttn_out(position));
 
//debouncer for the add 1 button
nw_db add_press_db (.clk(CLK100MHZ), .bttn(add_press), .bttn_out(add));
 
//debouncer for the subtract 1 button
nw_db sub_press_db (.clk(CLK100MHZ), .bttn(sub_press), .bttn_out(subtract));

//set-time controller                    
set_time set_time_controller (.clk(CLK100MHZ),
                              .position_bttn(position), 
                              .current_mode(current_mode), 
                              .add_press(add),
                              .sub_press(subtract),
                              .hours(n_hours),
                              .minutes(n_minutes),
                              .seconds(n_seconds),
                              .hour_pos(s_hour_pos), 
                              .minute_pos(s_minute_pos), 
                              .second_pos(s_second_pos));
  
  BCD set_time_hour (.binary(n_hours), .hundreds(n_hoursHundreds), .tens(n_hoursTens), .ones(n_hoursOnes));
  BCD set_time_minutes (.binary(n_minutes), .hundreds(n_minutesHundreds), .tens(n_minutesTens), .ones(n_minutesOnes));
  BCD set_time_seconds (.binary(n_seconds), .hundreds(n_secondsHundreds), .tens(n_secondsTens), .ones(n_secondsOnes));
  
  //output from 12-hour conversion
  wire [7:0] twelve_hour_out;
  //holds twelve hour BCD conversion output
  wire [3:0] twelve_hour_hundreds, //unused output
             twelve_hour_tens,
             twelve_hour_ones;
  
  //allows us to set the am/pm LED to only display on 12 hour mode in the case statement 
  wire am_pm;
  reg pm_out;
  assign pm_LED = pm_out;
  //convert to 12-hour
  twelve_hour twelve_hour_convert (.hours(hours), .am_pm(am_pm), .twelve_hour_out(twelve_hour_out));
  
  //convert 12 hour to BCD
  BCD twelve_hour_BCD (.binary(twelve_hour_out), .hundreds(twelve_hour_hundreds), .tens(twelve_hour_tens), .ones(twelve_hour_ones));
  
  
  //set-alarm controller
  set_alarm set_alarm_wrapper ( .reset(reset_alarm), 
                                .turn_on(set_alarm), 
                                .clock_hours(hours) , 
                                .clock_minutes(minutes), 
                                .clock_seconds(seconds),
                                .clk(CLK100MHZ),
                                .position_bttn(position),
                                .current_mode(current_mode),
                                .add_press(add),
                                .sub_press(subtract),
                                .alarm_going_off(alarm_LED),
                                .display_hours(a_hours),
                                .display_minutes(a_minutes),
                                .display_seconds(a_seconds),
                                .hour_pos(a_hour_pos), 
                                .minute_pos(a_minute_pos),
                                .second_pos(a_second_pos)); 
    
    
    
    //BCD conversion for displaying set-alarm
    BCD set_alarm_hour (.binary(a_hours), .hundreds(a_hoursHundreds), .tens(a_hoursTens), .ones(a_hoursOnes));
    BCD set_alarm_minutes (.binary(a_minutes), .hundreds(a_minutesHundreds), .tens(a_minutesTens), .ones(a_minutesOnes));
    BCD set_alarm_seconds (.binary(a_seconds), .hundreds(a_secondsHundreds), .tens(a_secondsTens), .ones(a_secondsOnes));
  
always @(*) //change input to the seven-segment display and am/pm LED based on the mode
begin
    case (current_mode)
    2'b00: //if in 24-hour display mode
        begin
        hour_pos <= 0;
        minute_pos  <= 0;
        second_pos  <= 0;
        digit2 <= hoursTens;
        digit3 <= hoursOnes;
        digit4 <= minutesTens;
        digit5 <= minutesOnes;
        digit6 <= secondsTens;
        digit7 <= secondsOnes;
        pm_out <= 0;
        output_mode = 4'b0001;
        end
     2'b01: //if in set-time mode
        begin
        hour_pos <= s_hour_pos;
        minute_pos  <= s_minute_pos;
        second_pos  <= s_second_pos;
        digit2 <= n_hoursTens;
        digit3 <= n_hoursOnes;
        digit4 <= n_minutesTens;
        digit5 <= n_minutesOnes;
        digit6 <= n_secondsTens;
        digit7 <= n_secondsOnes;
        pm_out <= 0;
        output_mode = 4'b0010;
        end
    2'b10: //if in set-alarm mode
        begin
        hour_pos <= a_hour_pos;
        minute_pos  <= a_minute_pos;
        second_pos  <= a_second_pos;
        digit2 <= a_hoursTens;
        digit3 <= a_hoursOnes;
        digit4 <= a_minutesTens;
        digit5 <= a_minutesOnes;
        digit6 <= a_secondsTens;
        digit7 <= a_secondsOnes;
        pm_out <=0;
        output_mode = 4'b0100;
        end
     2'b11: //if in 12-hour display mode
        begin
        hour_pos <= 0;
        minute_pos  <= 0;
        second_pos  <= 0;
        digit2 <= twelve_hour_tens;
        digit3 <= twelve_hour_ones;
        digit4 <= minutesTens;
        digit5 <= minutesOnes;
        digit6 <= secondsTens;
        digit7 <= secondsOnes;
        pm_out <= am_pm;
        output_mode = 4'b1000;
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
