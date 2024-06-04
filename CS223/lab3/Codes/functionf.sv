`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.03.2024 18:47:39
// Design Name: 
// Module Name: functionf
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


module functionf(input logic a,b,c,d,e, output logic f);
    logic w0,w1,w2,w3;
    decoder2to4 d1(1,b,a,w0,w1,w2,w3);
    mux8to1 m1(w2,~b,1,w2,0,a,w3,w0,e,d,c,f);
endmodule
