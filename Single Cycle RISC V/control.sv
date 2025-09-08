`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Create Date: 08/29/2025 04:24:52 PM
// Design Name: Single Cycle RISC V
// Module Name: control
// Project Name: Single Cycle RISC V
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module control(
    input logic [6:0] opcode,
    output logic regWrite, memWrite, memRead, aluSrc,  
    output logic [1:0] aluop, dataToRegSel, jump
    );
    always@(*) begin
        case(opcode) 
           19: {dataToRegSel, memWrite, memRead, aluSrc, regWrite, aluop, jump} = 10'b01_0_0_1_1_10_00; // 19: The opcode for I-Type Instructions
           51: {dataToRegSel, memWrite, memRead, aluSrc, regWrite, aluop, jump} = 10'b01_0_0_0_1_10_00; // 51: The opcode for R-Type Instructions
            3: {dataToRegSel, memWrite, memRead, aluSrc, regWrite, aluop, jump} = 10'b11_0_1_1_1_00_00; //  3: The opcode for load Instructions (follows I-Tpe format)
           35: {dataToRegSel, memWrite, memRead, aluSrc, regWrite, aluop, jump} = 10'b01_1_0_1_0_00_00; // 35: The opcode for S-Type (store) Instructions
          111: {dataToRegSel, memWrite, memRead, aluSrc, regWrite, aluop, jump} = 10'b00_0_0_1_1_00_01; //111: The opcode for JAL Instruction
          103: {dataToRegSel, memWrite, memRead, aluSrc, regWrite, aluop, jump} = 10'b00_0_0_1_1_00_11; //103: The opcode for JALR Instruction 
           55: {dataToRegSel, memWrite, memRead, aluSrc, regWrite, aluop, jump} = 10'b10_0_0_1_1_00_00; // 55: The opcode for LUI Instruction 
           23: {dataToRegSel, memWrite, memRead, aluSrc, regWrite, aluop, jump} = 10'b00_0_0_0_1_00_10; // 23: The opcode for AUIPC Instruction 
           99: {dataToRegSel, memWrite, memRead, aluSrc, regWrite, aluop, jump} = 10'b00_0_0_0_0_01_01; // 99: opcode for B-TYPE Instructions
           default: {dataToRegSel, memWrite, memRead, aluSrc, regWrite, aluop, jump} = 0;
        endcase
    end
endmodule
