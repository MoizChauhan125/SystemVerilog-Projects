`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Create Date: 09/01/2025 06:30:19 PM
// Design Name: Pipelined RISC V
// Module Name: EX_MEM_REGISTER
// Project Name: Pipelined RISC V
// Description: The pipeline Register between the Execute stage and Memory Access Stage
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module EX_MEM_REGISTER(
    output logic REGWRITE_MEM, MEMWRITE_MEM, MEMREAD_MEM,
    output logic [2:0] DATATOREGSEL_MEM,
    output logic [31:0] IMM_MEM, PC_MEM, ALUOUT_MEM, PREOP2_MEM, 
    output logic [31:0] INSTR_MEM, 

    input logic REGWRITE_EX, MEMWRITE_EX, MEMREAD_EX, clk, rst,
    input logic [2:0] DATATOREGSEL_EX,
    input logic [31:0] IMM_EX, PC_EX, ALUOUT_EX, PREOP2_EX, //PREOP2 IS THE OUTPUT OF FORWARD MUXES
    input logic [31:0] INSTR_EX
    ); 
    always_ff@(posedge clk)begin
        if(!rst)begin
            REGWRITE_MEM     <= 0;
            MEMWRITE_MEM     <= 0;
            MEMREAD_MEM      <= 0;
            DATATOREGSEL_MEM <= 0;
   
            INSTR_MEM   <= 0;
            IMM_MEM     <= 0;
            PC_MEM      <= 0;
            ALUOUT_MEM  <= 0;
            PREOP2_MEM   <= 0;
        end
        else begin
            REGWRITE_MEM     <= REGWRITE_EX;
            MEMWRITE_MEM     <= MEMWRITE_EX;
            MEMREAD_MEM      <= MEMREAD_EX;
            DATATOREGSEL_MEM <= DATATOREGSEL_EX;
            INSTR_MEM   <= INSTR_EX;
            IMM_MEM     <= IMM_EX;
            PC_MEM      <= PC_EX;
            ALUOUT_MEM  <= ALUOUT_EX;
            PREOP2_MEM   <= PREOP2_EX;
        end
     end
endmodule
