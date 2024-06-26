`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.03.2024 18:15:47
// Design Name: 
// Module Name: mux4to1_tb
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


module mux4to1_tb();
    logic s[1:0],i[3:0],y;
    mux4to1 dut(i[0],i[1],i[2],i[3],s[0],s[1],y);
    initial begin
        s={0,0}; i={0,0,0,0}; #20;
//        s={0,0}; i={1,0,0,0}; #20; 
//        s={0,0}; i={0,1,0,0}; #20; 
//        s={0,0}; i={0,0,1,0}; #20; 
        s={0,0}; i={1,1,1,0}; #20;
        s={0,0}; i={0,0,0,1}; #20;     
        s={0,1}; i={0,0,0,0}; #20;
        s={0,1}; i={1,1,0,1}; #20;
        s={0,1}; i={0,0,1,0}; #20;        
        s={1,0}; i={0,0,0,0}; #20;
        s={1,0}; i={1,0,1,1}; #20;
        s={1,0}; i={0,1,0,0}; #20;      
        s={1,1}; i={0,0,0,0}; #20;
        s={1,1}; i={0,1,1,1}; #20;
        s={1,1}; i={1,0,0,0}; #20;   
    end
endmodule
