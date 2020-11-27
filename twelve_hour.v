`timescale 1ns / 1ps


module twelve_hour( input [7:0] hours,
                    output reg am_pm,
                    output reg [7:0]twelve_hour_out
    );

always@(*)
begin
if (hours > 12) //if greater than 12, subtract 12 return that value, set pm
    begin
    am_pm <= 1;
    twelve_hour_out <= hours - 12;
    end
if (hours == 12) // if equal to 12 return that value, set pm
    begin
    am_pm <= 1;
    twelve_hour_out <= hours;
    end    
if ((hours < 12) && (hours > 0)) //if between 0 and 12, return that value set am
    begin
    am_pm <= 0;
    twelve_hour_out <= hours;
    end
if (hours == 0) //if equal to 0 return 12, set am
    begin
    am_pm <= 0;
    twelve_hour_out <= 12;
    end    
end
    

endmodule
