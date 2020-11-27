`timescale 1ns / 1ps

module refresh_clk(
input wire clk,
output reg CLK10KHZ = 0
    );

   localparam div_value = 4999; // 100 million / 10 million = 10 halfcycles = 5 hertz
    
   integer counter_value = 0; //32 bit reg bus
   
   always@ (posedge clk)
   begin
   if (counter_value == div_value)  //when the counter reaches div_value
        begin
        counter_value <= 0;           //reset counter
        CLK10KHZ <= ~CLK10KHZ; //flip the clock
        end
   else
        begin
        counter_value <= counter_value+1; //increment counter by 1 for ever clock cycle
        CLK10KHZ <= CLK10KHZ;       //set value of divided clock equal to the current state
        end
   end 
endmodule

