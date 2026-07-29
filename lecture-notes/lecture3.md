## Lecture 3: Sequential Logic

### Logical Completeness
- A set of gates is **logically complete** if it can implement any truth table.
- {AND, OR, NOT} is logically complete.
- NAND by itself is logically complete.
- NOR by itself is logically complete.

### Combinational Blocks
#### Equality Checker (Comparator)
- Checks if two n-bit values are exactly the same.
- Built using XNOR gates for bitwise comparison (outputs 1 if bits match).
- An n-input AND gate evaluates the final equality (evaluates to 1 only if all bits are equal).

#### Arithmetic Logic Unit (ALU)
- Combines arithmetic (Addition, Subtraction) and logic (AND, OR) operations into a single execution module.
- Performs one function at a time, dictated by a multi-bit function input.
- Uses internal decoders and multiplexers to execute and route the selected operation to the output.

#### Tri-State Buffers
- Acts as a switch to control data flow onto shared wires.
- **States:**
  1. Enable = 1: Switch is closed. Output driven by the input value.
  2. Enable = 0: Switch is open. Output is *floating*.
- **Shared Bus Application:** Allows multiple components (e.g., CPU, Memory, Ethernet) to connect to a single shared bus. Control logic ensures only one component's tri-state buffer is enabled at any given time to prevent short circuits and collisions.
- Can also be used to build efficient multiplexers.

### Logic Simplification and Automation
- EDA tools automate logic simplification to optimize latency, area, and power.
- Uniting Theorem: If changing a variable's value does not change the function's output, that variable can be eliminated.
- Don't Cares (X): Used in truth tables to indicate that an input's value does not affect the output. Simplifies boolean expressions heavily (e.g., used to simplify Priority Circuits).

### Introduction to Sequential Logic
- **Combinational Logic:** Output depends *only* on current inputs.
- **Sequential Logic:** Output depends on current inputs AND past inputs. Contains memory/storage elements.

### Storage Elements
#### Cross-Coupled Inverters
- The most basic storage element. Two inverters wired in a loop.
- Has two stable states (storing a 0 or a 1) and one unstable (metastable) state.
- Problem: Cannot be explicitly set or rewritten because there is no control mechanism. Used internally in fast, expensive SRAM caches.

#### SR Latch
- Built using two cross-coupled NAND gates.
- States:
  - `S=1, R=1`: Quiescent state. Holds previous value ($Q = Q_{prev}$).
  - `S=0, R=1`: Sets Q to 1.
  - `S=1, R=0`: Resets Q to 0.
  - `S=0, R=0`: Forbidden State. Violates the fundamental rule that Q and Q` must be complements, and transitioning out of it can cause prolonged oscillation (metastability).

#### Gated D Latch
- Solves the SR Latch's forbidden state issue.
- Introduces a **Write Enable (WE)** and a **Data (D)** input.
- Uses extra NAND gates to guarantee S and R are never 0 at the same time.
- If `WE=1`: Q gets the value of D (it becomes "transparent").
- If `WE=0`: Q holds its previous value securely.

#### Registers and Memory Arrays
- Register: Multiple Gated D latches placed in parallel (sharing a single Write Enable) to store multi-bit values simultaneously.
- Memory Array: Built using multiple registers.
  - Address Space: The unique locations in memory. **Addressability:** The number of bits stored per location.
  - Address Decoder: Selects which register to read from or write to based on the provided address bits.
  - Multiplexer: Routes the selected register's data to the memory output.

### Finite State Machines (FSMs) and The Clock
- A discrete-time model of a stateful system.
- Consists of: Finite states, external inputs, external outputs, explicit state transitions, and output generation logic.
- Built using a **State Register** (sequential), **Next State Logic** (combinational), and **Output Logic** (combinational).
- **Asynchronous vs. Synchronous:**
  - Asynchronous: Transitions happen whenever inputs change (prone to race conditions and bugs).
  - Synchronous: State transitions are synchronized globally by a **Clock** signal.

### Edge-Triggered State Elements
- The Problem with Latches in FSMs: A D-Latch is *level-triggered*. If the clock is high, the output continuously tracks the input. This causes uncontrolled feedback loops in state machines, as the state would change randomly during a single cycle.
- D Flip-Flop:
  - Created by cascading two D Latches in a Master-Slave configuration with inverted clock inputs.
  - Edge-Triggered: Samples the input D *only* at the rising edge of the clock.
  - Provides a stable output throughout the entire clock cycle, making it the essential storage element for State Registers in modern synchronous hardware.
