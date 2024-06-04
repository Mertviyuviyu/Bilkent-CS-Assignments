`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.04.2024 16:44:03
// Design Name: 
// Module Name: fourdigitbcd
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


module fourdigitbcd(input logic clk, ld, reset, [15:0]d, output logic [15:0] q);
    logic en2 = 0;
    logic en3 = 0;
    logic en4 = 0;
//    reg [15:0] q_reg = 0;
    
//    singlebcd first(clk,1,ld,reset,d[3:0],q_reg[3:0]);
//    singlebcd second(clk,en2,ld,reset,d[7:4],q_reg[7:4]);
//    singlebcd third(clk,en3,ld,reset,d[11:8],q_reg[11:8]);
//    singlebcd fourth(clk,en4,ld,reset,d[15:12],q_reg[15:12]);
    
    singlebcd first(clk,1,ld,reset,d[3:0],q[3:0]);
    singlebcd second(clk,en2,ld,reset,d[7:4],q[7:4]);
    singlebcd third(clk,en3,ld,reset,d[11:8],q[11:8]);
    singlebcd fourth(clk,en4,ld,reset,d[15:12],q[15:12]);
    
    
    
   always @(posedge clk) begin
        if(q[3:0] == 4'b1000) begin
            en2 <= 1;
        end
        else begin
            en2 <= 0;
        end
    end
    
    always @(posedge clk) begin
        if(q[7:4] == 4'b1001 && q[3:0] == 4'b1000) begin
            en3 <= 1;
        end
        else begin
            en3 <= 0;
        end
    end
    
    always @(posedge clk) begin
        if(q[11:8] == 4'b1001 && q[7:4] == 4'b1001 && q[3:0] == 4'b1000) begin
            en4 <= 1;
        end
        else begin
            en4 <= 0;
        end
    end
endmodule
