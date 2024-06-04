`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.04.2024 21:12:29
// Design Name: 
// Module Name: display
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


module display(input logic clk,[15:0]userin, output logic[3:0] an, logic[6:0] seg);
    logic[22:0] counter;
    logic myclock = 0;
    logic[3:0] anodesel = 4'b1110;
    logic[6:0] segsel;
    logic[6:0] seg1;
    logic[6:0] seg2;
    logic[6:0] seg3;
    logic[6:0] seg4;
    bcd_to7 b1(userin[3:0],seg1[6],seg1[5],seg1[4],seg1[3],seg1[2],seg1[1],seg1[0]);
    bcd_to7 b2(userin[7:4],seg2[6],seg2[5],seg2[4],seg2[3],seg2[2],seg2[1],seg2[0]);
    bcd_to7 b3(userin[11:8],seg3[6],seg3[5],seg3[4],seg3[3],seg3[2],seg3[1],seg3[0]);
    bcd_to7 b4(userin[15:12],seg4[6],seg4[5],seg4[4],seg4[3],seg4[2],seg4[1],seg4[0]);
    
     always @(posedge clk) begin
        if(counter  == 100000)
        begin
            counter <= 0;
            myclock <= ~myclock;
        end
        else
        begin
            counter <= counter+1;
        end
     end
     
     always @(posedge myclock) begin
        if(anodesel == 4'b1110)
            anodesel <= 4'b1101;
        else if(anodesel == 4'b1101)
            anodesel <= 4'b1011;
        else if(anodesel == 4'b1011)
            anodesel <= 4'b0111;
        else
            anodesel <= 4'b1110;
     end
     
     always @(anodesel) begin
        if(anodesel == 4'b1110)
            segsel <= seg1;
        else if(anodesel == 4'b1101)
            segsel <= seg2;
        else if(anodesel == 4'b1011)
            segsel <= seg3;
        else if(anodesel == 4'b0111)
            segsel <= seg4;
     end
     
     assign an = anodesel;
     assign seg = segsel;
     
endmodule
