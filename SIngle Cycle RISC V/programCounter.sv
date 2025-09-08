`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Create Date: 08/29/2025 04:24:52 PM
// Design Name: Single Cycle RISC V
// Module Name: programCounter
// Project Name: Single Cycle RISC V
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module programCounter( output logic [31:0] PC, 
    input logic clk, 
    input logic rst,
    input logic [31:0] PC_Next 
    );
    always@(posedge clk or negedge rst) begin
        if(!rst)
            PC <= 32'h00000000;
        else
            PC <= PC_Next;
    end
endmodule


