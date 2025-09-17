`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/27/2025 04:44:39 PM
// Design Name: 
// Module Name: control
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

module control(
    input logic [6:0] opcode,
    output logic regWrite, memWrite, memRead, aluSrc, branch,  
    output logic [1:0] aluop,
    output logic [2:0] dataToRegSel
    );
    always@(*) begin
        branch = 0;
        case(opcode) 
           19: {dataToRegSel, memWrite, memRead, aluSrc, regWrite, aluop, branch} = 11'b001_0_0_1_1_10_0; // 19: The opcode for I-Type Instructions
           51: {dataToRegSel, memWrite, memRead, aluSrc, regWrite, aluop, branch} = 11'b001_0_0_0_1_10_0; // 51: The opcode for R-Type Instructions
            3: {dataToRegSel, memWrite, memRead, aluSrc, regWrite, aluop, branch} = 11'b011_0_1_1_1_00_0; //  3: The opcode for load Instructions (follows I-Tpe format)
           35: {dataToRegSel, memWrite, memRead, aluSrc, regWrite, aluop, branch} = 11'b001_1_0_1_0_00_0; // 35: The opcode for S-Type (store) Instructions
          111: {dataToRegSel, memWrite, memRead, aluSrc, regWrite, aluop, branch} = 11'b000_0_0_1_1_00_1; //111: The opcode for JAL Instruction
          103: {dataToRegSel, memWrite, memRead, aluSrc, regWrite, aluop, branch} = 11'b000_0_0_1_1_00_1; //103: The opcode for JALR Instruction 
           55: {dataToRegSel, memWrite, memRead, aluSrc, regWrite, aluop, branch} = 11'b111_0_0_1_1_00_0; // 55: The opcode for LUI Instruction 
           23: {dataToRegSel, memWrite, memRead, aluSrc, regWrite, aluop, branch} = 11'b010_0_0_0_1_00_0; // 23: The opcode for AUIPC Instruction 
           99: {dataToRegSel, memWrite, memRead, aluSrc, regWrite, aluop, branch} = 11'b000_0_0_0_0_01_1; // 99: opcode for B-TYPE Instructions
           default: {dataToRegSel, memWrite, memRead, aluSrc, regWrite, aluop, branch} = 0;
        endcase
    end
endmodule