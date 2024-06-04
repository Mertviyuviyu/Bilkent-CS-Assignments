`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.04.2024 19:14:02
// Design Name: 
// Module Name: uart_tx_tb
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


module uart_tx_tb();
  logic [7:0]in;
  logic clk = 1;
  logic out;
  
  uart_tx dut(0,0,in,clk,1'b1,out);
  always begin
    clk = ~clk; #10;
  end
  initial begin
    in = 8'b10110110; #205;
    in = 8'b01110001;
  end
endmodule
