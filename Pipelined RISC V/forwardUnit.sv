`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/03/2025 07:07:09 PM
// Design Name: 
// Module Name: forwardUnit
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

//module forwardUnit(
//    input  logic [4:0] RS1_EX, RS2_EX, RD_MEM, RD_WB,
//    output logic [1:0] FWDA, FWDB,
//    input logic REGWRITE_MEM, REGWRITE_WB, MEMWRITE_EX
//);
//    always_comb begin
//                // Forward A
//        if ((RS1_EX == RD_MEM) && REGWRITE_MEM && (RD_MEM != 0))
//            FWDA = 2'b01;
//        else if ((RS1_EX == RD_WB) && REGWRITE_WB && (RD_WB != 0) && (RS1_EX != RD_MEM))
//            FWDA = 2'b10;
//        else
//            FWDA = 2'b00;
        
//                // Forward B
//        if ((RS2_EX == RD_MEM) && REGWRITE_MEM && (RD_MEM != 0))
//            FWDB = 2'b01;
//        else if ((RS2_EX == RD_WB) && REGWRITE_WB && (RD_WB != 0) && (RS2_EX != RD_MEM))
//            FWDB = 2'b10;
//        else
//            FWDB = 2'b00;
//    end
//endmodule

module forwardUnit(
    input  logic [4:0] RS1_EX, RS2_EX, RD_MEM, RD_WB, RS2_MEM,
    output logic [1:0] FWDA, FWDB,
    output logic FWDLS,
    input logic REGWRITE_MEM, REGWRITE_WB, MEMWRITE_EX, MEMREAD_WB, MEMWRITE_MEM
);
    always_comb begin
                // Forward A
        if ((RS1_EX == RD_MEM) && REGWRITE_MEM && (RD_MEM != 0))
            FWDA = 2'b01;
        else if ((RS1_EX == RD_WB) && REGWRITE_WB && (RD_WB != 0) && (RS1_EX != RD_MEM))
            FWDA = 2'b10;
        else
            FWDA = 2'b00;
        
                // Forward B
        if ((RS2_EX == RD_MEM) && REGWRITE_MEM && (RD_MEM != 0))
            FWDB = 2'b01;
        else if ((RS2_EX == RD_WB) && REGWRITE_WB && (RD_WB != 0) && (RS2_EX != RD_MEM))
            FWDB = 2'b10;
        else
            FWDB = 2'b00;
            
        if((RD_WB == RS2_MEM) && MEMREAD_WB && MEMWRITE_MEM && (RD_WB != 0))
            FWDLS = 1'b1;
        else 
            FWDLS = 1'b0;
    end
endmodule