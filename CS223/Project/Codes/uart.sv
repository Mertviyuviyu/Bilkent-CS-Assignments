`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.04.2024 19:46:30
// Design Name: 
// Module Name: uart
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


module uart(
  input logic [7:0]switchin,
  input logic transmit4,
  input logic clk,
  input logic switch,
  input logic left,
  input logic right,
  input logic tx_write,
  input logic tx_enable,
  input logic sw15,
  input logic rx_in,
  
  output logic [7:0] txbufled,
  output logic [7:0] rxbufled,
  output logic [3:0] an,
  output logic [6:0] seg,
  output logic tx_out
);
    //clk generator with specified baudrate
    
    
    logic baudclk;
    logic tx_out_reg;
    logic [31:0] txbuf;
    logic [31:0] rxbuf;
    logic [7:0] rx_out;
    logic parity;
    logic stable_enable;
    logic stable_write;
    baudclk clkgen(clk,baudclk);
    
    //module for handling 4byte txbuf read,write
    logic [7:0] discard;
    
    buttonlatch bt2(baudclk,tx_write,stable_write);
    txbuf txbufwriter(baudclk,stable_write,switchin,txbuf,discard);
    
    //uart modules
    buttonlatch bt(baudclk,tx_enable,stable_enable);
    //uart_tx tx(switchin,baudclk,stable_enable,tx_out_reg);
    autotransfer at_tx(txbuf,baudclk,stable_enable,sw15,discard,tx_out_reg);
    uart_rx rx(rx_in,baudclk,rx_out,parity,rxbuf);
    display(txbuf,rxbuf,switch,right,left,clk,an,seg);
    
    assign txbufled = txbuf[7:0];
    assign rxbufled = rxbuf[31:24];
    assign tx_out = tx_out_reg;
endmodule
