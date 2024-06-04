`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.04.2024 21:59:19
// Design Name: 
// Module Name: buttonlatch
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


module buttonlatch(input logic clk,btn, output logic stable);
    initial begin
        stable = 0;
    end
    reg isclicked = 0;
    reg temp = 0;
    always @(posedge clk) begin
        if(isclicked && btn) begin
            stable <= 0;
            isclicked <= 0;
        end
        if(!isclicked && btn && !temp) begin
            stable <= 1;
            temp <= 1;
            isclicked <= 1;  
        end
        if(!isclicked && !btn) begin
            temp <= 0;
        end
    
    end
endmodule
