`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.03.2024 21:19:04
// Design Name: 
// Module Name: fulladder_structural
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


module fulladder_structural(input logic a,b,cin, output logic sum,cout);
    logic w1,w2,w3;
    xor(w1,a,b);
    xor(sum,w1,cin);
    
    and(w2,a,b);
    and(w3,w1,cin);
    or(cout,w2,w3);
endmodule
