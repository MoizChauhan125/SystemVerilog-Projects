`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/27/2025 03:24:02 PM
// Design Name: 
// Module Name: instructionMemory
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


module instructionMemory( 
    output logic [31:0] instr,
    input logic [31:0] addr
    );
    logic [7:0] instructionMem [0:511]; //512 words memory
    initial begin
        integer i;
        for (i = 0; i < 512; i = i + 1) begin
            instructionMem[i] = 8'h00000013;  // opcode of NOP Instructions
        end
    end
    assign instr = {instructionMem[addr+3], instructionMem[addr+2], instructionMem[addr+1], instructionMem[addr]};
endmodule
