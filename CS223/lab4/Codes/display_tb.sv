`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.04.2024 11:59:40
// Design Name: 
// Module Name: display_tb
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


module display_tb();
    logic clk;
    logic [15:0] userin;
    logic [3:0] an;
    logic[6:0] seg;
    
    display dut(clk,userin,an,seg);
    
    always begin
        clk=0; #5;
        clk=1; #5;
    end
    
    initial begin
        userin = 16'b1001_0110_0011_1111; #20;
        userin = 16'b0100_1000_0010_1111; #20;
    end
    
endmodule
