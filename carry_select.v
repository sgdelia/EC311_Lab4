`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/08/2020 04:21:18 PM
// Design Name: 
// Module Name: carry_select
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


module carry_select(
input [7:0]a,
input [7:0]b,
input c_in,
output reg [7:0]sum,
output reg c_out
    );
 
wire [7:0]final_out[1:0];
wire final_c_out[1:0];


always @ (*) begin 
    case (c_in)
        1'b0 : begin
            sum <= final_out[0];
            c_out <= final_c_out[0];
            end
        1'b1 : begin
            sum <= final_out[1];
            c_out <= final_c_out[1];
            end
    endcase
end

ripple_add zeroAdd(.a(a), .b(b), .c_in(c_in), .sum(final_out[0]), .c_out(final_c_out[0]));
//     carry in is one
ripple_add oneAdd(.a(a), .b(b), .c_in(c_in), .sum(final_out[1]), .c_out(final_c_out[1]));
    
//    always @ (*) begin
//        case (c_in)
//           1'b0 : sum <= final_out[0];
//           1'b0 : c_out <= final_c_out[0];
//           1'b1 : sum <= final_out[1]; 
//           1'b1 : c_out <= final_c_out[1];
//        endcase
//    end
    
//    ripple_add zeroAdd(.a(a), .b(b), .c_in(c_in), .sum(final_out[0]), .c_out(final_c_out[0]));
//    // carry in is one
//    ripple_add oneAdd(.a(a), .b(b), .c_in(c_in), .sum(final_out[1]), .c_out(final_c_out[1]));
   
    
    
   // mux_carry_select 
    
endmodule
