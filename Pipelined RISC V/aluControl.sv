`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// Create Date: 08/27/2025 06:49:55 PM
// Design Name: Pipelined RISC V
// Module Name: aluControl
// Project Name: Pipelined RISC V
// Description: The aluControl unit that tells the alu which operation to perform on the current operands 
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module aluControl(
    input logic [2:0] func3,
    input logic [1:0] aluop,
    input logic [6:0] func7,
    output logic [3:0] op
    );
    always@(*) begin
        if(aluop == 2'b00)
            op = 4'b0010; //add
        else if (aluop[0])
            op = 4'b0110; //sub
        else if (aluop[1]) begin
            case(func3)
                3'b000: begin 
                    if(func7 == 7'b0100000)
                        op = 4'b0110; // sub
                    else
                        op = 4'b0010; //add
                end
                3'b111: op = 4'b0000; // and
                3'b110: op = 4'b0001; // or
                3'b100: op = 4'b0111; // xor
                3'b001: op = 4'b0011; // sll
                3'b101: begin 
                    if(func7 == 7'b0100000)
                        op = 4'b0101; // sra
                    else
                        op = 4'b0100; //srl
                end
                3'b010: op = 4'b1100; // slt
                3'b011: op = 4'b1101; // sltu
                default:         op = 4'bxxxx; // unknown
            endcase
        end
        else op = 4'bxxxx;        
    end
endmodule
