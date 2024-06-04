`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.03.2024 15:27:29
// Design Name: 
// Module Name: fulladderstructural_tb
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


module fulladderstructural_tb();
logic a,b,cin,s,cout;
    fulladder_structural dut(a,b,cin,s,cout);
    initial begin
        a=0; b=0; cin=0; #20;
        a=0; b=0; cin=1; #20;
        a=1; b=0; cin=0; #20;
        a=1; b=0; cin=1; #20;
        a=0; b=1; cin=0; #20;
        a=0; b=1; cin=1; #20;
        a=1; b=1; cin=0; #20;
        a=1; b=1; cin=1; #20;
    end
endmodule
