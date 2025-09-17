`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// Create Date: 09/01/2025 04:38:16 PM
// Design Name: Pipelined RISC V
// Module Name: ID_EX_REGISTER
// Project Name: Pipelined RISC V
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module ID_EX_REGISTER(
    output logic [31:0] PC_EX, DATA1_EX, DATA2_EX, IMM_EX,
    output logic REGWRITE_EX, MEMWRITE_EX, MEMREAD_EX, ALUSRC_EX, BRANCH_EX,  
    output logic [1:0] ALUOP_EX, 
    output logic [2:0] DATATOREGSEL_EX,
    output logic [31:0] INSTR_EX,
    
    input logic [31:0] PC_ID, DATA1_ID, DATA2_ID, IMM_ID,
    input logic REGWRITE_ID, MEMWRITE_ID, MEMREAD_ID, ALUSRC_ID, BRANCH_ID, clk, rst, flush_ID_EX,
    input logic [1:0] ALUOP_ID, 
    input logic [2:0] DATATOREGSEL_ID,
    input logic [31:0] INSTR_ID
    );
    always_ff@(posedge clk or negedge rst)begin
        if(!rst) begin
            PC_EX <= 0;
            DATA1_EX <= 0; 
            DATA2_EX <= 0; 
            IMM_EX <= 0;
            INSTR_EX <= 0;
            REGWRITE_EX <= 0;
            MEMWRITE_EX <= 0;
            MEMREAD_EX <= 0;
            ALUSRC_EX <= 0;
            BRANCH_EX <= 0;
            ALUOP_EX <= 0;
            DATATOREGSEL_EX <= 0;
        end
        else begin
            if(flush_ID_EX)begin
                PC_EX <= 0;
                DATA1_EX <= 0; 
                DATA2_EX <= 0; 
                IMM_EX <= 0;
                INSTR_EX <= 0;
                REGWRITE_EX <= 0;
                MEMWRITE_EX <= 0;
                MEMREAD_EX <= 0;
                ALUSRC_EX <= 0;
                BRANCH_EX <= 0;
                ALUOP_EX <= 0;
                DATATOREGSEL_EX <= 0;
            end
            else begin
                PC_EX <= PC_ID;
                DATA1_EX <= DATA1_ID; 
                DATA2_EX <= DATA2_ID; 
                IMM_EX <= IMM_ID;
                INSTR_EX <= INSTR_ID;
                REGWRITE_EX <= REGWRITE_ID;
                MEMWRITE_EX <= MEMWRITE_ID;
                MEMREAD_EX <= MEMREAD_ID;
                ALUSRC_EX <= ALUSRC_ID;
                BRANCH_EX <= BRANCH_ID;
                ALUOP_EX <= ALUOP_ID;
                DATATOREGSEL_EX <= DATATOREGSEL_ID;
            end
        end
    end
endmodule
