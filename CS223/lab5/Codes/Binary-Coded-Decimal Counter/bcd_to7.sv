`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.04.2024 19:07:42
// Design Name: 
// Module Name: bcd_to7
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


module bcd_to7(input logic [3:0]w, output logic a,b,c,d,e,f,g);
    always @(*)
    begin
        case(w)
        4'b0000: 
        begin
            a=0; b=0; c=0; d=0; e=0; f=0; g=1;
        end
        4'b0001: 
        begin
            a=1; b=0; c=0; d=1; e=1; f=1; g=1;
        end
        4'b0010: 
        begin
            a=0; b=0; c=1; d=0; e=0; f=1; g=0;
        end
        4'b0011: 
        begin
            a=0; b=0; c=0; d=0; e=1; f=1; g=0;
        end
        4'b0100: 
        begin
            a=1; b=0; c=0; d=1; e=1; f=0; g=0;
        end
        4'b0101: 
        begin
            a=0; b=1; c=0; d=0; e=1; f=0; g=0;
        end
        4'b0110: 
        begin
            a=0; b=1; c=0; d=0; e=0; f=0; g=0;
        end
        4'b0111: 
        begin
            a=0; b=0; c=0; d=1; e=1; f=1; g=1;
        end
        4'b1000: 
        begin
            a=0; b=0; c=0; d=0; e=0; f=0; g=0;
        end
        4'b1001: 
        begin
            a=0; b=0; c=0; d=0; e=1; f=0; g=0;
        end
        default:
        begin
            a=1; b=1; c=1; d=1; e=1; f=1; g=0;
        end
        endcase
    end
endmodule
