# SystemVerilog

This directory contains SystemVerilog design exercises completed during the **Maktab-e-Digital Systems Summer Training Program**.

The exercises cover fundamental digital design concepts, combinational and sequential logic, finite state machines, counters, frequency dividers, FIFO controllers, and verification using SystemVerilog testbenches. Each project is organized into its own directory containing the design source files and corresponding testbenches.

## Repository Structure

```text
systemverilog/
├── custom_sequence_counter/
│   ├── custom_counter.sv
│   └── custom_counter_tb.sv
├── fifo_controller/
│   ├── fifo.sv
│   └── fifo_tb.sv
├── full_adder/
│   ├── adder.sv
│   └── adder_tb.sv
├── leading_zero_counter/
│   ├── lzc.sv
│   └── lzc_tb.sv
├── modulo10_frequency_divider/
│   ├── frequency_div.sv
│   └── frequency_div_tb.sv
├── sv_basics/
│   ├── gates.sv
│   ├── gates_tb.sv
└── sync_counter/
    ├── sync_counter.sv
    └── sync_counter_tb.sv
```

Each project directory contains its own source files, testbench(s), and any accompanying documentation.

## Project Overview

| Project | Description |
|---------|-------------|
| **sv_basics** | Introduction to SystemVerilog syntax through basic combinational logic gates and simulation. |
| **full_adder** | Implementation and verification of half adder and full adder modules. |
| **sync_counter** | Design and verification of a synchronous binary counter. |
| **custom_sequence_counter** | FSM-based counter that follows a custom counting sequence. |
| **leading_zero_counter** | Detects the number of leading zeros in an input vector. |
| **modulo10_frequency_divider** | Clock frequency divider implemented using T flip-flops and modulo-10 counting. |
| **fifo_controller** | Synchronous FIFO controller with accompanying verification testbench. |

## Topics Covered

- SystemVerilog fundamentals
- Combinational logic
- Sequential logic
- Finite State Machines (FSMs)
- Counters and state machines
- Clock division
- FIFO design
- Leading zero detection
- Testbench development
- Functional simulation
- Digital design verification

## Purpose

These projects were developed to:

- Learn hardware design using SystemVerilog.
- Apply digital logic concepts through practical implementations.
- Gain experience writing modular and reusable RTL.
- Practice verification using dedicated SystemVerilog testbenches.
- Build a strong foundation for FPGA and ASIC design workflows.

## Development Environment

- SystemVerilog
- Vivado
- Icarus Verilog (for supported simulations)
- GTKWave (waveform visualization)
- Linux

## Disclaimer

These projects are educational exercises created during the MEDS Summer Training Program and are intended for learning and practice purposes.
