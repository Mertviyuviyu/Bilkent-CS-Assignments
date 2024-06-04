`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.03.2024 14:01:25
// Design Name: 
// Module Name: fullsubstractor_behavioral_tb
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


module fullsubstractor_behavioral_tb();
    logic a,b,bin,d,bout;
    fullsubstractor_behavioral dut(a,b,bin,d,bout);
    initial begin
        a=0; b=0; bin=0; #20;
        bin=1; #20;
        b=1; bin=0; #20;
        bin=1; #20;
        a=1; b=0; bin=0; #20;
        bin=1; #20;
        b=1; bin=0; #20;
        bin=1; #20;    
    end
endmodule
