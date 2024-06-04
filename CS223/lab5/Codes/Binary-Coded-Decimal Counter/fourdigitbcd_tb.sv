`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.04.2024 16:54:19
// Design Name: 
// Module Name: fourdigitbcd_tb
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


module fourdigitbcd_tb();
    logic clk = 0; 
    logic ld, reset;
    logic [15:0]d;
    logic [15:0]q;
    
    fourdigitbcd dut(clk,ld,reset,d,q);
    
    always begin
        clk = ~clk; #2;
    end
    
    initial begin
        d = 16'b0010_1001_1000_0111; ld = 0; reset = 0; #40;
        ld = 1; #10;
        ld = 0; #100; 
        reset = 1; #10; reset = 0;
        
    end   
endmodule
