`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.03.2024 19:47:48
// Design Name: 
// Module Name: multiply3
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
module ripplecarry_adder3(input logic a[2:0], b[2:0],cin, output logic sum[2:0],cout);
    logic w1,w2;
    fulladder_structural first(a[0],b[0],cin,sum[0],w1);
    fulladder_structural second(a[1],b[1],w1,sum[1],w2);
    fulladder_structural third(a[2],b[2],w2,sum[2],cout);
endmodule

module multiply3(input logic A[1:0], output logic P[3:0]);
    logic shiftedA[2:0]; //doubles the A, shiftedA = 2A
    logic extendedA[2:0];
    logic sum[2:0];
    logic cout;
    
    assign shiftedA = {A[1],A[0],1'b0};
    assign extendedA = {1'b0,A[1],A[0]};
    ripplecarry_adder3 rca(shiftedA,extendedA,0,sum,cout);
    assign P = {cout,sum};
endmodule
