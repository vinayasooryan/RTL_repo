This project implements a Mealy Finite State Machine (FSM) to detect the binary sequence:

1010


The detector is overlapping, meaning it can detect new occurrences inside previous ones (e.g., detecting twice in 101010).
Because it is Mealy, the output depends on both current state + input, so the output is generated immediately — without waiting for a clock edge.

🔥 Key Features

Mealy Machine → Output depends on (state + input)

Overlapping Detector → Sliding-window pattern detection

Immediate Output → Detection happens in the same cycle

Only 4 States Used → More efficient than Moore FSM

Fully synthesizable Verilog

🧠 FSM State Definitions
State	Meaning
S0	No match yet
S1	Matched 1
S2	Matched 10
S3	Matched 101

Detection occurs on:
S3 with input = 0 → completes 1010

🔄 State Transition Table
S0
Input	Next State
0	S0
1	S1
S1
Input	Next State
0	S2
1	S1
S2
Input	Next State
0	S0
1	S3
S3
Input	Next State	Output
1	S1	0
0	S2	1

➡ Output = 1 happens on the transition from S3 when input is 0

⚡ Why the Output Changes Without a Clock Edge

Mealy outputs are combinational.
In this design:

assign out = (current == S3) && (~in);


This means:

the moment current == S3

AND in == 0
→ output becomes 1 immediately, without waiting for the next clock edge.

✔ This is expected Mealy behavior
✔ This is why Mealy FSMs detect patterns earlier than Moore
✔ This is why your waveform shows output going high instantly

This is the main difference from Moore FSM, where output only changes after the state registers update on a clock edge.

📊 Waveform Behavior

Example input:

1 0 1 0 1 0


Output for Mealy (overlapping):

0 0 0 1 0 1
          ↑   ↑
       detect detect


Notice:
Output becomes 1 exactly when final input = 0 arrives,
even before the next rising clock edge → Mealy’s immediate response.

🧪 Testbench

File:
tb_sequence_detector_mealy_overlapping.v

Features:

Clock generator

Reset logic

Reusable send_bit task

VCD waveform dumping

Overlapping detection test cases

Run using Icarus Verilog:

iverilog -o sim tb_sequence_detector_mealy_overlapping.v sequence_detector_mealy_overlapping.v
vvp sim
gtkwave mealy_overlap_waveform.vcd

📁 File List
sequence_detector_mealy_overlapping.v
tb_sequence_detector_mealy_overlapping.v
mealy_overlap_waveform.vcd
README.md

🧩 Understanding the Leftover Match (Why S3→S2 on detection)

When detecting:

1010


The longest remaining suffix that matches a prefix of the pattern is:

10


That corresponds to state S2, allowing overlapping detection.

This is why Mealy transition for detection is:

S3 --(0)--> S2   with out = 1

👤 Author

Vinayasooryan — RTL Design Engineer (Fresher/Intern Track)
Part of a complete FSM mastery series (Moore / Mealy, overlapping & non-overlapping)