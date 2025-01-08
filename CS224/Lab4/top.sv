`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.11.2024 14:04:43
// Design Name: 
// Module Name: top
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


module top  (input   logic 	 clk, reset,
         input logic sw_input,
	     output logic [6:0] seg, output logic dp,output logic[3:0] an,                       
	     output  logic       memwrite);    

   logic [31:0] instr, pc,writedata,dataadr,readdata;
   logic newclk;
   
   pulse_controller puls(clk,sw_input,0,newclk);
   display_controller disp(clk,writedata[7:4],writedata[3:0],dataadr[7:4],dataadr[3:0],seg,dp,an);
   // instantiate processor and memories  
   
   mips mips (newclk, reset, pc, instr, memwrite, dataadr, writedata, readdata);  
   imem imem (pc[7:0], instr);  
   dmem dmem (clk, memwrite, dataadr, writedata, readdata);

endmodule


module display_controller(

    input clk,
    input [3:0] in3, in2, in1, in0,
    output [6:0]seg, logic dp,
    output [3:0] an
    );
    
    localparam N = 18;
    
    logic [N-1:0] count = {N{1'b0}};
    always@ (posedge clk)
    count <= count + 1;
    
    logic [4:0]digit_val;
    
    logic [3:0]digit_en;
    always@ (*)
    
    begin
    digit_en = 4'b1111;
    digit_val = in0;
    
    case(count[N-1:N-2])
    
    2'b00 :	//select first 7Seg.
    
    begin
    digit_val = {1'b0, in0};
    digit_en = 4'b1110;
    end
    
    2'b01:	//select second 7Seg.
    
    begin
    digit_val = {1'b0, in1};
    digit_en = 4'b1101;
    end
    
    2'b10:	//select third 7Seg.
    
    begin
    digit_val = {1'b0, in2};
    digit_en = 4'b1011;
    end
    
    2'b11:	//select forth 7Seg.
    
    begin
    digit_val = {1'b0, in3};
    digit_en = 4'b0111;
    end
    endcase
    end
    
    //Convert digit number to LED vector. LEDs are active low.
    
    logic [6:0] sseg_LEDs;
    always @(*)
    begin
    sseg_LEDs = 7'b1111111; //default
    case( digit_val)
    5'd0 : sseg_LEDs = 7'b1000000; //to display 0
    5'd1 : sseg_LEDs = 7'b1111001; //to display 1
    5'd2 : sseg_LEDs = 7'b0100100; //to display 2
    5'd3 : sseg_LEDs = 7'b0110000; //to display 3
    5'd4 : sseg_LEDs = 7'b0011001; //to display 4
    5'd5 : sseg_LEDs = 7'b0010010; //to display 5
    5'd6 : sseg_LEDs = 7'b0000010; //to display 6
    5'd7 : sseg_LEDs = 7'b1111000; //to display 7
    5'd8 : sseg_LEDs = 7'b0000000; //to display 8
    5'd9 : sseg_LEDs = 7'b0010000; //to display 9
    5'd10: sseg_LEDs = 7'b0001000; //to display a
    5'd11: sseg_LEDs = 7'b0000011; //to display b
    5'd12: sseg_LEDs = 7'b1000110; //to display c
    5'd13: sseg_LEDs = 7'b0100001; //to display d
    5'd14: sseg_LEDs = 7'b0000110; //to display e
    5'd15: sseg_LEDs = 7'b0001110; //to display f
    5'd16: sseg_LEDs = 7'b0110111; //to display "="
    default : sseg_LEDs = 7'b0111111; //dash 
    endcase
    end
    
    assign an = digit_en;
    
    assign seg = sseg_LEDs;
    assign dp = 1'b1; //turn dp off
    
endmodule

module pulse_controller(
	input CLK, sw_input, clear,
	output reg clk_pulse );

	 reg [2:0] state, nextstate;
	 reg [27:0] CNT; 
	 wire cnt_zero; 

	always @ (posedge CLK, posedge clear)
	   if(clear)
	    	state <=3'b000;
	   else
	    	state <= nextstate;

	always @ (sw_input, state, cnt_zero)
          case (state)
             3'b000: begin if (sw_input) nextstate = 3'b001; 
                           else nextstate = 3'b000; clk_pulse = 0; end	     
             3'b001: begin nextstate = 3'b010; clk_pulse = 1; end
             3'b010: begin if (cnt_zero) nextstate = 3'b011; 
                           else nextstate = 3'b010; clk_pulse = 1; end
             3'b011: begin if (sw_input) nextstate = 3'b011; 
                           else nextstate = 3'b100; clk_pulse = 0; end
             3'b100: begin if (cnt_zero) nextstate = 3'b000; 
                           else nextstate = 3'b100; clk_pulse = 0; end
            default: begin nextstate = 3'b000; clk_pulse = 0; end
          endcase

	always @(posedge CLK)
	   case(state)
		3'b001: CNT <= 100000000;
		3'b010: CNT <= CNT-1;
		3'b011: CNT <= 100000000;
		3'b100: CNT <= CNT-1;
	   endcase

//  reduction operator |CNT gives the OR of all bits in the CNT register	
	assign cnt_zero = ~|CNT;

endmodule