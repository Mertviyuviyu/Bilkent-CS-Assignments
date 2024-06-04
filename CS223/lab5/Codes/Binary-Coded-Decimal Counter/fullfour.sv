`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.04.2024 13:17:15
// Design Name: 
// Module Name: fullfour
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


module fullfour(input logic clk, ld, reset, [15:0]userin, output logic [3:0] an, logic [6:0] seg);
    logic clock_1s;
    logic [15:0] tempout;
    clock1s slowerclk(clk,clock_1s);
    fourdigitbcd fdb(clock_1s,ld,reset,userin,tempout);
    display disp(clk,tempout,an,seg);
endmodule
