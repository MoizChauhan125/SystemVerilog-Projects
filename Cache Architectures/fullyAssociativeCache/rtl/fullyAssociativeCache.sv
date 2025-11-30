`timescale 1ns / 1ps

module fullyAssociativeCache(
    input  logic            clk,
    input  logic            rst_n,
    input  logic [15: 0]    addr_in,       // connect to physical_address[pa_pointer]
    output logic            hit_out,
    output logic [31: 0]    data_out
);
    
    logic [140:0] cache [0:255];

    // decode address  
    logic [11: 0] tag;
    logic [1: 0]  word_offset;

    always_comb begin
        tag         = addr_in[15:4];
        word_offset = ~addr_in[3:2];
    end

    integer i;
    
    always_comb begin
        hit_out  = 1'b0;
        data_out = 32'b0;
        for (i = 0; i < 256; i = i + 1) begin
            if (cache[i][140] && (cache[i][139:128] == tag)) begin
                hit_out  = 1'b1;
                data_out = cache[i][32 * word_offset +: 32];
                break;  // stop search after hit
            end
        end
    end
endmodule
