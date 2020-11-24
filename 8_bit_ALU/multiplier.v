`timescale 1ns / 1ps

module multiplier(
    //user input
    input [7:0] a,
    input [7:0] b,
    //product in 8-bits
    output [15:0] p,
    //signifies overflow on 4 bit ALU
    output reg c_out
    );
    
    //set up wires to hold values of partial products
    wire [7:0] pp0, pp1, pp2, pp3, pp4, pp5, pp6, pp7, pp8, pp9, pp10, pp11, pp12, pp13;
    //wires to for carry out of first two additions and carry in
    wire cout0, cout1, cout2, cout3, cout4, cout5,cout6, cin;
    //wires to hold the sums of first two additions
    wire [7:0] sum1, sum2, sum3, sum4, sum5, sum6, sum7;
    //set carry in to 0
    assign cin = 0;
    initial begin
    c_out <= 1'b0;
    end
    
    //outputs directly to p[0]
    assign p[0] = a[0] & b[0];
    
    //first input to first addition
    and (pp0[0], a[1],b[0]);
    and (pp0[1], a[2],b[0]);
    and (pp0[2], a[3],b[0]);
    and (pp0[3], a[4],b[0]);
    and (pp0[4], a[5],b[0]);
    and (pp0[5], a[6],b[0]);
    and (pp0[6], a[7],b[0]);
    assign pp0[7]= 0;
    
    //second input to first addition
    and (pp1[0], a[0],b[1]);
    and (pp1[1], a[1],b[1]);
    and (pp1[2], a[2],b[1]);
    and (pp1[3], a[3],b[1]);
    and (pp1[4], a[4],b[1]);
    and (pp1[5], a[5],b[1]);
    and (pp1[6], a[6],b[1]);
    and (pp1[7], a[7],b[1]);
    
    //first addition
    cla_adder a1(.a(pp0),.b(pp1), .sum(sum1), .cin(cin), .cout(cout0));
    //output directly to p[1]
    assign p[1] = sum1[0];
    
    //first input to second addition
    assign pp2[0] = sum1[1];
    assign pp2[1] = sum1[2];
    assign pp2[2] = sum1[3];
    assign pp2[3] = sum1[4];
    assign pp2[4] = sum1[5];
    assign pp2[5] = sum1[6];
    assign pp2[6] = sum1[7];
    assign pp2[7] = cout0; 
    
    //second input to second addition
    and (pp3[0], a[0],b[2]);
    and (pp3[1], a[1],b[2]);
    and (pp3[2], a[2],b[2]);
    and (pp3[3], a[3],b[2]);
    and (pp3[4], a[4],b[2]);
    and (pp3[5], a[5],b[2]);
    and (pp3[6], a[6],b[2]);
    and (pp3[7], a[7],b[2]);
    
    //second addition
    cla_adder a2(.a(pp2),.b(pp3), .sum(sum2), .cin(cin), .cout(cout1));
    //output directly to p[2]
    assign p[2] = sum2[0];
    
    //first input to third addition
    assign pp4[0] = sum2[1];
    assign pp4[1] = sum2[2];
    assign pp4[2] = sum2[3];
    assign pp4[3] = sum2[4];
    assign pp4[4] = sum2[5];
    assign pp4[5] = sum2[6];
    assign pp4[6] = sum2[7];
    assign pp4[7] = cout1; 
    
    //second input to third addition
    and (pp5[0], a[0],b[3]);
    and (pp5[1], a[1],b[3]);
    and (pp5[2], a[2],b[3]);
    and (pp5[3], a[3],b[3]);
    and (pp5[4], a[4],b[3]);
    and (pp5[5], a[5],b[3]);
    and (pp5[6], a[6],b[3]);
    and (pp5[7], a[7],b[3]);
    
    //third addition addition
    cla_adder a3(.a(pp4),.b(pp5), .sum(sum3), .cin(cin), .cout(cout2));
    //output directly to p[3]
    assign p[3] = sum3[0];
     
    //first input to forth addition
    assign pp6[0] = sum3[1];
    assign pp6[1] = sum3[2];
    assign pp6[2] = sum3[3];
    assign pp6[3] = sum3[4];
    assign pp6[4] = sum3[5];
    assign pp6[5] = sum3[6];
    assign pp6[6] = sum3[7];
    assign pp6[7] = cout2; 
    
    //second input to fourth addition
    and (pp7[0], a[0],b[4]);
    and (pp7[1], a[1],b[4]);
    and (pp7[2], a[2],b[4]);
    and (pp7[3], a[3],b[4]);
    and (pp7[4], a[4],b[4]);
    and (pp7[5], a[5],b[4]);
    and (pp7[6], a[6],b[4]);
    and (pp7[7], a[7],b[4]);
    
    //fourth addition
    cla_adder a4(.a(pp6),.b(pp7), .sum(sum4), .cin(cin), .cout(cout3));
    //output directly to p[4]
    assign p[4] = sum4[0];
    
    //first input to fifth addition
    assign pp8[0] = sum4[1];
    assign pp8[1] = sum4[2];
    assign pp8[2] = sum4[3];
    assign pp8[3] = sum4[4];
    assign pp8[4] = sum4[5];
    assign pp8[5] = sum4[6];
    assign pp8[6] = sum4[7];
    assign pp8[7] = cout3; 
    
    //second input to fifth addition
    and (pp9[0], a[0],b[5]);
    and (pp9[1], a[1],b[5]);
    and (pp9[2], a[2],b[5]);
    and (pp9[3], a[3],b[5]);
    and (pp9[4], a[4],b[5]);
    and (pp9[5], a[5],b[5]);
    and (pp9[6], a[6],b[5]);
    and (pp9[7], a[7],b[5]);
    
    //fifth addition
    cla_adder a5(.a(pp8),.b(pp9), .sum(sum5), .cin(cin), .cout(cout4));
    //output directly to p[5]
    assign p[5] = sum5[0];
    
    //first input to sixth addition
    assign pp10[0] = sum5[1];
    assign pp10[1] = sum5[2];
    assign pp10[2] = sum5[3];
    assign pp10[3] = sum5[4];
    assign pp10[4] = sum5[5];
    assign pp10[5] = sum5[6];
    assign pp10[6] = sum5[7];
    assign pp10[7] = cout4; 
    
    //second input to sixth addition
    and (pp11[0], a[0],b[6]);
    and (pp11[1], a[1],b[6]);
    and (pp11[2], a[2],b[6]);
    and (pp11[3], a[3],b[6]);
    and (pp11[4], a[4],b[6]);
    and (pp11[5], a[5],b[6]);
    and (pp11[6], a[6],b[6]);
    and (pp11[7], a[7],b[6]);
    
    //sixth addition addition
    cla_adder a6(.a(pp10),.b(pp11), .sum(sum6), .cin(cin), .cout(cout5));
    //output directly to p[6]
    assign p[6] = sum6[0];
    
    //first input to seventh addition
    assign pp12[0] = sum6[1];
    assign pp12[1] = sum6[2];
    assign pp12[2] = sum6[3];
    assign pp12[3] = sum6[4];
    assign pp12[4] = sum6[5];
    assign pp12[5] = sum6[6];
    assign pp12[6] = sum6[7];
    assign pp12[7] = cout5; 
    
    //second input to seventh addition
    and (pp13[0], a[0],b[7]);
    and (pp13[1], a[1],b[7]);
    and (pp13[2], a[2],b[7]);
    and (pp13[3], a[3],b[7]);
    and (pp13[4], a[4],b[7]);
    and (pp13[5], a[5],b[7]);
    and (pp13[6], a[6],b[7]);
    and (pp13[7], a[7],b[7]);
    
    //seventh addition
    cla_adder a7(.a(pp12),.b(pp13), .sum(p[14:7]), .cin(cin), .cout(p[15])); 
    
    //checks to see if bits 4-7 are 1 in which case show overflow with c_out for main system
    /*always @(*) begin
    if (p[4] == 1'b1)
    c_out <= p[4];
    else if (p[5] == 1'b1)
    c_out <= p[5];
    else if (p[6] == 1'b1)
    c_out <= p[6];
    else if (p[7] == 1'b1)
    c_out <= p[7];
    else
    c_out <= 1'b0;
    end */
    
endmodule