`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.04.2024 13:38:33
// Design Name: 
// Module Name: flipflop_sync
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


module flipflop_sync(input logic clk,reset,d, output logic q);
always_ff @(posedge clk)
        if(reset) 
            q <= 0;
        else 
            q <= d;
endmodule
