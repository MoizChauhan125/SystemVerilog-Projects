`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/31/2025 03:40:53 PM
// Design Name: 
// Module Name: PCControl
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


module PCControl(
    output logic [31:0] PC_N,
    output logic BRANCHTAKEN_EX,
    input logic [31:0] aluOut, PC, imm,
    input logic [2:0] func3,
    input logic [6:0] opcode, 
    input logic carry, zero, negative, overflow, branch //flags
    );
    always_comb begin
         if((branch) && (opcode == 99)) begin //Pure branch B-Type Instructions
            PC_N = PC + imm;
            case(func3)
                 3'b000: BRANCHTAKEN_EX = zero; //beq
                 3'b001: BRANCHTAKEN_EX = (!zero);  //bne
                 3'b100: BRANCHTAKEN_EX = (negative & overflow); //blt
                 3'b101: BRANCHTAKEN_EX = ((negative & overflow) || zero); //bge
                 3'b110: BRANCHTAKEN_EX = (!carry); //bltu
                 3'b111: BRANCHTAKEN_EX = carry; //bgeu
                 default: BRANCHTAKEN_EX = 1'b0;
            endcase
        end
        else if((branch) && (opcode != 99)) begin
            if(opcode == 111) begin //JAL
                BRANCHTAKEN_EX = 1'b1;
                PC_N = PC + imm;
            end
            else if(opcode == 103) begin //JALR
                BRANCHTAKEN_EX = 1'b1;
                PC_N = PC + aluOut;
            end
            else begin //no jump
                PC_N = 32'b0;
                BRANCHTAKEN_EX = 1'b0;
            end    
        end
        else begin
            PC_N = 32'b0;
            BRANCHTAKEN_EX = 1'b0;
        end
    end
endmodule