`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.03.2024 14:11:27
// Design Name: 
// Module Name: twobitadder_structural
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


module twobitadder_structural(input logic a0,b0,a1,b1,cin, output logic s0,s1,cout);
    logic w1;
    fulladder_structural first(a0,b0,cin,s0,w1);
    fulladder_structural second(a1,b1,w1,s1,cout);
endmodule
