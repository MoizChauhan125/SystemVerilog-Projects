`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Create Date: 08/29/2025 04:24:52 PM
// Design Name: Single Cycle RISC V
// Module Name: RegDataStoreMux
// Project Name: Single Cycle RISC V
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module RegDataStoreMux(
    output logic [31:0] dataW,
    input logic [31:0] memData, aluOut, PC, imm,
    input logic [1:0] dataToRegSel
    );
    always@(*)begin
        case(dataToRegSel)
            2'b00: dataW = PC + 4; //for ra in JALR and JAL
            2'b01: dataW = PC + imm; //for AUIPC
            2'b11: dataW = memData; //for load instructions
            2'b10: dataW = imm; //for lui
        endcase
    end
endmodule
