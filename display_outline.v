`timescale 1ns / 1ps

module display_outline(
input CLK100MHZ,
input mode, // 24 or 12 hour mode
input [7:0]hours, // 8-bits of hours
input [7:0]minutes, // 8-bits of minutes
input [7:0]seconds, // 8-bits of seconds
output reg [5:0]anode, // which anode we're on
output reg [6:0]LED_out // segments of the anode
    );
reg [19:0] refresh_counter; // Generates 380 Hz refresh rate. Only using 2 bits
wire [2:0] anode_activator; // Cycles through anodes


//BCD Digits for hours - hundreds included for completeness
wire [3:0]h_ones; // ones
wire [3:0]h_tens; // tens
wire [3:0]h_hundreds; //hundreds

//BCD conversion for hours
BCD h_BCD (.binary(hours), .hundreds(h_hundreds), .tens(h_tens), .ones(h_ones));

//BCD Digits for minutes - hundreds included for completeness
wire [3:0]m_ones; // ones
wire [3:0]m_tens; // tens
wire [3:0]m_hundreds; //hundreds

//BCD conversion for minutes
BCD m_BCD (.binary(minutes), .hundreds(m_hundreds), .tens(m_tens), .ones(m_ones));

//BCD Digits for seconds - hundreds included for completeness
wire [3:0]s_ones; // ones
wire [3:0]s_tens; // tens
wire [3:0]s_hundreds; //hundreds

//BCD conversion for seconds
BCD s_BCD (.binary(seconds), .hundreds(s_hundreds), .tens(s_tens), .ones(s_ones));


initial begin
refresh_counter = 0; // set counter to zero so she doesn't get angry.
end

// Display Timing
always @(posedge CLK100MHZ)
begin
    refresh_counter <= refresh_counter +1; // add to the counter so the refresh rate is right
end

assign anode_activator = refresh_counter[19:17]; // cycle through signals for 6 anodes using refresh speeds

always @ (*)begin
    case(mode)
    1'b0 : begin // If 24-Hour Mode
        case(anode_activator) //Activates Anodes 2-7 from left to right
          3'b000 : begin 
                anode = 6'b011111; // activate 2, deactivate 0,1,3-7
                case(h_tens)
                    4'b0000 : LED_out = 7'b0000001;
                    4'b0001 : LED_out = 7'b1001111;
                    4'b0010 : LED_out <= 7'b0010010;
                    4'b0011 : LED_out <= 7'b0000110;
                    4'b0100 : LED_out <= 7'b1001100;          
                    4'b0101 : LED_out <= 7'b0100100;
                    4'b0110 : LED_out <= 7'b0100000;
                    4'b0111 : LED_out <= 7'b0001111;
                    4'b1000 : LED_out <= 7'b0000000;
                    4'b1001 : LED_out <= 7'b0000100;
                    4'b1010 : LED_out <= 7'b0001000;
                    4'b1011 : LED_out <= 7'b1100000;
                    4'b1100 : LED_out <= 7'b0110001;
                    4'b1101 : LED_out <= 7'b1000010;
                    4'b1110 : LED_out <= 7'b0110000;
                    4'b1111 : LED_out <= 7'b0111000; 
                    default : LED_out <= 7'b0000001;
                endcase     
                end
           3'b001 : begin // activate 3, deactivate 0-2, ,3-7
                anode = 6'b101111;
                case(h_ones)
                    4'b0000 : LED_out = 7'b0000001;
                    4'b0001 : LED_out = 7'b1001111;
                    4'b0010 : LED_out <= 7'b0010010;
                    4'b0011 : LED_out <= 7'b0000110;
                    4'b0100 : LED_out <= 7'b1001100;          
                    4'b0101 : LED_out <= 7'b0100100;
                    4'b0110 : LED_out <= 7'b0100000;
                    4'b0111 : LED_out <= 7'b0001111;
                    4'b1000 : LED_out <= 7'b0000000;
                    4'b1001 : LED_out <= 7'b0000100;
                    4'b1010 : LED_out <= 7'b0001000;
                    4'b1011 : LED_out <= 7'b1100000;
                    4'b1100 : LED_out <= 7'b0110001;
                    4'b1101 : LED_out <= 7'b1000010;
                    4'b1110 : LED_out <= 7'b0110000;
                    4'b1111 : LED_out <= 7'b0111000; 
                    default : LED_out <= 7'b0000001;
             endcase  
           end
           3'b010 : begin // activate 4, deactivate 0-3, 4-7
                anode = 6'b110111;
                case(m_tens)
                    4'b0000 : LED_out = 7'b0000001;
                    4'b0001 : LED_out = 7'b1001111;
                    4'b0010 : LED_out <= 7'b0010010;
                    4'b0011 : LED_out <= 7'b0000110;
                    4'b0100 : LED_out <= 7'b1001100;          
                    4'b0101 : LED_out <= 7'b0100100;
                    4'b0110 : LED_out <= 7'b0100000;
                    4'b0111 : LED_out <= 7'b0001111;
                    4'b1000 : LED_out <= 7'b0000000;
                    4'b1001 : LED_out <= 7'b0000100;
                    4'b1010 : LED_out <= 7'b0001000;
                    4'b1011 : LED_out <= 7'b1100000;
                    4'b1100 : LED_out <= 7'b0110001;
                    4'b1101 : LED_out <= 7'b1000010;
                    4'b1110 : LED_out <= 7'b0110000;
                    4'b1111 : LED_out <= 7'b0111000; 
                    default : LED_out <= 7'b0000001;
             endcase   
           end
           3'b011 : begin // activate 5, deactivate 0-4, 6, 7
                anode = 6'b111011;
                case(m_ones)
                    4'b0000 : LED_out = 7'b0000001;
                    4'b0001 : LED_out = 7'b1001111;
                    4'b0010 : LED_out <= 7'b0010010;
                    4'b0011 : LED_out <= 7'b0000110;
                    4'b0100 : LED_out <= 7'b1001100;          
                    4'b0101 : LED_out <= 7'b0100100;
                    4'b0110 : LED_out <= 7'b0100000;
                    4'b0111 : LED_out <= 7'b0001111;
                    4'b1000 : LED_out <= 7'b0000000;
                    4'b1001 : LED_out <= 7'b0000100;
                    4'b1010 : LED_out <= 7'b0001000;
                    4'b1011 : LED_out <= 7'b1100000;
                    4'b1100 : LED_out <= 7'b0110001;
                    4'b1101 : LED_out <= 7'b1000010;
                    4'b1110 : LED_out <= 7'b0110000;
                    4'b1111 : LED_out <= 7'b0111000;
                    default : LED_out <= 7'b0000001; 
             endcase    
           end
           3'b100 : begin // activate 6, deactivate 0-4, 6, 7
                anode = 6'b111101;
                case(s_tens)
                    4'b0000 : LED_out = 7'b0000001;
                    4'b0001 : LED_out = 7'b1001111;
                    4'b0010 : LED_out <= 7'b0010010;
                    4'b0011 : LED_out <= 7'b0000110;
                    4'b0100 : LED_out <= 7'b1001100;          
                    4'b0101 : LED_out <= 7'b0100100;
                    4'b0110 : LED_out <= 7'b0100000;
                    4'b0111 : LED_out <= 7'b0001111;
                    4'b1000 : LED_out <= 7'b0000000;
                    4'b1001 : LED_out <= 7'b0000100;
                    4'b1010 : LED_out <= 7'b0001000;
                    4'b1011 : LED_out <= 7'b1100000;
                    4'b1100 : LED_out <= 7'b0110001;
                    4'b1101 : LED_out <= 7'b1000010;
                    4'b1110 : LED_out <= 7'b0110000;
                    4'b1111 : LED_out <= 7'b0111000;
                    default : LED_out <= 7'b0000001; 
             endcase
             end
             3'b101 : begin // activate 7, deactivate 0-6
                anode = 6'b111110;
                case(s_ones)
                    4'b0000 : LED_out = 7'b0000001;
                    4'b0001 : LED_out = 7'b1001111;
                    4'b0010 : LED_out <= 7'b0010010;
                    4'b0011 : LED_out <= 7'b0000110;
                    4'b0100 : LED_out <= 7'b1001100;          
                    4'b0101 : LED_out <= 7'b0100100;
                    4'b0110 : LED_out <= 7'b0100000;
                    4'b0111 : LED_out <= 7'b0001111;
                    4'b1000 : LED_out <= 7'b0000000;
                    4'b1001 : LED_out <= 7'b0000100;
                    4'b1010 : LED_out <= 7'b0001000;
                    4'b1011 : LED_out <= 7'b1100000;
                    4'b1100 : LED_out <= 7'b0110001;
                    4'b1101 : LED_out <= 7'b1000010;
                    4'b1110 : LED_out <= 7'b0110000;
                    4'b1111 : LED_out <= 7'b0111000;
                    default : LED_out <= 7'b0000001; 
             endcase
             end
        endcase
    end
   
    1'b1 : begin // If 12-Hour Mode
        case(anode_activator) //Activates Anodes 2-7 from left to right
          3'b000 : begin 
                anode = 6'b011111; // activate 2, deactivate 0,1,3-7
                case(h_tens)
                    4'b0000 : LED_out = 7'b0000001;
                    4'b0001 : LED_out = 7'b1001111;
                    4'b0010 : LED_out <= 7'b0010010;
                    4'b0011 : LED_out <= 7'b0000110;
                    4'b0100 : LED_out <= 7'b1001100;          
                    4'b0101 : LED_out <= 7'b0100100;
                    4'b0110 : LED_out <= 7'b0100000;
                    4'b0111 : LED_out <= 7'b0001111;
                    4'b1000 : LED_out <= 7'b0000000;
                    4'b1001 : LED_out <= 7'b0000100;
                    4'b1010 : LED_out <= 7'b0001000;
                    4'b1011 : LED_out <= 7'b1100000;
                    4'b1100 : LED_out <= 7'b0110001;
                    4'b1101 : LED_out <= 7'b1000010;
                    4'b1110 : LED_out <= 7'b0110000;
                    4'b1111 : LED_out <= 7'b0111000; 
                    default : LED_out <= 7'b0000001;
                endcase     
                end
           3'b001 : begin // activate 3, deactivate 0-2, ,3-7
                anode = 6'b101111;
                case(h_ones)
                    4'b0000 : LED_out = 7'b0000001;
                    4'b0001 : LED_out = 7'b1001111;
                    4'b0010 : LED_out <= 7'b0010010;
                    4'b0011 : LED_out <= 7'b0000110;
                    4'b0100 : LED_out <= 7'b1001100;          
                    4'b0101 : LED_out <= 7'b0100100;
                    4'b0110 : LED_out <= 7'b0100000;
                    4'b0111 : LED_out <= 7'b0001111;
                    4'b1000 : LED_out <= 7'b0000000;
                    4'b1001 : LED_out <= 7'b0000100;
                    4'b1010 : LED_out <= 7'b0001000;
                    4'b1011 : LED_out <= 7'b1100000;
                    4'b1100 : LED_out <= 7'b0110001;
                    4'b1101 : LED_out <= 7'b1000010;
                    4'b1110 : LED_out <= 7'b0110000;
                    4'b1111 : LED_out <= 7'b0111000; 
                    default : LED_out <= 7'b0000001;
             endcase  
           end
           3'b010 : begin // activate 4, deactivate 0-3, 4-7
                anode = 6'b110111;
                case(m_tens)
                    4'b0000 : LED_out = 7'b0000001;
                    4'b0001 : LED_out = 7'b1001111;
                    4'b0010 : LED_out <= 7'b0010010;
                    4'b0011 : LED_out <= 7'b0000110;
                    4'b0100 : LED_out <= 7'b1001100;          
                    4'b0101 : LED_out <= 7'b0100100;
                    4'b0110 : LED_out <= 7'b0100000;
                    4'b0111 : LED_out <= 7'b0001111;
                    4'b1000 : LED_out <= 7'b0000000;
                    4'b1001 : LED_out <= 7'b0000100;
                    4'b1010 : LED_out <= 7'b0001000;
                    4'b1011 : LED_out <= 7'b1100000;
                    4'b1100 : LED_out <= 7'b0110001;
                    4'b1101 : LED_out <= 7'b1000010;
                    4'b1110 : LED_out <= 7'b0110000;
                    4'b1111 : LED_out <= 7'b0111000; 
                    default : LED_out <= 7'b0000001;
             endcase   
           end
           3'b011 : begin // activate 5, deactivate 0-4, 6, 7
                anode = 6'b111011;
                case(m_ones)
                    4'b0000 : LED_out = 7'b0000001;
                    4'b0001 : LED_out = 7'b1001111;
                    4'b0010 : LED_out <= 7'b0010010;
                    4'b0011 : LED_out <= 7'b0000110;
                    4'b0100 : LED_out <= 7'b1001100;          
                    4'b0101 : LED_out <= 7'b0100100;
                    4'b0110 : LED_out <= 7'b0100000;
                    4'b0111 : LED_out <= 7'b0001111;
                    4'b1000 : LED_out <= 7'b0000000;
                    4'b1001 : LED_out <= 7'b0000100;
                    4'b1010 : LED_out <= 7'b0001000;
                    4'b1011 : LED_out <= 7'b1100000;
                    4'b1100 : LED_out <= 7'b0110001;
                    4'b1101 : LED_out <= 7'b1000010;
                    4'b1110 : LED_out <= 7'b0110000;
                    4'b1111 : LED_out <= 7'b0111000;
                    default : LED_out <= 7'b0000001; 
             endcase    
           end
           3'b100 : begin // activate 6, deactivate 0-4, 6, 7
                anode = 6'b111101;
                case(s_tens)
                    4'b0000 : LED_out = 7'b0000001;
                    4'b0001 : LED_out = 7'b1001111;
                    4'b0010 : LED_out <= 7'b0010010;
                    4'b0011 : LED_out <= 7'b0000110;
                    4'b0100 : LED_out <= 7'b1001100;          
                    4'b0101 : LED_out <= 7'b0100100;
                    4'b0110 : LED_out <= 7'b0100000;
                    4'b0111 : LED_out <= 7'b0001111;
                    4'b1000 : LED_out <= 7'b0000000;
                    4'b1001 : LED_out <= 7'b0000100;
                    4'b1010 : LED_out <= 7'b0001000;
                    4'b1011 : LED_out <= 7'b1100000;
                    4'b1100 : LED_out <= 7'b0110001;
                    4'b1101 : LED_out <= 7'b1000010;
                    4'b1110 : LED_out <= 7'b0110000;
                    4'b1111 : LED_out <= 7'b0111000;
                    default : LED_out <= 7'b0000001; 
             endcase
             end
             3'b101 : begin // activate 7, deactivate 0-6
                anode = 6'b111110;
                case(s_ones)
                    4'b0000 : LED_out = 7'b0000001;
                    4'b0001 : LED_out = 7'b1001111;
                    4'b0010 : LED_out <= 7'b0010010;
                    4'b0011 : LED_out <= 7'b0000110;
                    4'b0100 : LED_out <= 7'b1001100;          
                    4'b0101 : LED_out <= 7'b0100100;
                    4'b0110 : LED_out <= 7'b0100000;
                    4'b0111 : LED_out <= 7'b0001111;
                    4'b1000 : LED_out <= 7'b0000000;
                    4'b1001 : LED_out <= 7'b0000100;
                    4'b1010 : LED_out <= 7'b0001000;
                    4'b1011 : LED_out <= 7'b1100000;
                    4'b1100 : LED_out <= 7'b0110001;
                    4'b1101 : LED_out <= 7'b1000010;
                    4'b1110 : LED_out <= 7'b0110000;
                    4'b1111 : LED_out <= 7'b0111000;
                    default : LED_out <= 7'b0000001; 
             endcase
             end
           endcase 
       end
   endcase
end   
endmodule
