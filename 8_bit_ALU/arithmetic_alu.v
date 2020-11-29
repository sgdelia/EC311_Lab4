`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/12/2020 10:37:40 AM
// Design Name: 
// Module Name: arithmetic_alu
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


module arithmetic_alu(
    input [3:0] a,
    input [3:0] b,
    input c_in,
    input [2:0] Op,
    output reg [3:0] out,
    output reg c_out
    );
    
    wire temp [2:0];
    wire [7:0] product;
    wire final_cout [7:0];
    wire [3:0]final_out[7:0];
    initial begin
    c_out <= 1'b0;
    end
    assign temp[0] = c_in;
    assign temp[1] = c_in;
    assign temp[2] = c_in;
    
    negate neg_A (.a(a), .out(final_out[0]));
    assign final_cout[0] = 0;
    
    negate neg_B (.a(b), .out(final_out[1]));
    assign final_cout[1] = 0;
     
    cla_adder A_plus_B (.a(a), .b(b),.c_in(temp[0]), .c_out(final_cout[2]), .sum(final_out[2]));
    
    cla_subtract A_minus_B (.a(a), .b(b), .cin(temp[1]), .cout(final_cout[3]), .sum(final_out[3]));
    
    multiplier A_times_B (.a(a), .b(b), .c_out(final_cout[4]), .p(product));
    assign final_out[4] = product[3:0];
    
    cla_subtract B_minus_A (.a(b), .b(a), .cin(c_in), .cout(final_cout[5]), .sum(final_out[5]));

    plus_one A_plus1 (.a(a), .out(final_out[6]), .cout(final_cout[6]));
    
    minus_one A_minus1 (.a(a), .c_in(c_in), .out(final_out[7]));
    assign final_cout[7] = 0;
    
    always @(*)begin
    case(Op)
    3'b000: begin out <= final_out[0]; // negate A
                  c_out <= final_cout[0];
                  end
    3'b001: begin out <= final_out[1]; // negate B
                  c_out <= final_cout[1];
                  end
    3'b010: begin out <= final_out[2]; // A+B
                  c_out <= final_cout[2];
                  end
    3'b011: begin out <= final_out[3]; // A-B
                  c_out <= 1'b0;
                  end
    3'b100: begin out <= final_out[4]; // A*B
                  c_out <= final_cout[4];
                  end
    3'b101: begin out <= final_out[5]; // B-A
                  c_out <= 1'b0;
                  end
    3'b110: begin out <= final_out[6]; // A+1
                  c_out <= final_cout[6];
                  end
    3'b111: begin out <= final_out[7]; // A-1
                  c_out <= final_cout[7];
                  end
    default       c_out <= 1'b0;              
    endcase
end        
    
    
endmodule
