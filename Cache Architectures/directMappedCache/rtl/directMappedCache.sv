`timescale 1ns / 10ps

module directMappedCache(
    input  logic            clk,
    input  logic            rst_n,
    input  logic [15 : 0]    addr_in,       
// connect to physical_address[pa_pointer]
    
    output logic            hit_out,
    output logic [31 : 0]    data_out
);
    
// decode address 
    logic [3 : 0] tag;
    logic [7 : 0] index;
    logic [1 : 0] word_offset;
    
// data array (256 blocks × 4 words × 32 bits )
// no of bits on a single address = 4 words + 4 bit tag + 1 valid bit = 133 bits
    logic [132 : 0] cache [255 : 0];
    
    always@(*) begin
        tag         =  addr_in[15 : 12];
        index       =  addr_in[11 : 4];
        word_offset = ~addr_in[3 : 2];
    end
    
// On a miss, fill tag & set valid (write-allocate assumed for this task)
    always@(*) begin
            if (cache[index][132] && cache[index][131 : 128] == tag) begin
                data_out  = cache [index] [32 * word_offset +: 32];
                hit_out   = 1'b1;
            end
            
            else begin
                data_out  = 32'b0;
                hit_out   = 1'b0;
            end            
    end
endmodule
