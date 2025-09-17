`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/11/2025 07:08:41 PM
// Design Name: 
// Module Name: LSMUX
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


module LSMUX(
    output logic [31:0] MEMINPUTDATA_MEM,
    input logic [31:0] DATAW_WB, PREOP2_MEM,
    input logic FWDLS
    );
    assign MEMINPUTDATA_MEM = FWDLS ? DATAW_WB : PREOP2_MEM;
endmodule
