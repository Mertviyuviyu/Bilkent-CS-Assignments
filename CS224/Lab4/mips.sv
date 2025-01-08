`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.11.2024 14:06:32
// Design Name: 
// Module Name: mips
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


module mips (input logic clk, reset,
            output logic[31:0] pc,
            input logic[31:0] instr,
            output logic memwrite,
            output logic[31:0] aluout, writedata,
            input logic[31:0] readdata);
            
    logic memtoreg, pcsrc, zero, alusrc, regdst, regwrite,jump, bncon, spc;
    logic [2:0] alucontrol;
    
    controller c (instr[31:26], instr[5:0], zero, memtoreg, memwrite,pcsrc,alusrc, regdst, regwrite, jump, bncon, spc,alucontrol);
    datapath dp (clk, reset, memtoreg, pcsrc, alusrc, regdst,regwrite, jump, bncon, spc,alucontrol, zero, pc, instr, aluout,writedata, readdata);
endmodule

module controller(input logic[5:0] op, funct,
                  input logic zero,
                  output logic memtoreg, memwrite,
                  output logic pcsrc, alusrc,
                  output logic regdst, regwrite,
                  output logic jump,
                  output logic bncon, spc,
                  output logic[2:0] alucontrol);
    
    logic [1:0] aluop;
    logic branch;
    maindec md (op, memtoreg, memwrite, branch, alusrc, regdst,regwrite, jump, bncon, spc, aluop);
    aludec ad (funct, aluop, alucontrol);
    assign pcsrc = branch & zero;
endmodule

module maindec (input logic[5:0] op,
    output logic memtoreg, memwrite, branch,
    output logic alusrc, regdst, regwrite, jump,
    bncon, spc,
    output logic[1:0] aluop );
    
    logic [10:0] controls;
    assign {regwrite, regdst, alusrc, branch, memwrite, memtoreg, aluop, jump, bncon, spc} = controls;
    always_comb
    case(op)
        6'b000000: controls <= 11'b11000010000; // R-type
        6'b100011: controls <= 11'b10100100000; // LW
        6'b101011: controls <= 11'b00101000000; // SW
        6'b000100: controls <= 11'b00010001000; // BEQ
        6'b001000: controls <= 11'b10100000000; // ADDI
        6'b000010: controls <= 11'b00000000100; // J
        6'b100000: controls <= 11'b00000001010; // bncon
        6'b110000: controls <= 11'b00101000001; // spc
        default: controls <= 11'bxxxxxxxxxxx; // illegal op
    endcase
endmodule


module aludec (input    logic[5:0] funct,
               input    logic[1:0] aluop,
               output   logic[2:0] alucontrol);
  always_comb
    case(aluop)
      2'b00: alucontrol  = 3'b010;  // add  (for lw/sw/addi)
      2'b01: alucontrol  = 3'b110;  // sub   (for beq)
      default: case(funct)          // R-TYPE instructions
          6'b100000: alucontrol  = 3'b010; // ADD
          6'b100010: alucontrol  = 3'b110; // SUB
          6'b100100: alucontrol  = 3'b000; // AND
          6'b100101: alucontrol  = 3'b001; // OR
          6'b101010: alucontrol  = 3'b111; // SLT
          default:   alucontrol  = 3'bxxx; // ???
        endcase
    endcase
endmodule

module datapath (input logic clk, reset, memtoreg, pcsrc, alusrc,regdst,
                input logic regwrite, jump, bncon, spc,
                input logic[2:0] alucontrol,
                output logic zero,
                output logic[31:0] pc,
                input logic[31:0] instr,
                output logic[31:0] aluout, writedata,
                input logic[31:0] readdata);
                
    logic [4:0] writereg;
    logic [31:0] pcnext, pcnextbr, pcplus4, pcbranch;
    logic [31:0] signimm, signimmsh, srca, srcb, result;
    
    //bncon var
    logic bnconresult;
    logic bnconbranch;
    logic newpcsrc;
    
    
    // register file logic
    regfile rf (clk, regwrite, instr[25:21], instr[20:16],writereg,result, srca, writedata);
    mux2 #(5) wrmux (instr[20:16], instr[15:11], regdst,writereg);
    mux2 #(32) resmux (aluout, readdata, memtoreg, result);
    signext se (instr[15:0], signimm);
    
    // ALU logic
    
    mux2 #(32) srcbmux (writedata, signimm, alusrc, srcb);
    alu alu (srca, srcb, alucontrol, aluout, zero);
    
    //bncon logic
    bnconcheck bc(aluout,srcb,bnconresult);
    mux2 #(1) bnconmux(0,bnconresult,bncon,bnconbranch);
    assign newpcsrc = bnconbranch | pcsrc;

    //spc logic
    //mux2 #(32) wdmux(writedata, pc, spc, writedata);
    
    // next PC logic
    flopr #(32) pcreg(clk, reset, pcnext, pc);
    adder pcadd1(pc, 32'b100, pcplus4);
    sl2 immsh(signimm, signimmsh);
    adder pcadd2(pcplus4, signimmsh, pcbranch);
    mux2 #(32) pcbrmux(pcplus4, pcbranch, newpcsrc,
    pcnextbr);
    mux2 #(32) pcmux(pcnextbr, {pcplus4[31:28],
    instr[25:0], 2'b00}, jump, pcnext);
endmodule

module bnconcheck(input logic[31:0] aluresult, input logic[31:0] srcb, output logic bnconresult );
    assign bnconresult = (aluresult != 4) || (srcb[1:0] & 2'b11 != 0 ); 
endmodule


module regfile (input    logic clk, we3, 
                input    logic[4:0]  ra1, ra2, wa3, 
                input    logic[31:0] wd3, 
                output   logic[31:0] rd1, rd2);

  logic [31:0] rf [31:0];

  // three ported register file: read two ports combinationally
  // write third port on rising edge of clock. Register0 hardwired to 0.

  always_ff@(posedge clk)
     if (we3) 
         rf [wa3] <= wd3;	

  assign rd1 = (ra1 != 0) ? rf [ra1] : 0;
  assign rd2 = (ra2 != 0) ? rf[ ra2] : 0;

endmodule

module adder (input  logic[31:0] a, b,
              output logic[31:0] y);
     
     assign y = a + b;
endmodule

module sl2 (input  logic[31:0] a,
            output logic[31:0] y);
     
     assign y = {a[29:0], 2'b00}; // shifts left by 2
endmodule

module signext (input  logic[15:0] a,
                output logic[31:0] y);
              
  assign y = {{16{a[15]}}, a};    // sign-extends 16-bit a
endmodule

// parameterized register
module flopr #(parameter WIDTH = 8)
              (input logic clk, reset, 
	       input logic[WIDTH-1:0] d, 
               output logic[WIDTH-1:0] q);

  always_ff@(posedge clk, posedge reset)
    if (reset) q <= 0; 
    else       q <= d;
endmodule


// paramaterized 2-to-1 MUX
module mux2 #(parameter WIDTH = 8)
             (input  logic[WIDTH-1:0] d0, d1,  
              input  logic s, 
              output logic[WIDTH-1:0] y);
  
   assign y = s ? d1 : d0; 
endmodule

