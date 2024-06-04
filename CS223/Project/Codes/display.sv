`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.04.2024 16:55:45
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


module display(
input logic [31:0]txbuf, 
input logic [31:0]rxbuf,
input logic switch,
input logic right, 
input logic left,
input logic clk,
output logic[3:0] an,
output logic [6:0] seg);

    logic[13:0] tx0;
    logic[13:0] tx1;
    logic[13:0] tx2;
    logic[13:0] tx3;
    
    logic[13:0] rx0;
    logic[13:0] rx1;
    logic[13:0] rx2;
    logic[13:0] rx3;
    
    sevenseg t1(txbuf[7:0],tx0);
    sevenseg t2(txbuf[15:8],tx1);
    sevenseg t3(txbuf[23:16],tx2);
    sevenseg t4(txbuf[31:24],tx3);
    
    sevenseg r1(rxbuf[7:0],rx0);
    sevenseg r2(rxbuf[15:8],rx1);
    sevenseg r3(rxbuf[23:16],rx2);
    sevenseg r4(rxbuf[31:24],rx3);
    
    parameter state_tx = 0;
    parameter state_rx = 1;
    reg state = state_tx;

    reg [6:0]seg_reg = 7'b1110000;
    reg [3:0]anode_reg = 4'b0111;
    
    
    logic [6:0] seg1 = 7'b1110000; //displays t or x on current state
    logic [6:0] seg2 = 7'b0000001; //display the index
    logic [6:0] seg3 = 0;
    logic [6:0] seg4 = 0;

    logic[22:0] counter = 0;
    logic[27:0] counter2 = 0;
    logic myclock = 0;
    logic myclock2 = 0;
    
    logic [1:0] index = 0;
    
    always @(posedge myclock2) begin
        if(switch) begin
            if(state == state_tx)
                state = state_rx;
            else
                state = state_tx;
        end
    end
    
    always @(posedge myclock2) begin
        if(right) begin
            if(index == 2'b11)
                index <= 0;
            else
                index <= index + 1'b1;
        end
        if(left) begin
            if(index == 2'b00)
                index <= 2'b11;
            else 
                index <= index - 1'b1;
        end
    end
    always @(state) begin
        if(state == state_tx)
            seg1 <= 7'b1110000;
        else
            seg1 <= 7'b1111010;
    end
    always @(index) begin
        if(index == 2'b00) begin
            seg2 <= 7'b0000001;
            if(state == state_tx) begin
                seg3 <= tx0[13:7];
                seg4 <= tx0[6:0]; 
            end
            else begin
                seg3 <= rx0[13:7];
                seg4 <= rx0[6:0]; 
            end
        end
        else if(index == 2'b01) begin
            seg2 <= 7'b1001111;
            if(state == state_tx) begin
                seg3 <= tx1[13:7];
                seg4 <= tx1[6:0]; 
            end
            else begin
                seg3 <= rx1[13:7];
                seg4 <= rx1[6:0]; 
            end
        end
        else if(index == 2'b10) begin
            seg2 <= 7'b0010010;
            if(state == state_tx) begin
                seg3 <= tx2[13:7];
                seg4 <= tx2[6:0]; 
            end
            else begin
                seg3 <= rx2[13:7];
                seg4 <= rx2[6:0]; 
            end
        end
        else begin
            seg2 <= 7'b0000110;
            if(state == state_tx) begin
                seg3 <= tx3[13:7];
                seg4 <= tx3[6:0]; 
            end
            else begin
                seg3 <= rx3[13:7];
                seg4 <= rx3[6:0]; 
            end
        end 
    end
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
     
     always @(posedge clk) begin
        if(counter2  == 100000000)
        begin
            counter2 <= 0;
            myclock2 <= ~myclock2;
        end
        else
        begin
            counter2 <= counter2+1;
        end
     end
     
     always @(posedge myclock) begin 
        if(anode_reg == 4'b1110)
            anode_reg <= 4'b1101;
        else if(anode_reg == 4'b1101)
            anode_reg <= 4'b1011;
        else if(anode_reg == 4'b1011)
            anode_reg <= 4'b0111;
        else
            anode_reg <= 4'b1110;
     end
     
     always @(anode_reg) begin
            if(anode_reg == 4'b1110)
                seg_reg <= seg4;
            else if(anode_reg == 4'b1101)
                seg_reg <= seg3;
            else if(anode_reg == 4'b1011)
                seg_reg <= seg2;
            else if(anode_reg == 4'b0111)
                seg_reg <= seg1;
     end
 
     assign an = anode_reg;
     assign seg = seg_reg;
endmodule
