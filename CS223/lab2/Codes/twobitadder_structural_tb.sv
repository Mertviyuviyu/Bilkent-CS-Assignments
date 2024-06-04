`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.03.2024 14:21:57
// Design Name: 
// Module Name: twobitadder_structural_tb
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


module twobitadder_structural_tb();
    logic a0,b0,a1,b1,cin,s0,s1,cout;
    twobitadder_structural dut(a0,b0,a1,b1,cin,s0,s1,cout);
    initial begin
        a0=0; b0=0; a1=0; b1=0; cin=0; #20;
        a0=0; b0=0; a1=0; b1=0; cin=1; #20;
        a0=1; b0=0; a1=0; b1=0; cin=0; #20;
        a0=1; b0=0; a1=0; b1=0; cin=1; #20;
        a0=1; b0=0; a1=1; b1=0; cin=0; #20;
        a0=1; b0=0; a1=1; b1=0; cin=1; #20;
        a0=0; b0=0; a1=1; b1=0; cin=0; #20;
        a0=0; b0=0; a1=1; b1=0; cin=1; #20;
        a0=0; b0=1; a1=0; b1=0; cin=0; #20;
        a0=0; b0=1; a1=0; b1=0; cin=1; #20;
        a0=0; b0=0; a1=0; b1=1; cin=0; #20;
        a0=0; b0=0; a1=0; b1=1; cin=1; #20;
        a0=0; b0=1; a1=0; b1=1; cin=0; #20;
        a0=0; b0=1; a1=0; b1=1; cin=1; #20;
        a0=1; b0=1; a1=0; b1=0; cin=0; #20;
        a0=1; b0=1; a1=0; b1=0; cin=1; #20;
        a0=1; b0=0; a1=0; b1=1; cin=0; #20;
        a0=1; b0=0; a1=0; b1=1; cin=1; #20;
        a0=0; b0=1; a1=1; b1=0; cin=0; #20;
        a0=0; b0=1; a1=1; b1=0; cin=1; #20;
        a0=0; b0=0; a1=1; b1=1; cin=0; #20;
        a0=0; b0=0; a1=1; b1=1; cin=1; #20;
        a0=1; b0=1; a1=1; b1=0; cin=0; #20;
        a0=1; b0=1; a1=1; b1=0; cin=1; #20;
        a0=1; b0=0; a1=1; b1=1; cin=0; #20;
        a0=1; b0=0; a1=1; b1=1; cin=1; #20;
        a0=1; b0=1; a1=1; b1=1; cin=0; #20;
        a0=1; b0=1; a1=1; b1=1; cin=1; #20;
        a0=1; b0=1; a1=0; b1=1; cin=0; #20;
        a0=1; b0=1; a1=0; b1=1; cin=1; #20;
        a0=0; b0=1; a1=1; b1=1; cin=0; #20;
        a0=0; b0=1; a1=1; b1=1; cin=1; #20;
    end
    
endmodule
