`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Create Date: 08/29/2025 04:24:52 PM
// Design Name: Single Cycle RISC V
// Module Name: instructionMemory
// Project Name: Single Cycle RISC V
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module instructionMemory( 
    output logic [31:0] instr,
    input logic [31:0] addr    
    );
    logic [7:0] instructionMem [87:0];
    assign instr = {instructionMem[addr+3], instructionMem[addr+2], instructionMem[addr+1], instructionMem[addr]};
endmodule
