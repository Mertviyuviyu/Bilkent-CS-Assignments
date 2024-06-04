`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.03.2024 17:42:59
// Design Name: 
// Module Name: mux8to1
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

module mux8to1(input logic i0,i1,i2,i3,i4,i5,i6,i7,s0,s1,s2, output logic out);
    //io,s0 least
    logic w1,w2;
    mux4to1 mux1(i4,i5,i6,i7,s0,s1,w1);
    mux4to1 mux2(i0,i1,i2,i3,s0,s1,w2);
    mux2to1 mux3(w1,w2,s2,out);
endmodule
                                                                                                                                                                                                                                            