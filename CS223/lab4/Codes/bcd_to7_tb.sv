`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.04.2024 20:36:27
// Design Name: 
// Module Name: bcd_to7_tb
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


module bcd_to7_tb();
    logic [3:0]w;
    logic a,b,c,d,e,f,g;
    bcd_to7 dut (w,a,b,c,d,e,f,g);
    initial begin
        w= 4'b0000; #20;
        w= 4'b0001; #20;
        w= 4'b0010; #20;
        w= 4'b0011; #20;
        w= 4'b0100; #20;
        w= 4'b0101; #20;
        w= 4'b0110; #20;
        w= 4'b0111; #20;
        w= 4'b1000; #20;
        w= 4'b1001; #20;
        w= 4'b1101; #20;
    end
endmodule
