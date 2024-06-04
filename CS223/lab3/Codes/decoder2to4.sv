`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.03.2024 17:42:59
// Design Name: 
// Module Name: decoder2to4
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


module decoder2to4(input logic e,s0,s1, output logic y0,y1,y2,y3);
    //y0,s0 least significant
    assign y0 = (e & ~s0 & ~s1);
    assign y1 = (e & s0 & ~s1);
    assign y2 = (e & ~s0 & s1);
    assign y3 = (e & s0 & s1);
endmodule
