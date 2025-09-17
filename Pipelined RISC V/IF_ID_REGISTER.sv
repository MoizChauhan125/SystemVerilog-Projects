`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/01/2025 04:20:41 PM
// Design Name: 
// Module Name: IF_ID_REGISTER
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

module IF_ID_REGISTER(
    output logic [31:0] INSTR_ID, PC_ID,
    input logic [31:0] INSTR_IF, PC_IF,
    input logic clk, rst, stall_IF_ID, flush_IF_ID
    );
    always_ff @(posedge clk or negedge rst) begin
        if (!rst) begin
                INSTR_ID <= 32'b0;
                PC_ID    <= 32'b0;
        end 
        else begin
            if(stall_IF_ID) begin
                INSTR_ID <= INSTR_ID;
                 PC_ID    <= PC_ID;
            end
            else if(flush_IF_ID) begin
                INSTR_ID <= 32'b0;
                PC_ID    <= 32'b0;
            end 
            else begin
                INSTR_ID <= INSTR_IF;
                PC_ID    <= PC_IF;
            end
        end
    end
endmodule