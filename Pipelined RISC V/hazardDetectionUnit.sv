`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/04/2025 11:37:30 AM
// Design Name: 
// Module Name: hazardDetectionUnit
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

module hazardDetectionUnit(
    output logic PCWrite, stall_IF_ID, flush_IF_ID, flush_ID_EX, 
    input logic MEMREAD_EX, BRANCHTAKEN_EX, MEMWRITE_ID,
    input logic [4:0] RD_EX, RS1_ID, RS2_ID
    );
    always_comb begin
        if(BRANCHTAKEN_EX) begin
            PCWrite = 1'b1;
            stall_IF_ID = 1'b0;
            flush_IF_ID = 1'b1;
            flush_ID_EX = 1'b1;
        end
        else begin
            if ((MEMREAD_EX) && (!MEMWRITE_ID) && ((RD_EX == RS1_ID)||(RD_EX == RS2_ID)))begin //STORE AFTER LOAD IS HANDLED BY FORWARDING
                PCWrite = 1'b0;
                stall_IF_ID = 1'b1;
                flush_IF_ID = 1'b0;
                flush_ID_EX = 1'b1; 
                
            end
            else begin
                PCWrite = 1'b1;
                stall_IF_ID = 1'b0;
                flush_IF_ID = 1'b0;
                flush_ID_EX = 1'b0; 
            end
        end
    end
endmodule

