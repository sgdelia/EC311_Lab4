`timescale 1ns / 1ps

module set_alarm(
input reset,
input turn_on,
input [7:0]clock_hours, // input from the counter
input [7:0]clock_minutes,
input [7:0]clock_seconds,
input clk,
input position_bttn,
input [1:0]current_mode,
input add_press,
input sub_press,
output reg alarm_going_off, hour_pos, minute_pos, second_pos,
output wire [7:0] display_hours,
             display_minutes,
             display_seconds
    );
//holds the current position being set
reg [1:0] current_position;

wire slw_clk;

//holds the value of plus one cout so it doesn't give error messages
wire cout_pos,
     cout_sec,
     cout_min,
     cout_hour;

//holds the output hours/minutes/seconds
reg [7:0] current_hours,
          current_minutes,
          current_seconds;
wire [7:0]set_hours,
          set_minutes,
          set_seconds;


clock_divider clk_div (.clk(clk), .divided_clk(slow_clk));


//increments the values of hours/minutes/seconds based on the value of current_position and a button press.
//only increments if the current_mode is set-time to make the button also usable in set-alarm without changing this value
always@(posedge slow_clk)
case(current_position)
     
     2'b00: begin //hours position
            hour_pos <= 1; //position LED indicator controls
            minute_pos <=0;
            second_pos <=0;
            
            if (position_bttn == 1 && current_mode == 2'b10) //if the position button is pushed and it's in set-alarm mode increment the position
                    current_position <= current_position + 2'b01;
             else
                current_position <= current_position;
            
            if (add_press == 1 && current_mode == 2'b10) //if addition button is pressed and in set-alarm
            begin
                if (current_hours >= 8'b00011000) // if >23 hours, reset hours to zero
                    begin 
                    current_hours <= 8'b00000000;
                    end
                else                               //else increment hours by 1
                    current_hours <= current_hours + 8'b00000001;
            end //end of addition
           
           if (sub_press == 1 && current_mode == 2'b10) //if subtraction button is pressed and in set-alarm
            begin
                if (current_hours <= 8'b0000000) // if <= 0 hours, reset hours to zero
                    begin 
                    current_hours <= 8'b00000000;
                    end
                else                               //else decrement hours by 1
                    current_hours <= current_hours - 8'b00000001;
            end //end of subtraction
           end //end of hours case
     
     2'b01: begin //minutes position
            hour_pos <= 0; //position LED indicator controls
            minute_pos <=1;
            second_pos <=0;
            if (position_bttn == 1 && current_mode == 2'b10) //if the position button is pushed and it's in set-alarm increment the position
                    current_position <= current_position + 2'b01;
             else
                current_position <= current_position;
                
            if (add_press == 1 && current_mode == 2'b10) //if button is pressed and in set-alarm 
            begin
                if (current_minutes >= 8'b00111011) // if >59 minutes, reset minutes to zero
                    begin 
                    current_minutes <= 8'b00000000;
                    end
                else                               //else increment minutes by 1
                    current_minutes <= current_minutes +8'b00000001;
            end
            
            if (sub_press == 1 && current_mode == 2'b10) //if subtraction button is pressed and in set-alarm
            begin
                if (current_minutes <= 8'b0000000) // if <= 0 hours, reset minutes to zero
                    begin 
                    current_minutes <= 8'b00000000;
                    end
                else                               //else decrement minutes by 1
                    current_minutes <= current_minutes - 8'b00000001;
            end //end of subtraction
           end //end of minutes case
     
     2'b10: begin //seconds position
            hour_pos <= 0; //position LED indicator controls
            minute_pos <=0;
            second_pos <=1;
            if (position_bttn == 1 && current_mode == 2'b10) //if the position button is pushed and it's in set-alarm increment the position
                    current_position <= current_position + 2'b01;
             else
                current_position <= current_position;
                
            if ((add_press == 1) && (current_mode == 2'b10)) //if button is pressed and in set-alarm
            begin
                if (current_seconds >= 8'b00111011) // if >59 seconds, reset seconds to zero
                    begin 
                    current_seconds <= 8'b00000000;
                    end
                else                               //else increment seconds by 1
                    current_seconds <= current_seconds + 8'b00000001;
            end
            
            if (sub_press == 1 && current_mode == 2'b10) //if subtraction button is pressed and in set-alarm
            begin
                if (current_seconds <= 8'b0000000) // if <= 0 hours, reset minutes to zero
                    begin 
                    current_seconds <= 8'b00000000;
                    end
                else                               //else decrement minutes by 1
                    current_seconds <= current_seconds - 8'b00000001;
            end //end of subtraction
           end //end of seconds case
      
     2'b11: begin //unused case
             current_position = 2'b00;
             end //end of unused case
 endcase
    
//assign values of the set-time to the output
assign set_hours = current_hours;
assign set_minutes = current_minutes;
assign set_seconds = current_seconds;

assign display_hours = current_hours;
assign display_minutes = current_minutes;
assign display_seconds = current_seconds;
    
    always @ (*) begin
        if (turn_on == 1 && reset == 0) begin // if the alarm is turned on
            if ((( clock_hours == set_hours) && (clock_minutes == set_minutes)) && (clock_seconds == set_seconds)) begin
            // if it's the right time
                alarm_going_off = 1;
            end // end check time
        end
        
        if(alarm_going_off == 1 && turn_on == 1)begin //if the alarm is going off and hasn't been turned off or reset keep going off
                alarm_going_off = 1;
         end
        
        if (reset == 1 || turn_on == 0) begin //stop the alarm if either reset is on or turned off
                alarm_going_off = 0;
        end
        
        else  //otherwise it keeps its current value
            begin
            alarm_going_off = alarm_going_off;
            end
            
    end // end always
    
  
endmodule

