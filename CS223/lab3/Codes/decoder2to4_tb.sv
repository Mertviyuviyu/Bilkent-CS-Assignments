`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.03.2024 18:44:15
// Design Name: 
// Module Name: decoder2to4_tb
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


module decoder2to4_tb();
    logic a[1:0],e,y[3:0];
    decoder2to4 dut(e,a[0],a[1],y[0],y[1],y[2],y[3]);
    initial begin
        a={0,0}; e=1; #20;
        a={0,1}; e=1; #20;
        a={1,0}; e=1; #20;
        a={1,1}; e=1; #20;
        a={0,0}; e=0; #20;
        a={0,1}; e=0; #20;
        a={1,0}; e=0; #20;
        a={1,1}; e=0; #20;
    end

endmodule
