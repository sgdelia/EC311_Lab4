`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2020 12:58:13 PM
// Design Name: 
// Module Name: set_time_test
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


module set_time_test(

    );
    
    reg [1:0]position;
    reg button_press;
    reg activation;
    wire [7:0]hours;
    wire [7:0]minutes;
    wire [7:0]seconds;
    
    set_time testSetTime(.position(position), .button_press(button_press), 
    .hours(hours), .minutes(minutes), .seconds(seconds),
    .activation(activation));
    
    initial begin
        position = 0;
        button_press = 0;
        activation = 1;
        #10 activation = 0;
    end
    always #5 button_press = ~button_press;
    always begin
    // every ten ms, change one of the inputs
    // then change position
    // Just change variables one at a time
        #300 position = position + 1;   
    end
    
    
endmodule
