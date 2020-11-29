`timescale 1ns / 1ps

module set_time(
input clk,
input position_bttn,
input [1:0]current_mode,
input add_press,
input sub_press,
output reg hour_pos, minute_pos, second_pos,
output wire [7:0]hours,
output wire [7:0]minutes,
output wire [7:0]seconds
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


clock_divider clk_div (.clk(clk), .divided_clk(slow_clk));


//increments the values of hours/minutes/seconds based on the value of current_position and a button press.
//only increments if the current_mode is set-time to make the button also usable in set-alarm without changing this value
always@(posedge slow_clk)
case(current_position)
     
     2'b00: begin //hours position
            hour_pos <= 1; //position LED indicator controls
            minute_pos <=0;
            second_pos <=0;
            if (position_bttn == 1 && current_mode == 2'b01) //if the position button is pushed and it's in set-mode increment the position
                    current_position <= current_position + 2'b01;
             else
                current_position <= current_position;
            
            if (add_press == 1 && current_mode == 2'b01) //if addition button is pressed and in set-mode
            begin
                if (current_hours >= 8'b00011000) // if >23 hours, reset hours to zero
                    begin 
                    current_hours <= 8'b00000000;
                    end
                else                               //else increment hours by 1
                    current_hours <= current_hours + 8'b00000001;
            end //end of addition
           
           if (sub_press == 1 && current_mode == 2'b01) //if subtraction button is pressed and in set-mode
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
            if (position_bttn == 1 && current_mode == 2'b01) //if the position button is pushed and it's in set-mode increment the position
                    current_position <= current_position + 2'b01;
             else
                current_position <= current_position;
                
            if (add_press == 1 && current_mode == 2'b01) //if button is pressed and in set-mode 
            begin
                if (current_minutes >= 8'b00111011) // if >59 minutes, reset minutes to zero
                    begin 
                    current_minutes <= 8'b00000000;
                    end
                else                               //else increment minutes by 1
                    current_minutes <= current_minutes +8'b00000001;
            end
            
            if (sub_press == 1 && current_mode == 2'b01) //if subtraction button is pressed and in set-mode
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
            if (position_bttn == 1 && current_mode == 2'b01) //if the position button is pushed and it's in set-mode increment the position
                    current_position <= current_position + 2'b01;
             else
                current_position <= current_position;
                
            if ((add_press == 1) && (current_mode == 2'b01)) //if button is pressed and in set-mode
            begin
                if (current_seconds >= 8'b00111011) // if >59 seconds, reset seconds to zero
                    begin 
                    current_seconds <= 8'b00000000;
                    end
                else                               //else increment seconds by 1
                    current_seconds <= current_seconds + 8'b00000001;
            end
            
            if (sub_press == 1 && current_mode == 2'b01) //if subtraction button is pressed and in set-mode
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
assign hours = current_hours;
assign minutes = current_minutes;
assign seconds = current_seconds;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
/*    
    // add initial block
    // add reset
    // For now, 
    // Another always block, reset signal puts things at zero
    // in testbench, set reset to high then zero
    // always push reset when it starts
    // nothing can start until reset
    // initial blocks don't synthesize too well, so always w/reset works better
    reg [7:0]input_time;
    always @ (activation) begin
        input_time = 0;
        hours = input_time;
        minutes = input_time;
        seconds = input_time;
    end
always @ (*) begin // always @ * = any time anything changes, evaluate. 
    case (position) 
        2'b00 : begin // if choosing seconds
            if (add_press) begin // if button is pushed
                if ( input_time < 59) begin
                    input_time = input_time + 1; // iterate by one if it's less than 60
                    seconds = input_time;
                    end
                else 
                    input_time = 0; // otherwise, make her zero
                    seconds = input_time;
            end // end if
            else if(sub_press) begin 
                if (( input_time < 60) && (input_time > 0)) begin
                    input_time = input_time - 1; // decrement by one if it's less than 60
                    seconds = input_time;
                end
                else begin 
                    input_time = 0;
                    seconds = input_time;
                end 
            end // end else if
        end // end seconds 
        2'b01 : begin
            if (add_press) begin // if button is pushed
                if ( input_time < 59) begin
                    input_time = input_time + 1; // iterate by one if it's less than 60
                    minutes = input_time;
                    end
                else 
                    input_time = 0; // otherwise, make her zero
                    minutes = input_time;
            end // end if
            else if(sub_press) begin 
                if (( input_time < 60) && (input_time > 0)) begin
                    input_time = input_time - 1; // decrement by one if it's less than 24
                    minutes = input_time;
                end
                else begin 
                    input_time = 0;
                    minutes = input_time;
                end 
            end // end else if
        end // end minutes
        2'b10 : begin // hours
           if (add_press) begin // if button is pushed
                if ( input_time < 23) begin
                    input_time = input_time + 1; // iterate by one if it's less than 24
                    hours = input_time;
                end
                else
                    input_time = 0;
                    hours = input_time;
            end // end button press 
            else if(sub_press) begin 
                if (( input_time < 24) && (input_time > 0)) begin
                input_time = input_time - 1; // decrement by one if it's less than 24
                hours = input_time;
                end
                else begin 
                    input_time = 0;
                    hours = input_time;
                end 
            end // end else if   
        end // end hours
        2'b11 : begin end
    endcase // end position case
 end // end loop   
    // clock divider to a tenth of a second? So it evaluates only one click
    // Slow enough so you can see the incrementation
    // @ posedge of divided
*/

    
endmodule
