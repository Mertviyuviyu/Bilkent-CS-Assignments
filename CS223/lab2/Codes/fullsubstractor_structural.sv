`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.03.2024 13:52:43
// Design Name: 
// Module Name: fullsubstractor_structural
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


module fullsubstractor_structural(input logic a,b,bin, output logic d,bout);
    logic w1,w2,w3,w4,w5;
    xor(w1,a,b);
    xor(d,bin,w1);
    
    not(w2,a);
    and(w3,w2,b);
    not(w4,w1);
    and(w5,w4,bin);
    or(bout,w5,w3);
    
endmodule
