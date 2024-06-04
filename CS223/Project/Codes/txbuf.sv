`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.04.2024 19:51:05
// Design Name: 
// Module Name: txbuf
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


module txbuf(input logic clk,input logic load_tx, input logic[7:0] in, output logic[31:0]txbuf, output logic [7:0] discard);
    reg [31:0]txbuf_reg = 0;
    initial begin
        discard = 0;
    end
    always @(posedge clk) begin
        if(load_tx) begin
            discard <= txbuf_reg[31:24];
            txbuf_reg[31:24] <= txbuf_reg[23:16];
            txbuf_reg[23:16] <= txbuf_reg[15:8];
            txbuf_reg[15:8] <= txbuf_reg[7:0];
            txbuf_reg[7:0] <= in;
        end
    end
    
    assign txbuf = txbuf_reg;
    
endmodule
