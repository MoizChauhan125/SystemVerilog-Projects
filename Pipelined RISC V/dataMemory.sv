`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/28/2025 03:44:41 PM
// Design Name: 
// Module Name: dataMemory
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


module dataMemory(
    output logic [31:0] memData,
    input logic [31:0] aluOut, data2,
    input logic [2:0] func3,
    input logic memRead, memWrite, clk
    );
    
    logic [9:0] addr; //10bit address for 1KByte memory, 32bit addressing would give 4GB Memory
    logic [7:0] mem [0:1023]; //1 Kbytes memory(1024 locations), 32bit can access total 4GB of memory  
    
    assign addr[9:0] = aluOut[9:0]; //reducing the address bits to address not more than 1KB
    
    integer i;
    initial begin
        for (i = 0; i < 1024; i = i + 1) begin
            mem[i] = 8'h00;   // initialize all memory locations to zero
        end
    end
    
    always@(posedge clk)begin
        if((func3 == 3'b010) && (memWrite == 1'b1) && (memRead == 1'b0) && (addr[1:0] == 2'b00)) //store word when addr is multiple of (4) {0, 4, 8, 12} 
            {mem[addr + 3], mem[addr + 2], mem[addr + 1], mem[addr]} <= data2;
       
        else if((func3 == 3'b001) && (memWrite == 1'b1) && (memRead == 1'b0) &&  (addr[0] == 1'b0)) //store halfword when addr is multiple of (2) {0, 2, 4, 6, 8}
            {mem[addr + 1], mem[addr]} <= data2[15:0];
        
        else if((func3 == 3'b000) && (memWrite == 1'b1) && (memRead == 1'b0)) //store byte
            mem[addr] <= data2[7:0];
        
        else
            mem[addr] <= mem[addr]; //do nothing
    end
    
    always@(*)begin
        if((func3 == 3'b010) && (memWrite == 1'b0) && (memRead == 1'b1) &&  (addr[1:0] == 2'b00)) //load word
            memData = {mem[addr + 3], mem[addr + 2], mem[addr + 1], mem[addr]}; 
            
        else if((func3 == 3'b001) && (memWrite == 1'b0) && (memRead == 1'b1) && (addr[0] == 1'b0)) //load halfword signed
            memData = {{16{mem[addr + 1][7]}}, mem[addr + 1], mem[addr]}; //extend the MSB sign
        
        else if((func3 == 3'b000) && (memWrite == 1'b0) && (memRead == 1'b1)) //load byte signed
            memData = {{24{mem[addr][7]}}, mem[addr]}; //extend the MSB sign
        
        else if((func3 == 3'b101) && (memWrite == 1'b0) && (memRead == 1'b1) && (addr[0] == 1'b0)) //load halfbyte unsigned
            memData = {{16{1'b0}}, mem[addr + 1], mem[addr]}; //extend zeros
        
        else if((func3 == 3'b100) && (memWrite == 1'b0) && (memRead == 1'b1)) //load byte unsigned
            memData = {{24{1'b0}}, mem[addr]}; //extend zeros
        
        else 
            memData = 32'h00000000;
    end
    
    
endmodule