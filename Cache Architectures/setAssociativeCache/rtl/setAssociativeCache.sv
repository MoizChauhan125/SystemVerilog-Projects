`timescale 1ns / 10ps

module setAssociativeCache(
    input  logic            clk,
    input  logic            rst_n,
    input  logic [15: 0]    addr_in,       // connect to physical_address[pa_pointer]
    output logic            hit_out,
    output logic [31: 0]    data_out
);

    // two ways, each entry : {valid(1), tag(6), data(4×32=128)} = 135 bits
    logic [133: 0] cache0 [127: 0];
    logic [133: 0] cache1 [127: 0];

    // decode address
    logic [4:0] tag;
    logic [6:0] index;
    logic [1:0] word_offset;

    always@(*) begin
        tag         =  addr_in[15: 11];
        index       =  addr_in[10: 4];
        word_offset = ~addr_in[ 3: 2];
    end

    // hit logic - check both ways
    always@(*) begin
        if (cache0[index][133] && cache0[index][132:128] == tag) begin
            data_out = cache0[index][32 * word_offset +: 32];
            hit_out = 1'b1;
        end
        else if (cache1[index][133] && cache1[index][132:128] == tag) begin
            data_out = cache1[index][32 * word_offset +: 32];
            hit_out  = 1'b1;
        end
        else begin
            data_out = 32'b0;
            hit_out  = 1'b0;
        end
    end

endmodule
