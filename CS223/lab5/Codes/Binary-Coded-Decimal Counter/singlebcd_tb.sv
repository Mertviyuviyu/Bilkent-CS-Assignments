`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.04.2024 16:16:44
// Design Name: 
// Module Name: singlebcd_tb
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


module singlebcd_tb();
    logic clk = 0;
    logic en, ld, reset;
    logic [3:0]d;
    logic [3:0]q;
    singlebcd dut(clk,en,ld,reset,d,q);
    
    always begin
        clk = ~clk; #20;
    end
    
    initial begin
        en = 0; ld = 0; #100;
        en = 1; d = 4'b0100; #100;
        ld = 1; #40 ld = 0; 
        
    end
endmodule
