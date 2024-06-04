`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.04.2024 15:30:04
// Design Name: 
// Module Name: tls_tb
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


module tls_tb();
    logic clk = 0;
    logic reset, sa, sb;
    logic [2:0]la;
    logic [2:0]lb;
    
    tls dut(clk,reset,sa,sb,la,lb);
    
    always begin
        clk = ~clk; #20;
    end
    
    initial begin
        reset = 0; sa = 1; sb = 1; #80;
        sa = 0; #280;
        sb = 0; #120;
        
    end
endmodule
