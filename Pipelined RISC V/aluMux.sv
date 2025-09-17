`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/27/2025 07:09:16 PM
// Design Name: 
// Module Name: aluMux
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

module aluMux(
    output logic [31:0] op1, op2,
    input logic aluSrc,
    input logic [31:0] data1, data2, imm
    );
    assign op1 = data1; //op1 is a wire
    assign op2 = aluSrc ? imm : data2; //alu mux2, pass imm if high
endmodule
