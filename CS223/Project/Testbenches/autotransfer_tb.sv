`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.05.2024 11:12:47
// Design Name: 
// Module Name: autotransfer_tb
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


module autotransfer_tb();
    logic [31:0]txbuf;
    logic clk = 0;
    logic en = 0;
    logic out;
    logic [7:0] currout;
    logic par;
    logic [31:0] rxbuf;
    logic switchin = 0;
    logic [7:0] normalin; 
    
    autotransfer dut(txbuf,clk,en,switchin,normalin,out);
    uart_rx test(out,clk,currout,par,rxbuf);
    
    always begin
        clk = ~clk; #5;
    end
    
    initial begin
        txbuf = 32'b10010001_01101100_11110010_00011101; normalin = 8'b00010001; switchin = 1; #20;
        en = 1; #20; en = 0; #630; 
        switchin = 0; #20; en = 1; #20; en = 0;
    end
    
endmodule
