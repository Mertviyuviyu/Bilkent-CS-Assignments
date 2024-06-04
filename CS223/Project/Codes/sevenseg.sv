`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.04.2024 16:39:29
// Design Name: 
// Module Name: sevenseg
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


module sevenseg(input logic [7:0] in, output logic [13:0] out );
    always @(*) begin
        case(in[3:0])
            4'b0000: out[6:0] = 7'b0000001;   
            4'b0001: out[6:0] = 7'b1001111;
            4'b0010: out[6:0] = 7'b0010010;
            4'b0011: out[6:0] = 7'b0000110;
            4'b0100: out[6:0] = 7'b1001100;
            4'b0101: out[6:0] = 7'b0100100;
            4'b0110: out[6:0] = 7'b0100000; 
            4'b0111: out[6:0] = 7'b0001111;
            4'b1000: out[6:0] = 7'b0000000;    
            4'b1001: out[6:0] = 7'b0000100;
            4'b1010: out[6:0] = 7'b0001000; //a
            4'b1011: out[6:0] = 7'b1100000; //b
            4'b1100: out[6:0] = 7'b1110010; //c
            4'b1101: out[6:0] = 7'b1000010; //d
            4'b1110: out[6:0] = 7'b0110000; //e
            4'b1111: out[6:0] = 7'b0111000; //f
            default: out[6:0] = 7'b1111110;
        endcase
        case(in[7:4])
            4'b0000: out[13:7] = 7'b0000001;   
            4'b0001: out[13:7] = 7'b1001111;
            4'b0010: out[13:7] = 7'b0010010;
            4'b0011: out[13:7] = 7'b0000110;
            4'b0100: out[13:7] = 7'b1001100;
            4'b0101: out[13:7] = 7'b0100100;
            4'b0110: out[13:7] = 7'b0100000; 
            4'b0111: out[13:7] = 7'b0001111;
            4'b1000: out[13:7] = 7'b0000000;    
            4'b1001: out[13:7] = 7'b0000100;
            4'b1010: out[13:7] = 7'b0001000; //a
            4'b1011: out[13:7] = 7'b1100000; //b
            4'b1100: out[13:7] = 7'b1110010; //c
            4'b1101: out[13:7] = 7'b1000010; //d
            4'b1110: out[13:7] = 7'b0110000; //e
            4'b1111: out[13:7] = 7'b0111000; //f
            default: out[13:7] = 7'b1111110;
        
        endcase
    end
endmodule