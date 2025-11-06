🧠 RISC-V 32-bit 5-Stage Pipelined Processor (RV32I)

This project is my custom 5-stage pipelined RISC-V (RV32I) processor built completely from scratch using Verilog HDL and simulated in Xilinx Vivado 2023.2.
It implements the full data path and control flow for a simple RISC-V core with hazard handling and forwarding logic.

🧩 Features

✅ 5 classic pipeline stages — Fetch, Decode, Execute, Memory, Writeback

✅ Data forwarding unit (Hazard Unit) for resolving data dependencies

✅ ALU with multiple operations — ADD, SUB, AND, OR, SLT

✅ Instruction and Data memories (initialized using memfile.hex)

✅ Pipeline registers between all stages

✅ Configurable testbench (pipeline_tb.v) with waveform verification

⚙️ Project Architecture
Stage	Description
IF (Fetch)	Fetches instruction and updates PC using PC MUX and Adder
ID (Decode)	Decodes opcode, reads register file, generates control signals
EX (Execute)	Performs ALU operations and calculates branch targets
MEM (Memory)	Accesses data memory for load/store instructions
WB (Writeback)	Writes ALU/memory results back to the register file
🧮 Hazard Handling

The design includes a forwarding unit to solve data hazards between pipeline stages.
It uses two 3x1 multiplexers (ForwardAE, ForwardBE) to select between:

ALU output from the previous cycle

Writeback result

Register file read values

This eliminates the need for stalls in simple dependencies like:

add x5, x0, x3
add x6, x5, x4   // uses result of previous instruction

🧾 Instruction Memory Setup

Instructions are preloaded from a file named memfile.hex, containing machine codes in hexadecimal.
Example contents:

00500293   // addi x5, x0, 5
00300313   // addi x6, x0, 3
006283B3   // add  x7, x5, x6

🔍 Simulation Results

The design was simulated using Vivado’s XSim.
Final waveform shows correct operation and result forwarding:

✅ Waveform Snapshot

At the end of execution, the final register value for x7 = 00000008 (5 + 3).

🛠️ Tools Used

Language: Verilog HDL

IDE: Xilinx Vivado 2023.2

Simulation: XSim Behavioral Simulation

Target ISA: RISC-V RV32I

🚀 Future Work

Implement Load-Use Hazard Stall Unit

Add Branch Prediction

Expand to support RV32M (Multiply/Divide) instructions

Synthesize on an FPGA board (Artix-7)

👨‍💻 Author

Vinayasooryan
🔗 Aspiring VLSI Design Engineer
💡 Passionate about Digital Design,RTL & Hardware Architecture
📍 Trivandrum, Kerala, India