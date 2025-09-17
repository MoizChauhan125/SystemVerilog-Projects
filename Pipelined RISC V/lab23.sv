`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/01/2025 12:47:15 PM
// Design Name: 
// Module Name: lab22
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


module lab23(
    input logic clk, rst
    );
    // Program Counter and Instruction
    logic [31:0] PC_IF, INSTR_IF, PC_ID, INSTR_ID, PC_EX, INSTR_EX, PC_MEM, INSTR_MEM, PC_WB, INSTR_WB; 

    //Hazard Detection Signals
    logic PCWrite, stall_IF_ID, flush_IF_ID, flush_ID_EX;

    // Register File Data
    logic [31:0] DATA1_ID, DATA2_ID, DATAW_WB, DATA1_EX, DATA2_EX, MEMDATA_MEM, MEMDATA_WB;

    // Immediate values
    logic [31:0] IMM_ID, IMM_EX, IMM_MEM, IMM_WB;

    // Forward Muxes
    logic [31:0] PREOP1_EX, PREOP2_EX, MEMINPUTDATA_MEM;
    logic [1:0] FWDA, FWDB;
    logic FWDLS;
    
    // ALU
    logic [31:0] ALUOUT_EX, ALUOUT_MEM, ALUOUT_WB, OP1_EX, OP2_EX;
    logic [3:0]  ALUCONTROL_EX;
    logic [31:0] PREOP2_MEM; //DATAMEMORY INPUT

    // Control signals
    logic REGWRITE_ID, MEMWRITE_ID, MEMREAD_ID, ALUSRC_ID, BRANCH_ID;
    logic REGWRITE_EX, MEMWRITE_EX, MEMREAD_EX, ALUSRC_EX, BRANCH_EX;
    logic REGWRITE_MEM, MEMWRITE_MEM, MEMREAD_MEM, BRANCH_MEM, MEMREAD_WB;
    logic REGWRITE_WB;

    // Multiplexers & Data to Reg Select
    logic [1:0] ALUOP_ID, ALUOP_EX;
    logic [2:0] DATATOREGSEL_EX,DATATOREGSEL_ID, DATATOREGSEL_MEM, DATATOREGSEL_WB;
    
    // Flags
    logic ZERO_EX, NEGATIVE_EX, OVERFLOW_EX, CARRY_EX;

    // Jump and Branch PC control
    logic [31:0] PCNEXT_EX;
    logic BRANCHTAKEN_EX;
    
    
    //INSTRUCTION FETCH STAGE
    
//    programCounter ProgC(PC_IF, clk, rst, stall, BRANCH_MEM, PCNEXT_MEM);
    programCounter ProgC(PC_IF, clk, rst, PCWrite, BRANCHTAKEN_EX, PCNEXT_EX);
    instructionMemory IM(INSTR_IF, PC_IF);
    
    
    IF_ID_REGISTER IIR(INSTR_ID, PC_ID, INSTR_IF, PC_IF, clk, rst, stall_IF_ID, flush_IF_ID);
    
    
    //INSTRUCTION DECODE STAGE
    registerFile RF(DATA1_ID, DATA2_ID, DATAW_WB, INSTR_ID[19:15], INSTR_ID[24:20], INSTR_WB[11:7], REGWRITE_WB, clk);
    control CTRL(INSTR_ID[6:0], REGWRITE_ID, MEMWRITE_ID, MEMREAD_ID, ALUSRC_ID, BRANCH_ID, ALUOP_ID, DATATOREGSEL_ID);
    immGen IG(IMM_ID, INSTR_ID);
    
    
                                    //HAZARD DETECTION UNIT
    hazardDetectionUnit HDU(PCWrite, stall_IF_ID, flush_IF_ID, flush_ID_EX, MEMREAD_EX, BRANCHTAKEN_EX, MEMWRITE_ID, INSTR_EX[11:7], INSTR_ID[19:15], INSTR_ID[24:20]);
    
    ID_EX_REGISTER IER(PC_EX, DATA1_EX, DATA2_EX, IMM_EX, REGWRITE_EX, MEMWRITE_EX, MEMREAD_EX,
    ALUSRC_EX, BRANCH_EX, ALUOP_EX, DATATOREGSEL_EX, INSTR_EX, PC_ID, DATA1_ID, DATA2_ID, IMM_ID, 
    REGWRITE_ID, MEMWRITE_ID, MEMREAD_ID, ALUSRC_ID, BRANCH_ID, clk, rst, flush_ID_EX, ALUOP_ID, DATATOREGSEL_ID, INSTR_ID);
    
    //INSTRUCTION EXECUTE STAGE
                                                //DATA HAZARD FORWARDING UNIT
    forwardUnit FU(INSTR_EX[19:15], INSTR_EX[24:20], INSTR_MEM[11:7], INSTR_WB[11:7], INSTR_MEM[24:20], FWDA, FWDB, FWDLS, REGWRITE_MEM, REGWRITE_WB, MEMWRITE_EX, MEMREAD_WB, MEMWRITE_MEM);
    forwardMuxes FM(PREOP1_EX, PREOP2_EX, DATA1_EX, DATA2_EX, ALUOUT_MEM, DATAW_WB, FWDA, FWDB);
    aluMux MUX(OP1_EX, OP2_EX, ALUSRC_EX, PREOP1_EX, PREOP2_EX, IMM_EX);
                                                //ALU
    aluControl ALUCTRL(INSTR_EX[14:12], ALUOP_EX, INSTR_EX[31:25], ALUCONTROL_EX);
    alu ALU(ALUOUT_EX, NEGATIVE_EX, ZERO_EX, OVERFLOW_EX, CARRY_EX, OP1_EX, OP2_EX, ALUCONTROL_EX);
    

    EX_MEM_REGISTER EMR(REGWRITE_MEM, MEMWRITE_MEM, MEMREAD_MEM, DATATOREGSEL_MEM, IMM_MEM, PC_MEM, 
    ALUOUT_MEM, PREOP2_MEM, INSTR_MEM, REGWRITE_EX, MEMWRITE_EX, MEMREAD_EX, clk, rst, DATATOREGSEL_EX, IMM_EX, 
    PC_EX, ALUOUT_EX, PREOP2_EX, INSTR_EX);
    
    //MEMORY ACCESS STAGE
    PCControl PCC(PCNEXT_EX, BRANCHTAKEN_EX, ALUOUT_EX, PC_EX, IMM_EX, INSTR_EX[14:12], INSTR_EX[6:0],CARRY_EX, ZERO_EX, NEGATIVE_EX, OVERFLOW_EX, BRANCH_EX);
    LSMUX LSM(MEMINPUTDATA_MEM, DATAW_WB, PREOP2_MEM, FWDLS);
    dataMemory DM(MEMDATA_MEM, ALUOUT_MEM, MEMINPUTDATA_MEM, INSTR_MEM[14:12], MEMREAD_MEM, MEMWRITE_MEM, clk);
    
    
    MEM_WB_REGISTER MWR(REGWRITE_WB, DATATOREGSEL_WB, PC_WB, IMM_WB, ALUOUT_WB, MEMDATA_WB, MEMREAD_WB, INSTR_WB[11:7], REGWRITE_MEM, clk, rst, DATATOREGSEL_MEM, PC_MEM, IMM_MEM, 
    ALUOUT_MEM, MEMDATA_MEM, MEMREAD_MEM, INSTR_MEM[11:7]);
 
    //WRITEBACK STAGE
    RegDataStoreMux RDSMUX(DATAW_WB, MEMDATA_WB, ALUOUT_WB, PC_WB, IMM_WB, DATATOREGSEL_WB);
endmodule
