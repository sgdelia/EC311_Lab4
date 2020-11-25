`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/23/2020 06:02:00 PM
// Design Name: 
// Module Name: set_time
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


module set_time(
input [1:0]position,
input add_press,
input sub_press,
input activation,
output reg [7:0]hours,
output reg [7:0]minutes,
output reg [7:0]seconds

    );
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
                    input_time = input_time - 1; // decrement by one if it's less than 24
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
    
endmodule
