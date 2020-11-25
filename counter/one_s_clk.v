`timescale 1ns / 1ps

module one_s_clk(
input wire clk, //100MHZ
output reg divided_clk = 0 //10HZ
    );
   localparam div_value = 4999999; // 100 million / 5 million = 20 halfcycles = 10 hertz
    
   integer counter_value = 0; //32 bit reg bus
   
   always@ (posedge clk)
   begin
   if (counter_value == div_value)  //when the counter reaches 4999999
        begin
        counter_value <= 0;           //reset counter
        divided_clk <= ~divided_clk; //flip the clock
        end
   else
        begin
        counter_value <= counter_value+1; //increment counter by 1 for ever clock cycle
        divided_clk <= divided_clk;       //set value of divided clock equal to the current state
        end
   end 
endmodule

