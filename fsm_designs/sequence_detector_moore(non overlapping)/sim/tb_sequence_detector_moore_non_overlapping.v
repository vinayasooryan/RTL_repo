


module tb_sequence_detector_moore_non_overlapping;


    reg clk;
    reg reset;
    reg in;
    wire out;

    // DUT instantiation
    sequence_detector_moore_non_overlapping DUT (
        .clk(clk),
        .reset(reset),
        .in(in),
        .out(out)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;   // 10ns clock period
    end

    // Test stimulus
    initial begin
        $dumpfile("non_overlap_waveform.vcd");
        $dumpvars(0, tb_sequence_detector_moore_non_overlapping);

        // Reset
        reset = 1; 
        in = 0;
        #12 reset = 0;

        // TEST SEQUENCE: 1 0 1 0 1 0
        // For NON-overlapping, only ONE detection should happen.
        send_bit(1);
        send_bit(0);
        send_bit(1);
        send_bit(0);  // detect here (out=1)
        send_bit(1);
        send_bit(0);  // NO detect here (non-overlap)

        // Now give a fresh full pattern
        #10;
        send_bit(1);
        send_bit(0);
        send_bit(1);
        send_bit(0);  // second detection here

        #50 $finish;
    end

    // Verilog task to apply one bit per clock cycle
    task send_bit;
        input value;
    begin
        in = value;
        #10;     // wait 1 clock cycle
    end
    endtask

endmodule



