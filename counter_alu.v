`timescale 1ns / 1ps

module counter_alu(
input CLK100MHZ,
input [7:0]newHours, // used for setting time
input [7:0]newSeconds, // used for setting time
input [7:0]newMinutes, // used for setting time
input reset, // Used for initializing at zero
//output reg [7:0]hours,
//output reg [7:0]minutes,
//output reg [7:0]seconds
// outputs answer in BCD; uncomment lines 29-31 for 8-bit output

output [3:0]hoursTens,
output [3:0]hoursOnes,
output [3:0]minutesTens,
output [3:0]minutesOnes,
output [3:0]secondsTens,
output [3:0]secondsOnes

    );
    
   reg [7:0]seconds;
   reg [7:0]minutes;
   reg [7:0]hours;
        
    // counts until 24:60:60
    // 8 bit in/out so it's compatible with the ALU
    // Eventually, this is going to use the add 1 function from the ALU. Until then, I'm just adding one so we have 
    // Something to test
    // https://www.fpga4student.com/2016/11/verilog-code-for-alarm-clock-on-fpga.html
    // https://vhdlwhiz.com/create-timer/
    // https://verilogcodes.blogspot.com/2015/10/verilog-code-for-digital-clock.html
    // https://riptutorial.com/verilog/example/8307/simple-counter
    
    wire div_clk;
    
    one_s_clk div1 (.clk(CLK100MHZ), .divided_clk(div_clk));

    always @ (posedge div_clk) begin
    // make sure divider is dividing so you end up with the right time
        if (reset) begin
         seconds <= newSeconds;
         minutes <= newMinutes;
         hours <= newHours;
        end
        else if (div_clk)begin
        
            if ( seconds < 8'b00111100 )begin // if seconds < 60, increment
                seconds <= seconds + 8'b00000001;
                
            end if (seconds >= 8'b00111011) begin
                seconds <= 8'b00000000; // else, seconds goes to zero, minutes increments
                minutes <= minutes + 1;
            end
            if ((minutes >= 8'b00111011) && (seconds>=8'b00111011)) begin  // If minutes >59 & seconds >59 , reset to zero, increment hours
                minutes <= 8'b00000000;
                hours <= hours + 1;
            end
            if (hours >= 8'b00011000) begin // if >23 hours, reset hours to zero
                hours <= 8'b00000000;
            end 
        end // end of else if                 
    end
    
    //holds unused hundreds position values from BCD conversion   
    wire [3:0] h_hundreds,
              m_hundreds,
              s_hundreds;
              
    // BCD conversion          
    BCD hoursOut(.binary(hours),.hundreds(h_hundreds), .tens(hoursTens), .ones(hoursOnes));
    BCD minutesOut(.binary(minutes), .hundreds(m_hundreds), .tens(minutesTens), .ones(minutesOnes));
    BCD secondsOut(.binary(seconds), .hundreds(s_hundreds), .tens(secondsTens), .ones(secondsOnes));
   
    
endmodule
