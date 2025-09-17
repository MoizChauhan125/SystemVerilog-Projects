`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/31/2025 03:48:34 PM
// Design Name: 
// Module Name: RegDataStoreMux
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


//module RegDataStoreMux(
//    output logic [31:0] dataW,
//    input logic [31:0] memData, aluOut, PC_Store, imm,
//    input logic [1:0] dataToRegSel
//    );
//    always@(*)begin
//        case(dataToRegSel)
//            2'b00: dataW = PC_Store;
//            2'b11: dataW = memData;
//            2'b10: dataW = imm;
//            default: dataW = aluOut;
//        endcase
//    end
//endmodule


module RegDataStoreMux(
    output logic [31:0] dataW,
    input logic [31:0] memData, aluOut, PC, imm,
    input logic [2:0] dataToRegSel
    );
    always@(*)begin
        case(dataToRegSel)
            2'b000: dataW = PC + 4; //for ra in JALR and JAL
            2'b001: dataW = aluOut; //for R-Type Instructions
            2'b011: dataW = memData; //for load Instructions
            2'b010: dataW = PC + imm; //for AUIPC
            2'b111: dataW = imm; //for lui
            default: dataW = aluOut;
        endcase
    end
endmodule
