`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.03.2024 13:52:43
// Design Name: 
// Module Name: fullsubstractor_behavioral
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


module fullsubstractor_behavioral(input logic a,b,bin, output logic d,bout);
    assign d = (a ^ b) ^ bin;
    assign bout = ((~a) & b ) | ((~(a ^ b)) & bin);
endmodule