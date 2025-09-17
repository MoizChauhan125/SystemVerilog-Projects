`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/28/2025 09:24:27 PM
// Design Name: 
// Module Name: tb_lab21
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


`timescale 1ns/1ps

module tb_lab23;

    logic clk, rst;
    // Temporary word array for instructions
    logic [31:0] temp_mem [128:0];  

    // Instantiate DUT
    lab23 uut(
        .clk(clk),
        .rst(rst)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk;

    // Reset
    initial begin
        rst = 1;
        #12 rst = 0;
        #12 rst = 1;
    end

    // Initialize instruction memory from external file
    initial begin
        // Load 32-bit instructions from file
        $readmemh("instructions.mem", temp_mem);

        // Now split into bytes for uut.IM.mem[]
        for (int i = 0; i < 106; i++) begin
                uut.IM.instructionMem[i*4 + 0] = temp_mem[i][7:0];    // lowest byte
                uut.IM.instructionMem[i*4 + 1] = temp_mem[i][15:8];
                uut.IM.instructionMem[i*4 + 2] = temp_mem[i][23:16];
                uut.IM.instructionMem[i*4 + 3] = temp_mem[i][31:24];  // highest byte
        end
    end


    // Simulation runtime
    initial begin
        $monitor("Time=%0t | PC=%h | instr=%h | ALUout=%h",
                 $time, uut.PC_IF, uut.INSTR_IF, uut.DATAW_WB);

        #200 $finish;
    end

endmodule