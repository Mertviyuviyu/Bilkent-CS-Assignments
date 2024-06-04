`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.04.2024 16:10:31
// Design Name: 
// Module Name: singlebcd
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


module singlebcd(input logic clk, en, ld,reset, [3:0]d, output logic [3:0]q);
    reg [3:0] q_reg = 4'b0000; 
    always @(posedge clk) begin
        if(reset) begin
            q_reg <= 0;
        end
        else if(ld) begin
            q_reg <= d;
        end
        else if(en) begin
           if(q_reg == 4'b1001) begin
               q_reg <= 4'b0000;
           end
           else begin
               q_reg <= q_reg + 1'b1;
           end
        end
    end
    assign q = q_reg;
endmodule
