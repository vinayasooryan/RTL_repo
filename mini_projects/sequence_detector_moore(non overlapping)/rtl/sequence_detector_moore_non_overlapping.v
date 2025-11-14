


module sequence_detector_moore_non_overlapping(
    input  wire clk,
    input  wire reset,
    input  wire in,
    output wire out
);

// 1. State encoding
parameter S0 = 3'b000,
          S1 = 3'b001,
          S2 = 3'b010,
          S3 = 3'b011,
          S4 = 3'b100;

reg [2:0] current, next;

// 2. State register (sequential logic)
always @(posedge clk) begin
    if (reset)
        current <= S0;
    else
        current <= next;
end

// 3. Next-state logic (combinational logic)
always @(*) begin
    case (current)

        S0: begin
            if (in)
                next = S1;
            else
                next = S0;
        end

        S1: begin
            if (in)
                next = S1;
            else
                next = S2;
        end

        S2: begin
            if (in)
                next = S3;
            else
                next = S0;
        end

        S3: begin
            if (in)
                next = S1;
            else
                next = S4;
        end

        S4: begin
            // NON-OVERLAPPING: reset to S0 after detection
            next = S0;
        end

        default: next = S0;

    endcase
end

// 4. Moore output
assign out = (current == S4);

endmodule


