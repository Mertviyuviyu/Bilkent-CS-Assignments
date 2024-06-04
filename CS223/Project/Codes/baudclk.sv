`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.04.2024 19:59:28
// Design Name: 
// Module Name: baudclk
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


module baudclk(input logic clk, output logic baudclk);
    
    reg [8:0] count = 0;
    reg baudclk_reg = 0;
    
    always @(posedge clk) begin
	   if (count == 433) begin
		  count <= 0;
		  baudclk_reg = ~baudclk_reg;
	   end
	   else
		  count <= count + 9'b1;
    end
    
    assign baudclk = baudclk_reg;
    
endmodule
