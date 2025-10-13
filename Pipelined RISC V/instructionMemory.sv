`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/27/2025 03:24:02 PM
// Design Name: Pipelined RISC V
// Module Name: instructionMemory
// Project Name: Pipelined RISC V
// Description: The Instruction Memory that outputs the 32-bit instuction from the address given to it PC(Program Counter)
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module instructionMemory( 
    output logic [31:0] instr,
    input logic [31:0] addr
    );
    logic [7:0] instructionMem [0:511]; //512 words memory
    assign instr = {instructionMem[addr+3], instructionMem[addr+2], instructionMem[addr+1], instructionMem[addr]};
endmodule
