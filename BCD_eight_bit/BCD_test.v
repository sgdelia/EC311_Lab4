`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/23/2020 11:33:01 AM
// Design Name: 
// Module Name: BCD_test
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


module BCD_test(
    );
    
    reg [7:0]binary;
    wire [3:0]hundreds;
    wire [3:0]tens;
    wire [3:0]ones;
    BCD testBCD(.binary(binary),.hundreds(hundreds), .tens(tens), .ones(ones));
    
    initial begin
        binary = 0;
    end
    
always begin    
    #5 binary = binary + 1;
    if (binary == 0) begin
        $finish;
    end
end    
    
endmodule
