`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.03.2024 21:28:16
// Design Name: 
// Module Name: fulladder_behavioral_tb
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


module fulladder_behavioral_tb();
    logic a,b,cin,s,cout;
    fulladder_behavioral dut(a,b,cin,s,cout);
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
