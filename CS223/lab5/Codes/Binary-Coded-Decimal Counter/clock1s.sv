`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.04.2024 13:09:33
// Design Name: 
// Module Name: clock1s
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


module clock1s(input logic clk, output logic clk1s);
    logic[26:0] count = 0;
    logic myclk = 0;
    always @(posedge clk) begin
        if(count == 100_000_000) begin
            count <= 0;
            myclk <= ~myclk;
        end
        else begin
            count <= count + 1;
        end
        
    end
    assign clk1s = myclk;
endmodule
