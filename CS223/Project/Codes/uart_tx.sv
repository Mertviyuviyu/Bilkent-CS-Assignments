`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.04.2024 12:47:47
// Design Name: 
// Module Name: uart_tx
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


module uart_tx
( 
  input logic [7:0]in,
  input logic clk,
  input logic enable,
  output logic out
);
    initial begin
        out = 1'b1;
    end
    parameter STATE_IDLE = 3'b000;
    parameter STATE_START = 3'b001;
    parameter STATE_DATA = 3'b010;
    parameter STATE_PARITY = 3'b011;
    parameter STATE_STOP = 3'b100;

    
    reg [7:0] data = 8'b0;
    reg [2:0] bitpos = 3'b0;
    reg [2:0] state = STATE_IDLE;
    reg [31:0] txbuf_reg = 0;
    
    
    always @(posedge clk) begin
            case(state)
            STATE_IDLE: begin
                out <= 1'b1;
                if(enable) begin
                        state <= STATE_START;
                        data <= in;
                        bitpos <= 3'b0;
                end
            end
            STATE_START: begin
                out <= 1'b0;
                state <= STATE_DATA;
            end
            STATE_DATA: begin
                if(bitpos == 3'd7) begin
                    state = STATE_PARITY;
                end
                else begin
                    bitpos <= bitpos + 3'd1;
                end
                out <= data[bitpos];
            end
            STATE_PARITY: begin
                out <= ~^data;
                state <= STATE_IDLE;
            end        
            default: begin
                out <= 1'b1;
                state <= STATE_IDLE;
            end
        endcase
        end
endmodule
