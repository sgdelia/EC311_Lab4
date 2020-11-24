`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/23/2020 11:59:14 AM
// Design Name: 
// Module Name: BCD
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


module BCD(
    input [7:0] binary,
    output reg [3:0]hundreds, // We won't need this, but I don't want to risk overflow
    output reg [3:0]tens,
    output reg [3:0]ones
    );
    
   integer i;
   always @ (*)
   begin
    
    hundreds = 4'd0;
    tens = 4'd0;
    ones = 4'd0;
    
    for ( i = 7; i >=0; i = i-1) begin
        // Make sure everything goes in the right "chunk"
        if (hundreds >= 5)
            hundreds = hundreds + 3;
        if (tens >=5)
            tens = tens + 3;
        if (ones >= 5)
            ones = ones + 3;
            
        // shift left
        hundreds = hundreds << 1;
        hundreds[0] = tens[3];
        tens = tens << 1;
        tens[0] = ones[3];
        ones = ones << 1;
        ones[0] = binary[i];    
    end // end for loop
    
   end // end always @ binary loop
    
endmodule
