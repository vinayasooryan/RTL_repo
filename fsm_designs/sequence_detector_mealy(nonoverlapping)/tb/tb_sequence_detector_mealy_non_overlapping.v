`timescale 1ns/1ps

module tb_sequence_detector_mealy_non_overlapping;

    reg clk;
    reg reset;
    reg in;
    wire out;

    // DUT instantiation
    sequence_detector_mealy_non_overlapping DUT (
        .clk(clk),
        .reset(reset),
        .in(in),
        .out(out)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;   // 10ns clock
    end

    // Test sequence
    initial begin
        $dumpfile("mealy_nonoverlap_waveform.vcd");
        $dumpvars(0, tb_sequence_detector_mealy_non_overlapping);

        reset = 1; in = 0;
        #12 reset = 0;

        // Sequence: 1 0 1 0 1 0 (non-overlapping ? only one detection)
        send_bit(1);
        send_bit(0);
        send_bit(1);
        send_bit(0);  // detect here (out = 1)
        send_bit(1);
        send_bit(0);  // NO detection here (non-overlapping)

        // New pattern (fresh detection)
        #10;
        send_bit(1);
        send_bit(0);
        send_bit(1);
        send_bit(0);  // detect again

        #50 $finish;
    end

    // Task to send one bit per cycle
    task send_bit;
        input value;
    begin
        in = value;
        #10;
    end
    endtask

endmodule
