`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// Create Date: 08/27/2025 03:37:25 PM
// Design Name: Pipelined RISC V
// Module Name: rgisterFile
// Project Name: Pipelined RISC V
// Description: The Register File with Combinational Read and Sequential Write containing the total 32 number of 32-bit Registers
// Revision 0.01 - File Created
// Additional Comments: The read operation of Register File in the pipeline happens in the Decode Stage while Write operation happens in WriteBack Stage 
// 
//////////////////////////////////////////////////////////////////////////////////

module registerFile(
    output logic [31:0] data1, data2,
    input logic [31:0] dataW,
    input logic [4:0] rs1, rs2, rd,
    input logic regWEn, clk
    );
    
    logic [31:0] registers [0:31];
    
    //initilize the registers with zero
    integer i;
    initial begin
        registers[0] = 0;
        for (i = 1; i < 32; i = i + 1) begin
            registers[i] = 32'h00000000;   // initialize all registers to zero
        end
    end
    
    //write sequentially when regWrite Enable is high
    always@(negedge clk) begin
        if(regWEn && rd != 0)
            registers[rd] <= dataW; //write to any register except x0
        else begin
            registers[rd] <= registers[rd];
        end
    end
    
    /*  Read combinationally
        When rs1 or rs2 is x0, give 0 to output
    */
    assign data1 = rs1 ? registers[rs1] : 0; 
    assign data2 = rs2 ? registers[rs2] : 0; 
endmodule
