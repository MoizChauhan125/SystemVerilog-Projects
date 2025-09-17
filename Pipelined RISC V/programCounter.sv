`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// Create Date: 08/27/2025 03:10:58 PM
// Design Name: Pipelined RISC V
// Module Name: ProgramCounter
// Project Name: Pipelined RISC V
// Description: The register that updates on each clock cycle and tells the Instruction Address to the Instruction Memory
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module programCounter(
    output logic [31:0] PC, 
    input  logic clk, 
    input  logic rst,
    input  logic PCWrite,
    input  logic BRANCHTAKEN_MEM,      // from PCControl
    input  logic [31:0] PC_N           // next PC (target)
);
    always_ff @(posedge clk or negedge rst) begin
        if (!rst) begin
            PC <= 32'h0;               // reset always highest priority
        end
        else if (PCWrite) begin
            if (BRANCHTAKEN_MEM)
                PC <= PC_N;            // branch/jump target
            else
                PC <= PC + 4;          // normal sequential execution
        end
        else begin
            PC <= PC;                  // stall: hold value
        end
    end
endmodule
