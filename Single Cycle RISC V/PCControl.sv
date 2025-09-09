`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Create Date: 08/29/2025 04:24:52 PM
// Design Name: Single Cycle RISC V
// Module Name: PCControl
// Project Name: Single Cycle RISC V
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module PCControl(
    output logic [31:0] PC_N,
    input logic [31:0] aluOut, PC, imm,
    input logic [2:0] func3,
    input logic [6:0] opcode, 
    input logic carry, zero, negative, overflow //flags
    );
    always_comb begin
        if(opcode != 99)begin
            if(opcode == 111) begin //JAL or B-TYPE
                PC_N = PC + imm;
            end
            else if(opcode == 103) begin //JALR
                PC_N = PC + aluOut;
            end
            else if(opcode == 23) begin //AUIPC
                PC_N = PC + 4;
            end
            else begin //no jump
                PC_N = PC + 4;
            end    
        end
        else begin
            case(func3)
                 3'b000: PC_N = zero ? (PC + imm) : (PC + 4); //beq
                 3'b001: PC_N = (!zero) ? (PC + imm) : (PC + 4); //bne
                 3'b100: PC_N = (negative & overflow) ? (PC + imm) : (PC + 4); //blt
                 3'b101: PC_N = ((negative & overflow)|| zero) ? (PC + imm) : (PC + 4); //bge
                 3'b110: PC_N = (!carry) ? (PC + imm) : (PC + 4); //bltu
                 3'b111: PC_N = carry ? (PC + imm) : (PC + 4); //bgeu
                 default: PC_N = PC + 4;
            endcase
        end
    end
endmodule

