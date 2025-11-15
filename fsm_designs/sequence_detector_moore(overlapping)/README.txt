1010 Sequence Detector – Moore FSM (Verilog)

This project implements a sequence detector that identifies the binary sequence
1010 using a Moore finite state machine (FSM) in Verilog.

The output goes HIGH for one clock cycle every time the sequence 1010 is detected.
This design supports overlapping sequence detection.

Example:
Input stream: 1 0 1 0 1 0
Output goes high at the 4th and 6th bits.

🚀 Features

Pure Verilog (no SystemVerilog)

Overlapping Moore FSM

Clean state encoding using parameters

Synthesizable RTL

Testbench with clock generation + tasks

Waveform dump support (VCD)

🧠 State Diagram

The FSM has 5 states representing the progress of matching the sequence 1010.

State	Meaning
S0	No match yet
S1	Matched 1
S2	Matched 10
S3	Matched 101
S4	Matched 1010 (output = 1)

📝 RTL Code

The complete Verilog implementation is available in sequence_detector_moore.v.

🧪 Testbench

The testbench (tb_sequence_detector_moore.v) includes:

Clock generator

Reset logic

Task-based input driving

VCD waveform dumping

To simulate:

iverilog -o sim tb_sequence_detector_moore.v sequence_detector_moore.v
vvp sim
gtkwave waveform.vcd

📦 Overlapping Behavior Example

Input:

1 0 1 0 1 0


Output:

0 0 0 1 0 1


FSM detects overlapping sequences.

🎯 Applications

Serial bit detectors

Communication protocol pattern checking

Stream parsing logic

Control units in CPUs

Digital signal processing

👤 Author

Vinayasooryan — RTL Design Engineer (Fresher/Intern Track)
Designed for VLSI interview preparation and project portfolio.

⭐ 3. Clean State Transition Diagram (text-friendly)

Here’s the cleanest plain-text version (you can paste this into README too):

              +-------------------------+
              |                         |
              |          in=1           |
              v                         |
            +-----+   in=0   +-----+   | in=1   +-----+
     +----->| S1  |--------->| S2  |----------->| S3  |
     |       +-----+         +-----+            +-----+
     |         ^  |             |                 |
     |         |  |             | in=1            | in=0
     | in=1    |  | in=0        |                 v
   +-----+     |  v             |               +-----+
   | S0  |<----+  S1            +---------------| S4  |
   +-----+             in=0                    +-----+
                  (Moore output state)