# Lecture 5: HDL, Verilog II, Timing & Verification

## Verilog Modeling Styles
1. Structural (Gate-Level) Modeling:
   - Defines a module by instantiating sub-modules, primitives (like `and`, `or`, `not`), and defining the explicit wiring between them.
   - Example primitive instantiation format: (e.g., `and G1 (Y, A, B);`).
2. Behavioral Modeling:
   - Uses functional and mathematical descriptions (equations, `if-else` blocks, `case` statements) rather than physical gate connections.
   - Utilizes keywords like `assign` for continuous assignments.
   - Synthesizers translate this high-level logic into gate-level structures automatically.

## Bit Manipulation and Operators in Verilog
- Bit Slicing: Assigning specific portions of a larger bus to a smaller bus (e.g., `assign short_bus = long_bus[12:5];`).
- Concatenation: Combining multiple signals into a larger bit vector using (e.g., `assign Y = {A2, A1, A0, A0};`).
- Duplication: Replicating a signal multiple times within a vector using (e.g., `assign X = {4{A0}};`).
- Reduction Operators: Condensing an entire bit vector into a single bit output using a specific logic operation (e.g., `assign Y = &A;` ANDs all bits of vector A together).
- Conditional Assignment: Functions like a ternary operator/multiplexer (e.g., `assign Y = S ? D1 : D0;`).

## Expressing Numbers
- Format: `<size>'<base><value>`
- **Size:** Number of bits. (Default is 32 bits if unspecified).
- **Base:** `b` (binary), `h` (hexadecimal), `d` (decimal), `o` (octal).
- **Value:** The numerical value. Can include `x` (invalid/don't care) or `z` (floating/high impedance).
- Example: `8'b1001` evaluates to `00001001` (padded with leading zeros).

## Defining Sequential Logic in Verilog
- Combinational logic concepts are insufficient to describe memory elements like latches and flip-flops, as those depend heavily on clock latency and edge triggers.
- **The `always` Block:**
  - Used heavily to model sequential logic. 
  - Triggers execution when signals in its **sensitivity list** change state.
  - Syntax: `always @(posedge clk or negedge reset) begin ... end`.
  - **Memory Inference:** The synthesizer infers a latch or flip-flop if the output is not fully defined across all possible input conditions.
  - **Registers (`reg`):** Any variable assigned a value *inside* an `always` block must be declared as a `reg`.

## Blocking vs. Non-Blocking Assignments
- **Blocking (`=`):**
  - Evaluates and assigns sequentially.
  - Used mostly for complicated combinational logic within an `always` block.
- **Non-Blocking (`<=`):**
  - Evaluates all right-hand expressions first, then updates all left-hand variables concurrently at the end of the block.

## Finite State Machines (FSMs) in Verilog
- Typically broken down into three distinct blocks (often implemented as a mix of `always` and `assign` blocks):
  1. **State Register:** A synchronous `always` block (triggered by `posedge clk`) that updates the current state to the next state, and handles resets.
  2. **Next State Logic:** A combinational `always @(*)` block utilizing `case` statements to calculate the next state. A `default` case is vital to handle unused encodings to prevent hardware lockup or unintended latches.
  3. **Output Logic:** Typically an `assign` statement or combinational `always` block that determines the output based on the current state (Moore) or current state + inputs (Mealy).
