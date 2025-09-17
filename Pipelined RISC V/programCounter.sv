`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/27/2025 03:10:58 PM
// Design Name: 
// Module Name: programCounter
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
