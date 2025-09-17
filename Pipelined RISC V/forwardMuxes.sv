`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/03/2025 08:16:06 PM
// Design Name: Pipelined RISC V
// Module Name: forwardMuxes
// Project Name: Pipelined RISC V
// Description: The Muxes that take select signal from Forwarding unit for deciding which operand should be forwarded in the pipeline
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module forwardMuxes(
    output logic [31:0] OP1_EX, OP2_EX, 
    input logic [31:0] PREOP1_EX, PREOP2_EX, ALUOUT_MEM, DATAW_WB, //PREOPs are the operands coming from register file
    input logic [1:0] FWDA, FWDB //selectors for the forward logic muxes
    );
    always_comb begin
        case(FWDA) 
            2'b00: OP1_EX = PREOP1_EX;
            2'b01: OP1_EX = ALUOUT_MEM; //data from MEM stage
            2'b10: OP1_EX = DATAW_WB; //data from WB stage
            default: OP1_EX = PREOP1_EX;
        endcase
        case(FWDB)
            2'b00: OP2_EX = PREOP2_EX;
            2'b01: OP2_EX = ALUOUT_MEM;
            2'b10: OP2_EX = DATAW_WB;
            default: OP2_EX = PREOP2_EX;
        endcase
    end
endmodule
