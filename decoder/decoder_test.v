`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2020 06:37:19 PM
// Design Name: 
// Module Name: decoder_test
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


module decoder_test(

    );
    
reg [7:0]hours_in;
reg [7:0]minutes_in;
reg [7:0]seconds_in;
wire [7:0]hours_out;
wire [7:0]minutes_out;
wire [7:0]seconds_out;
wire PM_LED;

decoder test(.hours_in(hours_in), .minutes_in(minutes_in), .seconds_in(seconds_in),
.hours_out(hours_out), .minutes_out(minutes_out), .seconds_out(seconds_out),
.PM_LED(PM_LED));

initial begin
    hours_in = 0;
    minutes_in = 0;
    seconds_in = 0;
end

always begin
   #5 hours_in = hours_in + 1;
    if (hours_in == 0) 
        #5 begin $finish;
    end
end

endmodule
