1010 Sequence Detector — Non-Overlapping Moore FSM

This project implements a 1010 sequence detector using a
Non-overlapping Moore Finite State Machine (FSM) in Verilog.

The detector outputs HIGH (1) for one clock cycle
only when the sequence 1010 is detected, and does not allow overlapping matches.

🔍 Non-overlapping Behavior Explained

Given this input bitstream:

1 0 1 0 1 0


A normal overlapping detector would detect twice
(at positions 4 and 6).

But non-overlapping means:

Once a match is found (1010)

The FSM resets to S0

Matching restarts fresh

The next 10 inside the previous pattern cannot be reused

So output becomes:

0 0 0 1 0 0


Only ONE detection.

🧠 FSM States
State	Meaning
S0	No match yet
S1	Matched 1
S2	Matched 10
S3	Matched 101
S4	Matched 1010 → output = 1
⭐ Key difference

Unlike overlapping detectors, here:

S4 → S0   (on ANY input)


This ensures non-overlapping behavior.

🧪 Testbench

File: tb_sequence_detector_moore_non_overlapping.v

Features:

Clock generator

Synchronous reset

Task-based bit driving

VCD dump (non_overlap_waveform.vcd)

Demonstrates that only one detection happens on 101010

To run using Icarus Verilog:

iverilog -o sim tb_sequence_detector_moore_non_overlapping.v sequence_detector_moore_non_overlapping.v
vvp sim
gtkwave non_overlap_waveform.vcd

📦 Output Example
Input:   1 0 1 0 1 0
State:   S1 S2 S3 S4 S0 S0
Output:  0 0 0 1 0 0

👤 Author

Vinayasooryan — RTL Design Engineer (Intern/Fresher Track)
Part of a full FSM mastery series (Moore + Mealy, overlapping + non-overlapping)