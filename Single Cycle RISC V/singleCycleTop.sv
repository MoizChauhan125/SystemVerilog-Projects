`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Create Date: 08/29/2025 04:24:52 PM
// Design Name: Single Cycle RISC V
// Module Name: lab20
// Project Name: Single Cycle RISC V
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module singleCycleTop(
    input logic clk, rst
    );
    logic [31:0] PC, instr, data1, data2, dataW, aluOut, imm, op1, op2, memData, PC_N;
    logic regWrite, memWrite, aluSrc, memRead, negative, zero, overflow, carry, branch;
    logic [3:0] aluControl;
    logic [1:0] aluop, dataToRegSel;
    programCounter ProgC(PC, clk, rst, branch, PC_N);
    PCControl PCC(PC_N, aluOut, PC, imm, instr[14:12], instr[6:0], carry, zero, negative, overflow);
    instructionMemory IM(instr, PC);
    registerFile RF(data1, data2, dataW, instr[19:15], instr[24:20], instr[11:7], regWrite, clk);
    immGen IG(imm, instr);
    control CTRL(instr[6:0], regWrite, memWrite, memRead, aluSrc, branch, aluop, dataToRegSel);
    aluMux MUX(op1, op2, aluSrc, data1, data2, imm, PC);
    aluControl ALUCTRL(instr[14:12], aluop, instr[31:25], aluControl);
    alu ALU(aluOut, negative, zero, overflow, carry, op1, op2, aluControl);
    dataMemory DM(memData, aluOut, data2, instr[14:12], memRead, memWrite, clk);
    RegDataStoreMux RDSMUX(dataW, memData, aluOut, PC, imm, dataToRegSel);
endmodule


