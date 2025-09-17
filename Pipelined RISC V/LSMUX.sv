`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Create Date: 09/11/2025 07:08:41 PM
// Design Name: Pipelined RISC V
// Module Name: LSMUX
// Project Name: Pipelined RISC V
// Description: The Forwarding MUX for store after load hazard
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
