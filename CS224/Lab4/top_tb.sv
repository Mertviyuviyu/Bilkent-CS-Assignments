`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.11.2024 18:59:33
// Design Name: 
// Module Name: top_tb
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


module top_tb();
    logic clk = 0;
    logic reset = 1;
    logic[31:0] writedata, dataaddr, readdata, instruction, pc;
    logic memwrite;
   
    top dut(clk,reset,writedata,dataaddr,readdata,memwrite,instruction,pc);
    
    always begin
        clk = ~clk;
        #10;
    end
    
    initial begin
        #50;
        reset = 0;
    end
    
endmodule
