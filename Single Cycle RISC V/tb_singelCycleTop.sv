`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Create Date: 08/29/2025 04:24:52 PM
// Design Name: Single Cycle RISC V
// Module Name: tb_singleCycleTop
// Project Name: Single Cycle RISC V
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_singleCycleTop;

    logic clk, rst;
    // Temporary word array for instructions
    logic [31:0] temp_mem [21:0];  

    // Instantiate DUT
    singleCycleTop uut(
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
        for (int i = 0; i < 22; i++) begin
            uut.IM.instructionMem[i*4 + 0] = temp_mem[i][7:0];    // lowest byte
            uut.IM.instructionMem[i*4 + 1] = temp_mem[i][15:8];
            uut.IM.instructionMem[i*4 + 2] = temp_mem[i][23:16];
            uut.IM.instructionMem[i*4 + 3] = temp_mem[i][31:24];  // highest byte
        end
    end


    // Simulation runtime
    initial begin
        $monitor("Time=%0t | PC=%h | instr=%h | ALUout=%h",
                 $time, uut.PC, uut.instr, uut.dataW);

        #200 $finish;
    end

endmodule
