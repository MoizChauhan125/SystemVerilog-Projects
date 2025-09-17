`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/27/2025 06:43:29 PM
// Design Name: 
// Module Name: immGen
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

module immGen(
    output logic [31:0] imm,
    input logic [31:0] instr
    );
    always@(*)begin
        case(instr[6:0])
                19: begin // I-TYPE Instruction
                    if(instr[14:12] == 3'b001 || instr[14:12] == 3'b101) //SHIFT INSTRUCTIONS (001 = SL, 101 = SR)
                        imm = {{24{1'b0}}, instr[27:20]} & 31;
                    else
                        imm = {{21{instr[31]}}, instr[30:20]};
                end
            3, 103: //LOAD or JALR Instruction
                    imm = {{21{instr[31]}}, instr[30:20]};
                35:  //STORE INSTRUCTIONS
                    imm = {{20{instr[31]}}, instr[31:25], instr[11:7]};
                111: //Jal Instruction
                    imm = {{11{instr[31]}}, instr[31], instr[19:12], instr[20], instr[30:21], 1'b0};
            55, 23: // AUIPC and LUI Instructions
                    imm = {{20{instr[31:12]}}, {12{1'b0}}};
                99: //B-TYPE Branch Instructions
                    imm = {{20{instr[31]}}, instr[30:25], instr[11:8], 1'b0};
           default: imm = 32'h00000000;
        endcase
    end        
endmodule
