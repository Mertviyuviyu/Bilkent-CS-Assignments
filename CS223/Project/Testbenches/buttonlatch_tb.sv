`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.04.2024 22:18:26
// Design Name: 
// Module Name: buttonlatch_tb
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


module buttonlatch_tb();
    logic clk= 0;
    logic btn,stable;
    
    always begin
        clk = ~clk; #10;
    end
    buttonlatch dut(clk,btn,stable);
    initial begin
        btn = 0; #20;
        btn = 1; #50;
        btn = 0; #50;
        btn = 1; #50;
        btn = 0; 
    end
endmodule
