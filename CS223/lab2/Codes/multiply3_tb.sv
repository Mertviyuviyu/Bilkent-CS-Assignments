`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.03.2024 20:56:54
// Design Name: 
// Module Name: multiply3_tb
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


module multiply3_tb();
    logic a[1:0];
    logic b[3:0];
    multiply3 dut(a,b);
    initial begin
        a = {1'b0,1'b0}; #20;
        a = {1'b0,1'b1}; #20;
        a = {1'b1,1'b0}; #20;
        a = {1'b1,1'b1}; #20;
    end
endmodule
