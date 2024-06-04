`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.05.2024 10:51:58
// Design Name: 
// Module Name: autotransfer
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


module autotransfer(
    input logic [31:0] txbuf, 
    input logic clk, 
    input logic enable,
    input logic switch,
    input logic [7:0] normalin,
    output logic out
);
    parameter ASTATE_IDLE = 4'b0000;
    parameter ASTATE_TX4 = 4'b0001;
    parameter ASTATE_LOADTX3 = 4'b0010;
    parameter ASTATE_TX3 = 4'b0011;
    parameter ASTATE_LOADTX2 = 4'b0100;
    parameter ASTATE_TX2 = 4'b0101;
    parameter ASTATE_LOADTX1 = 4'b0110;
    parameter ASTATE_TX1 = 4'b0111;
    parameter ASTATE_NORMAL = 4'b1000;
    
    logic [7:0] inputsel;
    logic[3:0] autostate = ASTATE_IDLE;
    logic transmit = 0;
    
    logic [3:0]cnt = 0;
    
    uart_tx uart(inputsel,clk,transmit,out);
 
    always @(posedge clk) begin
        case(autostate)
        ASTATE_IDLE: begin
            if(enable) begin
                if(switch) begin
                    autostate <= ASTATE_TX4;
                    inputsel <= txbuf[31:24];
                end
                else begin
                    autostate <= ASTATE_NORMAL;
                    inputsel <= normalin;
                end
            end
        end
        ASTATE_NORMAL: begin
            transmit <= 1;
            if(cnt != 4'b1010) begin
                cnt <= cnt + 1;
            end
            else begin
                autostate <= ASTATE_IDLE;
                cnt <= 0;
                transmit <= 0;
            end
        end
        ASTATE_TX4: begin
            transmit <= 1;
            if(cnt != 4'b1010) begin
                cnt <= cnt + 1;
            end
            else begin
                autostate <= ASTATE_LOADTX3;
                cnt <= 0;
                transmit <= 0;
            end
        end
        ASTATE_LOADTX3: begin
            inputsel <= txbuf[23:16];
            autostate <= ASTATE_TX3;
        end
        ASTATE_TX3: begin
            transmit <= 1;
            if(cnt != 4'b1010) begin
                cnt <= cnt + 1;
            end
            else begin
                autostate <= ASTATE_LOADTX2;
                cnt <= 0;
                transmit <= 0;
            end
        end
        ASTATE_LOADTX2: begin
            inputsel <= txbuf[15:8];
            autostate <= ASTATE_TX2;
        end
        ASTATE_TX2: begin
            transmit <= 1;
            if(cnt != 4'b1010) begin
                cnt <= cnt + 1;
            end
            else begin
                autostate <= ASTATE_LOADTX1;
                cnt <= 0;
                transmit <= 0;
            end
        end
        ASTATE_LOADTX1: begin
            inputsel <= txbuf[7:0];
            autostate <= ASTATE_TX1;
        end
        ASTATE_TX1: begin
            transmit <= 1;
            if(cnt != 4'b1010) begin
                cnt <= cnt + 1;
            end
            else begin
                autostate <= ASTATE_IDLE;
                cnt <= 0;
                transmit <= 0;
            end
        end
        endcase
    end
endmodule
