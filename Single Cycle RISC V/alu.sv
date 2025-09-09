`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Create Date: 08/29/2025 04:24:52 PM
// Design Name: Single Cycle RISC V
// Module Name: alu
// Project Name: Single Cycle RISC V
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module alu(
    output logic [31:0] aluOut,
    output logic negative, zero, overflow, carry,
    input logic [31:0] op1, op2,
    input logic [3:0] aluControl
    );
    
    assign negative = aluOut[31];  
          
    assign zero = (aluOut == 0);
    
    always@(*)begin
        case(aluControl)
            4'b0000: {carry, overflow, aluOut} = {2'b00, (op1 & op2)}; // AND
            4'b0001: {carry, overflow, aluOut} = {2'b00, (op1 | op2)}; // OR
            
            /*
                Carry occurs when the unsigned numbers have result greater than the available bits
                Overflow occurs when positive numbers have negative result or negative numbers have positive result
                Overflow doesn't occur when opposite sign numbers are added or same sign numbers are in subtraction as the results falls between the two
            */
            4'b0010: begin //add
                {carry, aluOut} = op1 + op2; //add or lw or sw (lw and sw also need addition from ALU)
                overflow = ((op1[31] == op2[31]) && (aluOut[31] != op1[31]));
            end
            4'b0110: begin //subtract 
                {carry, aluOut} = op1 - op2; //carry is the borrow bit in sub, 0 MEANS CARRY OCCURED, 1 MEANS NO CARRY OCCURED 
                overflow = ((op1[31] != op2[31]) && (aluOut[31] != op1[31]));
            end
            
            
            4'b0011: {carry, overflow, aluOut} = {2'b00, (op1 << (op2 & 31))}; //sll
            4'b0100: {carry, overflow, aluOut} = {2'b00, (op1 >> (op2 & 31))}; //srl
            4'b0101: {carry, overflow, aluOut} = {2'b00, (($signed(op1) >>> (op2 & 31)))}; //sra
            4'b0111: {carry, overflow, aluOut} = {2'b00, (op1 ^ op2)}; //xor
            4'b1100: {carry, overflow, aluOut} = {2'b00, (($signed(op1) < $signed(op2)) ? 32'd1 : 32'd0)}; // slt
            4'b1101: {carry, overflow, aluOut} = {2'b00, ((op1 < op2) ? 32'd1 : 32'd0)}; // sltu 
            default: begin 
                aluOut = 32'h00000000;
                {carry, overflow} = 2'b00;
            end
        endcase
    end
endmodule

