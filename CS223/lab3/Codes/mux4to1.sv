`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.03.2024 18:02:47
// Design Name: 
// Module Name: mux4to1
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


module mux4to1(input logic i0,i1,i2,i3,s0,s1, output logic out);
    //s0,i0 least
    logic w1,w2;
    mux2to1 m1(i1,i0,s0,w1);
    mux2to1 m2(i3,i2,s0,w2);
    mux2to1 m3(w2,w1,s1,out);
endmodule
