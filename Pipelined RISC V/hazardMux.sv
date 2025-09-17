`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/04/2025 12:54:21 PM
// Design Name: 
// Module Name: hazardMux
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


module hazardMux(
    input logic stall, PREREGWRITE_ID, PREMEMWRITE_ID,
    output logic REGWRITE_ID, MEMWRITE_ID
    );
    assign REGWRITE_ID = (stall == 1)? 1'b0: PREREGWRITE_ID; 
    assign MEMWRITE_ID = (stall == 1)? 1'b0: PREMEMWRITE_ID; 
endmodule
