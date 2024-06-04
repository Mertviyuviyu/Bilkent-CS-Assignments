`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.04.2024 11:53:29
// Design Name: 
// Module Name: sevenseg_tb
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


module sevenseg_tb();
    logic [7:0] in;
    logic [13:0] out;
    sevenseg dut(in,out);
    initial begin
        in = 8'b1001_0111; #20;
        in = 8'b1111_1000; #20;
        in = 8'b1011_0011; #20;
    end
endmodule
