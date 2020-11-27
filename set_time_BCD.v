`timescale 1ns / 1ps

module set_time_BCD(
    input [7:0] hours,
    input [7:0] minutes,
    input [7:0] seconds,
    output [3:0]n_hoursTens,
                n_hoursOnes,
                n_minutesTens, 
                n_minutesOnes,
                n_secondsTens,
                n_secondsOnes
    );
    
    //holds output of the unused hundreds position from BCD conversion
    wire[3:0] h_hundreds,
             m_hundreds,
             s_hundres;
    
    //BCD conversion
    BCD hoursOut(.binary(hours),.hundreds(h_hundreds), .tens(n_hoursTens), .ones(n_hoursOnes));
    BCD minutesOut(.binary(minutes), .hundreds(m_hundreds), .tens(n_minutesTens), .ones(n_minutesOnes));
    BCD secondsOut(.binary(seconds), .hundreds(s_hundreds), .tens(n_secondsTens), .ones(n_secondsOnes));
    
endmodule
