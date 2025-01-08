`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.11.2024 14:23:49
// Design Name: 
// Module Name: alu_tb
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


module alu_tb();
    logic [31:0] a;
    logic [31:0] b;
    logic [2:0] alu_ctrl;
    logic [31:0] result;
    logic zero;
    
    alu dut(a,b,alu_ctrl, result, zero);
    
    initial begin
        alu_ctrl = 3'b010;
        a = 15;
        b = 20;
        //result = a + b = 35
        #100;
        
        alu_ctrl = 3'b110;
        a = 25;
        b = 25;
        //result = a - b = 0,  zero = 1
        #100;
        
        alu_ctrl = 3'b000;
        a = 6'b111010;
        b = 6'b101010;
        //result = a & b = last 6bits 101010
        #100;
        
        alu_ctrl = 3'b001;
        //result = a | b = last 6bits 111010;
        #100;
        
        alu_ctrl = 3'b111;
        a = 24;
        b = 30;
        //result = a < b = 1
        #100;
        
    end
endmodule
