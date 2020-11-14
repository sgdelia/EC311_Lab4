`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/08/2020 06:26:35 PM
// Design Name: 
// Module Name: carry_select_test
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


module carry_select_test();
reg [7:0]a;
reg [7:0]b;
reg c_in = 0;
wire [7:0]sum;
wire c_out;

carry_select c1(.a(a), .b(b), .c_in(c_in), .sum(sum), .c_out(c_out));
initial begin
    a = 0;
    b = 0;
    c_in = 0;
end


always
    begin
        #5 {a,b,c_in} = {a,b,c_in} + 1;
        if ({a,b,c_in} == 0)
            begin $finish;
        end
    end
    
endmodule
