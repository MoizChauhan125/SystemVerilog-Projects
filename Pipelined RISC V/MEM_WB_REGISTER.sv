`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/01/2025 07:58:32 PM
// Design Name: 
// Module Name: MEM_WB_REGISTER
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


module MEM_WB_REGISTER(
    output logic REGWRITE_WB,
    output logic [2:0] DATATOREGSEL_WB, 
    output logic [31:0] PC_WB, IMM_WB, ALUOUT_WB, MEMDATA_WB,
    output logic MEMREAD_WB,
    output logic [4:0] RD_WB,
    
    input logic REGWRITE_MEM, clk, rst,
    input logic [2:0] DATATOREGSEL_MEM, 
    input logic [31:0] PC_MEM, IMM_MEM, ALUOUT_MEM, MEMDATA_MEM, 
    input logic MEMREAD_MEM,
    input logic [4:0] RD_MEM
    );
    
    always_ff@(posedge clk)begin
        if(!rst)begin
            //flush control signals
            REGWRITE_WB     <= 0;
            DATATOREGSEL_WB <= 0;
            
            //flush data 
            PC_WB           <= 0;
            IMM_WB          <= 0;
            ALUOUT_WB       <= 0;
            MEMDATA_WB      <= 0;
            RD_WB           <= 0;
            MEMREAD_WB      <= 0;         
        end
        else begin
            //pass control signals
            REGWRITE_WB     <= REGWRITE_MEM;
            DATATOREGSEL_WB <= DATATOREGSEL_MEM;
            
            //pass data 
            PC_WB           <= PC_MEM;
            IMM_WB          <= IMM_MEM;
            ALUOUT_WB       <= ALUOUT_MEM;
            MEMDATA_WB      <= MEMDATA_MEM;
            RD_WB           <= RD_MEM;
            MEMREAD_WB      <= MEMREAD_MEM;
        end
    end
endmodule
