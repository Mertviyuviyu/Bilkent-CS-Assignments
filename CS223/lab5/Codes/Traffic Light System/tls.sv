`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.04.2024 15:11:54
// Design Name: 
// Module Name: tls
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


module tls(input logic clk, reset, sa, sb, output logic [2:0]la,[2:0]lb );
    parameter green = 3'b110;
    parameter yellow = 3'b100;
    parameter red = 3'b111;
    logic [2:0] state = 3'b000;
    logic [2:0]la_reg = green;
    logic [2:0]lb_reg = red;
    
    logic[28:0] count = 0;
    logic myclk = 0;
    always @(posedge clk) begin
        if(count == 300_000_000) begin
            count <= 0;
            myclk <= ~myclk;
        end
        else begin
            count <= count + 1;
        end        
    end

    always @(posedge myclk) begin
        if(reset) begin
            state = 3'b000;
        end
        else begin
            if(state == 3'b000) begin
                if(!sa)
                    state <= state + 1'b1;
            end
            else if(state == 3'b100) begin
                if(!sb)
                    state <= state + 1'b1;
            end
            else begin
                state <= state + 1'b1;
            end
        end
    end
    
    always @(posedge myclk) begin
        case(state)
        3'b000: begin
            la_reg <= green;
            lb_reg <= red;
        end
        3'b001: begin
            la_reg <= yellow;
            lb_reg <= red;
        end
        3'b010: begin
            la_reg <= red;
            lb_reg <= red;
        end
        3'b011: begin
            la_reg <= red;
            lb_reg <= yellow;
        end
        3'b100: begin
            la_reg <= red;
            lb_reg <= green;
        end
        3'b101: begin
            la_reg <= red;
            lb_reg <= yellow;
        end
        3'b110: begin
            la_reg <= red;
            lb_reg <= red;
        end
        3'b111: begin
            la_reg <= yellow;
            lb_reg <= red;
        end
        default: begin
            la_reg <= green;
            lb_reg <= red;
        end
        endcase
    end
    
    assign la = la_reg;
    assign lb = lb_reg;
   
endmodule
