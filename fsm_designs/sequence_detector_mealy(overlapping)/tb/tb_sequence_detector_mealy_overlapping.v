

`timescale 1ns/1ps

module tb_sequence_detector_mealy_overlapping;

    reg clk;
    reg reset;
    reg in;
    wire out;

    // DUT instantiation
    sequence_detector_mealy_overlapping DUT (
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
        $dumpfile("mealy_overlap_waveform.vcd");
        $dumpvars(0, tb_sequence_detector_mealy_overlapping);

        reset = 1; in = 0;
        #12 reset = 0;

        // Sequence: 1 0 1 0 1 0 (Mealy detects twice)
        send_bit(1);
        send_bit(0);
        send_bit(1);
        send_bit(0);  // detect (Mealy output = 1 here)
        send_bit(1);
        send_bit(0);  // detect again (overlap)

        // More cases
        #10;
        send_bit(1);
        send_bit(1);
        send_bit(0);
        send_bit(1);
        send_bit(0);

        #50 $finish;
    end

    // Task to send bits
    task send_bit;
        input value;
    begin
        in = value;
        #10;    // One clk cycle
    end
    endtask

endmodule
