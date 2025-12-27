# Parameterized Synchronous FIFO in SystemVerilog

## Overview
This project implements a **parameterized synchronous FIFO (First-In First-Out) buffer** using **SystemVerilog RTL**.  
The FIFO is designed as a reusable hardware block with configurable **data width** and **depth**, suitable for buffering and rate-matching in synchronous digital systems.

The design was verified using a SystemVerilog testbench and waveform-based simulation.

---

## Features
- Parameterized **DATA_W** (data width) and **DEPTH**
- Single-clock (synchronous) FIFO design
- Circular buffer implementation
- Independent read and write pointers
- Wrap-bit based **full** and **empty** detection
- Supports:
  - Push (write)
  - Pop (read)
  - Simultaneous push and pop
- Handles **non-power-of-two FIFO depths**
- RTL written using synthesizable constructs

---

## FIFO Interface

### Inputs
- `clk` : Clock signal
- `reset` : Active-high synchronous reset
- `push_i` : Write enable signal
- `push_data_i` : Data input to be written into FIFO
- `pop_i` : Read enable signal

### Outputs
- `pop_data_o` : Data output from FIFO
- `full_o` : FIFO full indicator
- `empty_o` : FIFO empty indicator

---

## Parameter Description
| Parameter | Description |
|---------|------------|
| `DATA_W` | Width of each FIFO data word |
| `DEPTH`  | Number of entries in the FIFO |

The FIFO depth and pointer width are automatically adjusted using `$clog2(DEPTH)`.

---

## Design Architecture
- FIFO memory implemented as a register array
- Read and write pointers increment on successful pop/push operations
- Wrap bits are used to distinguish **full** and **empty** conditions when pointers are equal
- Pointer updates are **flopped (registered)** on the rising edge of the clock

---

## Full and Empty Conditions
- **Empty**:  
  Read pointer equals write pointer **and** wrap bits are equal
- **Full**:  
  Read pointer equals write pointer **and** wrap bits are different

This approach allows correct operation even for non-power-of-two FIFO depths.

---

## Verification
- A SystemVerilog testbench is used to:
  - Generate clock and reset
  - Apply push and pop operations
  - Verify correct pointer movement
  - Observe FIFO behavior through waveform analysis
- Simulation performed using **EDA Playground** with Icarus Verilog
- Waveforms generated in VCD format and analyzed using GTKWave

---

## Tools Used
- SystemVerilog (RTL)
- EDA Playground
- Icarus Verilog
- GTKWave

---

## Learning Outcomes
- Practical understanding of FIFO architecture
- Experience with parameterized RTL design
- Clear distinction between combinational and flopped (registered) logic
- Understanding of full/empty detection using pointer wrap logic
- Hands-on experience debugging RTL and simulator-related issues

---

## Notes
This project was developed as part of hands-on learning in RTL design.  
The implementation and verification helped build a strong foundation in synchronous digital design concepts.

---

## Author
Vinayasooryan  
Aspiring RTL / ASIC Design Engineer
