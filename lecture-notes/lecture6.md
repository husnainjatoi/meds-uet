# Lecture 6: Timing & Verification II

## Combinational Circuit Timing
- Outputs are delayed and transitions are gradual.
- Sources of Delay:
  - Capacitance and Resistance (RC Delay): Transistors act as resistors when on, and wires/components have parasitic capacitance.
  - Physical Factors: Speed of light limits signal propagation. Temperature, supply voltage, implementation style, and aging all affect delays.
  - Input Characteristics: Different input transitions (0->1 vs. 1->0) have different latencies.

## Delay Definitions
- Contamination Delay: The minimum amount of time after an input changes until the output *starts* to change (becomes unstable).
  - Calculated using the shortest path through the combinational logic.
  - Used conservatively to ensure stability against rapid consecutive changes.
- Propagation Delay: The maximum amount of time after an input changes until the output *finishes* changing (becomes stable).
  - Calculated using the critical path (longest path) through the logic.
  - Determines the maximum operational speed of the circuit.

## Glitches
- A brief, unintended spike or drop.
- Cause: Occurs when an input drives the output through multiple paths with different delays (e.g., a fast path and a slow path).
- Impact: Glitches consume unnecessary dynamic power but eventually settle to the correct steady-state value.
- Fixing Glitches: Can be prevented by adding redundant logic gates. In most sequential designs, glitches are safely ignored if they settle before the clock edge.

## Sequential Circuit Timing constraints
- Data input to a flip-flop must be completely stable around the active clock edge.
- Setup Time: The time before the clock edge that data must be stable.
  - Fix: If the combinational logic is too slow (violates setup time), you can easily fix it by reducing the clock frequency (increasing $T_{cycle}$).
- Hold Time: The time after the clock edge that data must remain stable.
  - Violation Fix: If the combinational logic is too fast (violates hold time). The designer must artificially increase the delay of the shortest path (e.g., by adding buffers).

## Clock Skew
- Definition: The time difference between clock edges arriving at different flip-flops across the chip due to physical routing delays in the clock network.
- Impact:
  - Increases the effective setup time.
  - Increases the effective hold time.
- Result: Decreases the useful work done per cycle (sequencing overhead). Requires intelligent clock routing networks (e.g., H-trees) to minimize skew.

## Circuit Verification
- Verifying a large design takes up to 70% of the total design time.
- Testbenches: A Verilog module written specifically to test a Device Under Test (DUT).
  - Simple: Manually input vectors, manually check output waveforms. (Error-prone, unscalable).
  - Self-Checking: Hardcode input vectors and expected outputs in the testbench.
  - Test Vector Files: Read inputs and expected outputs from an external file on simulated clock edges.
  - Automatic Testbench (Golden Model): Compares the DUT's output against a "Golden Model" (a highly abstract, known-bug-free model written in C/C++ or high-level Verilog). Highly scalable and automated.
- Post-Synthesis Timing Simulation: Tools like Vivado synthesize the HDL into real logic gate models with annotated worst-case delays (min, typical, max) to simulate and catch real-world timing violations.
