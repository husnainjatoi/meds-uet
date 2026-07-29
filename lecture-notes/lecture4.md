# Lecture 4: Sequential Logic II, Labs, Verilog

## Finite State Machine (FSM) Implementation
- Transition Table: It defines the current state, input conditions, and the resulting next state.
- State Encoding: Assigning binary values to represent each state.
  - *Full/Binary Encoding:* Uses the minimum number of bits ($log_2(N)$ bits for N states). 
  - *One-Hot Encoding:* Uses one bit per state. Only one bit is high at any time.
  - *Output Encoding:* Applicable primarily to Moore machines. States are encoded using the desired output bits directly. 
- **FSM Circuit Schematic:** Comprises three parts:
  1. Next State Logic: Combinational logic that calculates the next state.
  2. State Register: Sequential logic that holds the current state and updates it at the clock edge.
  3. Output Logic: Combinational logic that generates the outputs based on the current state (Moore) or current state + inputs (Mealy).

## Moore vs. Mealy FSM Trade-offs
- **Moore Machine:**
  - Output depends *only* on the current state.
  - Usually requires more states than a Mealy machine.
  - Advantage: Outputs are generally more stable and synchronous with the clock. Less prone to glitches because the output logic path is isolated from immediate input changes.
- **Mealy Machine:**
  - Output depends on the current state AND the current inputs.
  - Can often achieve the same behavior with fewer states.
  - Disadvantage: A glitch (short unstable pulse) on the input can propagate directly to the output. Additionally, it creates longer combinational logic paths from input to output, which can hurt timing performance.

## FPGAs (Field Programmable Gate Arrays)
- **Concept:** A software-reconfigurable hardware substrate.
- **Key Components:**
  - Lookup Tables (LUTs): Small programmable memories that can implement any boolean function of N inputs.
  - Switch Boxes/Interconnects: Programmable routing pathways that connect LUTs and other blocks.
  - I/O Blocks: Configurable pins to interface with external components (LEDs, switches, etc.).
- **Advantages:** High performance, high energy efficiency, low development cost compared to ASICs, short time-to-market, and highly flexible/reusable.
- **Disadvantages:** Less power efficient and slower than custom-designed ASICs. The reconfigurability introduces significant area and latency overhead.

## Hardware Description Languages (HDLs) - Verilog
- **Design Paradigms:**
  - Top-Down: Define the top-level module (e.g., CPU), break it into sub-modules (ALU, Control Unit), and continue down to basic primitives.
  - Bottom-Up: Build primitive gates, combine them into basic blocks (adders, multiplexers), and assemble those into complex systems.
- **Verilog Basics:**
  - **Module:** The fundamental building block.
  - Defined using the `module` and `endmodule` keywords.
  - Includes a port list specifying `input` and `output` signals.
  - **Multi-bit Signals:** Defined using ranges, e.g., `input [31:0] a;` creates a 32-bit input vector.
