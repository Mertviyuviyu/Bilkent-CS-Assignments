`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.04.2024 19:58:08
// Design Name: 
// Module Name: uart_rx_tb
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


module uart_rx_tb();
   logic [7:0] tx_in;
    logic clk = 1;
    logic en;
    logic tx_out;
    logic [7:0] out;
    logic parity;
    logic [31:0] rxbuf;
    
    uart_tx signal(tx_in,clk,en,tx_out);
    uart_rx dut(tx_out,clk,out,parity,rxbuf);
    always begin
        clk = ~clk; #5;
    end
    
    initial begin
          
          en = 1; tx_in = 8'b10010011; #20; en = 0; #100;
          en = 1; tx_in = 8'b11000010; #20; en = 0; #100;
          en = 1; tx_in = 8'b10010101; #20; en = 0; #100;
          en = 1; tx_in = 8'b11110011; #20; en = 0; #100;
          en = 1; tx_in = 8'b10110111; #20; en = 0; #100;
//        in = 0; #20; //start bit
//        in = 1; #40;
//        in = 1; #40;
//        in = 0; #40;
//        in = 1; #40;
//        in = 1; #40;
//        in = 1; #40;
//        in = 0; #40;
//        in = 1; #80;
        
//        in = 0; #20;
//        in = 0; #40;
//        in = 0; #40;
//        in = 1; #40;
//        in = 0; #40;
//        in = 0; #40;
//        in = 0; #40;
//        in = 0; #40;
//        in = 1; #80;
        
    end
endmodule
