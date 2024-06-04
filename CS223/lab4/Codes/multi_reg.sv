`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.04.2024 13:50:43
// Design Name: 
// Module Name: multi_reg
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


module multi_reg(input logic clk,reset,shift_in, [3:0]d, [1:0]s,  output logic [3:0]q);

logic w1,w2,w3,w4;
logic [50:0]counter = 0;
logic myclock = 0;

always @(posedge clk) begin
        if(counter  == 1000000000)
        begin
            counter <= 0;
            myclock <= ~myclock;
        end
        else
        begin
            counter <= counter+1;
        end
end

mux4to1 mux1(q[0],d[0],shift_in,q[1],s[0],s[1],w1);
mux4to1 mux2(q[1],d[1],q[0],q[2],s[0],s[1],w2);
mux4to1 mux3(q[2],d[2],q[1],q[3],s[0],s[1],w3);
mux4to1 mux4(q[3],d[3],q[2],shift_in,s[0],s[1],w4);

flipflop_sync f1(myclock,reset,w4,q[3]);
flipflop_sync f2(myclock,reset,w3,q[2]);
flipflop_sync f3(myclock,reset,w2,q[1]);
flipflop_sync f4(myclock,reset,w1,q[0]);

endmodule
