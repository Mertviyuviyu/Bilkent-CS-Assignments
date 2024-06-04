`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.04.2024 14:27:20
// Design Name: 
// Module Name: multi_reg_tb
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


module multi_reg_tb();
    logic clk;
    logic reset;
    logic [3:0] d = 0;
    logic [1:0] s;
    logic shift_in;
    logic [3:0] q;
    
    multi_reg dut(clk,reset,shift_in,d,s,q);
    
    always begin
        clk = 0; #10;
        clk = 1; #10;
    end
    
    initial begin
        reset = 1; #20 reset = 0;
        s = 2'b00; d = 4'b0000; shift_in = 0; #20;
        s = 2'b01; d = 4'b1010; shift_in = 0; #20;
        s = 2'b10; d = 4'b1010; shift_in = 0; #20;
        s = 2'b11; d = 4'b1010; shift_in = 1; #20;
        s = 2'b00; d = 4'b1111; shift_in = 1; #20;
        s = 2'b01; d = 4'b1011; shift_in = 1; #20;
        s = 2'b11; d = 4'b1011; shift_in = 0; #20;
        s = 2'b10; d = 4'b1011; shift_in = 0; #20;
        s = 2'b00; d = 4'b1011; shift_in = 0; #20;
        s = 2'b01; d = 4'b1111; shift_in = 0; #20;
    end
endmodule
