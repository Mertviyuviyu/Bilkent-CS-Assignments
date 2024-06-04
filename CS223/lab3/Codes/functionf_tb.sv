`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.03.2024 18:58:06
// Design Name: 
// Module Name: functionf_tb
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


module functionf_tb();
logic a,b,c,d,e,f;
    functionf dut(a,b,c,d,e,f);
    initial begin
        a=0; b=0; c=0; d=0; e=1; #20;
        a=0; b=0; c=0; d=1; e=0; #20;
        a=0; b=0; c=1; d=1; e=1; #20;
        a=0; b=1; c=0; d=1; e=0; #20;
        a=1; b=0; c=0; d=0; e=0; #20;
        a=1; b=0; c=0; d=0; e=1; #20;
        a=1; b=0; c=0; d=1; e=0; #20;
        a=1; b=0; c=0; d=1; e=1; #20;
        a=1; b=0; c=1; d=0; e=1; #20;
        a=1; b=1; c=0; d=1; e=0; #20;
        a=1; b=1; c=1; d=0; e=1; #20;
        a=1; b=1; c=1; d=1; e=0; #20;
        a=1; b=1; c=1; d=1; e=1; #20;
        a=1; b=1; c=1; d=1; e=0; #20;
        a=1; b=1; c=1; d=0; e=0; #20;
        a=0; b=1; c=1; d=1; e=0; #20;
    end
endmodule
