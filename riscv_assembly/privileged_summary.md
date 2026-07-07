# Technical Summary: RISC-V Privileged Architecture (Sections 3.1–3.4)

## 1. Overview of Machine-Mode (M-Mode)
* **Definition and Privilege**: Machine-mode (M-mode) is the highest privilege mode in a RISC-V system and is the first mode entered upon a power-on reset.
* **Hardware Necessity**: It provides low-level access to the underlying hardware platform and stands as the only mandatory privilege mode required in a RISC-V hardware implementation.
* **Software Emulation**: M-mode can be utilized to implement architectural features in software that are otherwise too complex or expensive to implement directly in hardware.

## 2. Key Machine-Level Control and Status Registers (CSRs)
* **`mcpuid` (CPU ID Register)**: An XLEN-bit read-only register that exposes a rudimentary catalog of CPU capabilities. Its Base field denotes the native integer ISA width (e.g., RV32I, RV64I), while the Extensions field utilizes a single bit per letter of the alphabet to flag supported ISA extensions and privilege modes.
* **`mimpid` (Implementation ID Register)**: Provides a unique encoding reflecting the source and microarchitectural version of the processor design. Its 16-bit Source field distinguishes open-source repositories from proprietary/closed-source implementations.
* **`mhartid` (Hart ID Register)**: A mandatory read-only register holding the integer ID of the hardware thread (hart) currently running the execution code, where at least one core must contain a hart ID of zero.
* **`mstatus` (Machine Status Register)**: Tracks and controls the active operational state of the hart. It contains fields for managing memory privilege (`MPRV`), extensions status (`FS`/`XS` for floating-point and user extensions), and virtualization modes (`VM[4:0]`). Critically, it maintains a two-bit privilege (`PRV`) and global interrupt-enable (`IE`) stack to handle nested traps safely.
* **`mtvec` (Machine Trap Vector Base Address Register)**: Holds the 4-byte aligned base address used for M-mode trap vectors. Traps occurring at privilege level P force an automatic hardware jump to the calculated address of mtvec + P × 0x40.
* **`mtdeleg` (Machine Trap Delegation Register)**: Controls whether specific synchronous exceptions or asynchronous interrupts bypass M-mode entirely and are routed directly to a lower privilege level's handler to improve performance.
* **`mip` and `mie` (Interrupt Registers)**: `mip` is a read/write register tracking pending interrupts, while `mie` holds the corresponding interrupt-enable bits. They feature specific bit positions dedicated to software, timer, and external interrupts for each supported privilege tier.
* **`mtime` and `mtimecmp` (Timer Registers)**: Provide a standardized wall-clock real-time counter (`mtime`) and a comparison register (`mtimecmp`) running at a constant frequency to trigger precise timer interrupts when a match occurs.
* **`mscratch` (Machine Scratch Register)**: A dedicated space for M-mode software routines, typically utilized to cache a pointer to a hart-local context block, allowing quick state swaps immediately upon entering a trap handler.
* **`mepc` (Machine Exception Program Counter)**: Automatically captures the virtual address of the instruction that encountered a trap or exception, ensuring its low bits strictly obey instruction alignment boundaries.
* **`mcause` (Machine Cause Register)**: Contains an Interrupt bit and an Exception Code field that explicitly diagnose the exact catalyst behind the last recorded hardware trap.
* **`mbadaddr` (Machine Bad Address Register)**: Captures the precise faulting address whenever an instruction-fetch, load, or store triggers an address-misaligned or memory access exception.

## 3. Machine-Mode Privileged Instructions
* **`ECALL` and `EBREAK`**: `ECALL` triggers an environment call exception to request services from a higher privilege level, while `EBREAK` transfers control to a debugging environment by generating a breakpoint exception.
* **`ERET` (Environment Return)**: Used to exit a trap handler, pop the `mstatus` privilege stack back to its previous state, and restore the program counter to the address saved inside the `mepc` register.
* **`MRTS` and `MRTH`**: Specialized redirection instructions that allow an M-mode handler to swiftly forward trap execution states down to supervisor (`stvec`) or hypervisor (`htvec`) software spaces.
* **`WFI` (Wait for Interrupt)**: Provides a low-power architectural hint to stall the hart until an active, valid interrupt requires processing.

## 4. Physical Memory Integration
* **Physical Memory Attributes (PMAs)**: System physical address ranges are assigned distinct attributes (such as read/write permissions, coherence, and atomic operation support) that are hardwired or configured in custom hardware to protect memory regions regardless of translation status.
* **Physical Memory Access Control (PMP)**: Employs per-hart control registers to restrict physical memory read, write, and execute permissions for lower-privilege contexts, serving to isolate faults and uphold platform security.
