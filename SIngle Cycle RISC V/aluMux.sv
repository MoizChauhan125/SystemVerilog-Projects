`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Create Date: 08/29/2025 04:24:52 PM
// Design Name: Single Cycle RISC V
// Module Name: aluMux
// Project Name: Single Cycle RISC V
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module aluMux(
    output logic [31:0] op1, op2,
    input logic aluSrc,
    input logic [31:0] data1, data2, imm, PC
    );
    assign op1 = data1; //op1 is a wire
    assign op2 = aluSrc ? imm : data2; //alu mux2, pass imm if high
endmodule
