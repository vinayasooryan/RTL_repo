`timescale 1ns / 1ps

module Data_Memory(clk, rst, WE, WD, A, RD);

    input clk, rst, WE;
    input [31:0] A, WD;
    output [31:0] RD;

    reg [31:0] mem [1023:0];
    integer i;

    // Write operation
    always @(posedge clk) begin
        if (rst) begin
            if (WE)
                mem[A[31:2]] <= WD;  // Word-aligned addressing
        end
    end

    // Read operation
    assign RD = (rst == 1'b0) ? 32'd0 : mem[A[31:2]];

    // Initialize all memory locations to 0
    initial begin
        for (i = 0; i < 1024; i = i + 1)
            mem[i] = 32'h00000000;

        // Optional: preload specific memory data
        // $readmemh("data_mem.hex", mem);
    end

endmodule
