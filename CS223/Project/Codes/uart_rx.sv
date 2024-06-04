`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.04.2024 18:42:35
// Design Name: 
// Module Name: uart_rx
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


module uart_rx
(
    input logic in,
    input logic clk,
    output logic [7:0] out,
    output logic parity,
    output logic [31:0] rxbuf
);

    initial begin
        out = 8'b0;
    end
    
    parameter STATE_START = 2'b00;
    parameter STATE_DATA = 2'b01;
    parameter STATE_PARITY= 2'b10;
    parameter STATE_STOP = 2'b11;
    
    reg [1:0] state = STATE_START;
    reg [3:0] bitpos = 4'd0;
    reg [7:0] collect = 8'b0;
    reg [31:0] rxbuf_reg = 32'b0;
    
    reg write_req = 0; // New register for write request
    
    
    logic [7:0] discard = 0;
    
    always @(posedge clk) begin
        case(state)
        
        STATE_START: begin
            if(!in) begin
                state <= STATE_DATA;
                bitpos <= 4'd0;
                collect <= 0;
            end
        end
        STATE_DATA: begin
            if(bitpos == 4'd7) begin
                collect[bitpos] <= in;
                state <= STATE_PARITY;
            end
            else begin
                collect[bitpos] <= in;
                bitpos <= bitpos + 1'b1;
            end
        end
        STATE_PARITY: begin
            state <= STATE_STOP;
            parity <= in;
            write_req <= 1'b1;
        end
        STATE_STOP: begin
            write_req <= 1'b0;
            out <= collect;
            state <= STATE_START;
        end
        default: begin
			state <= STATE_START;
		end
        endcase
    end
    
    always @(posedge clk) begin
        if (write_req) begin
            rxbuf_reg[31:8] <= rxbuf_reg[23:0];
            rxbuf_reg[7:0] <= collect;            
        end
    end
    
    
    assign rxbuf = rxbuf_reg;
    
endmodule
