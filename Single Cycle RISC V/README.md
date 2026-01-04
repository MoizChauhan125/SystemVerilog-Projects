# Implementation of I-Type and R-Type Instructions in RISC-V Design

The processor was first implemented from scratch with I-type and R-type instructions, forming the foundation of the design. These instructions provided the core ALU operations on which later extensions (Load/Store, Jumps, Upper Immediate, Branch) were built.

* **R-Type (register-register) instructions** (`add`, `sub`, `sll`, `slt`, `sltu`, `xor`, `srl`, `sra`, `or`, `and`) use two source registers (`rs1`, `rs2`) read from the register file. The ALU operation is determined by the `funct3` and `funct7` fields, and the 32-bit result is written back to the destination register (`rd`).

* **I-Type (immediate) instructions** (`addi`, `slti`, `sltiu`, `xori`, `ori`, `andi`, `slli`, `srli`, `srai`) use one register operand (`rs1`) and a 12-bit immediate, which is sign-extended to 32 bits (except for shifts, which use the lower 5 bits as the shift amount). A multiplexer selects between the second register operand and the immediate value as the ALU input. The 32-bit ALU result is then written to `rd`.

* The ALU is purely combinational, producing results within the same cycle. The register file is updated synchronously at the end of the cycle, ensuring the result of an instruction is available for the next instruction while it is read combinationally.

* With this baseline in place, the design was later extended to handle memory access, control flow (jumps and branches), and upper-immediate instructions, completing the single-cycle RV32I instruction set.
  
  <img width="877" height="517" alt="Screenshot From 2025-09-08 21-40-31" src="https://github.com/user-attachments/assets/3ed38862-e485-4b5a-9c75-4bb12d266dc0" />

---

# Implementation of Load and Store Instructions in RISC-V Design

* A dedicated Data Memory (DMEM) module was added to support load (`lw`, `lh`, `lhu`, `lb`, `lbu`) and store (`sw`, `sh`, `sb`) instructions.

* The memory is byte-addressable but word-aligned, ensuring proper access and alignment in compliance with the RISC-V specification.

* For `lw` and `sw`, a full 32-bit word is fetched or written in a single cycle.

* For byte (`lb`, `lbu`) and half-word (`lh`, `lhu`) loads, the design extracts the required portion from the 32-bit fetched word and applies appropriate sign-extension or zero-extension as per the instruction.

* Similarly, `sb` and `sh` selectively update the corresponding byte or half-word within the aligned 32-bit memory word, while preserving the unaffected parts.

* The load path is implemented as combinational, allowing register file reads immediately after fetching data from DMEM.

* The store path is synchronous, updating memory contents on the positive clock edge when `MemWrite` is enabled.

  <img width="882" height="446" alt="Screenshot From 2025-09-08 21-42-36" src="https://github.com/user-attachments/assets/7c412eb6-10d8-4a74-931d-d6a0f108b2db" />

---

# Implementation of JAL and JALR Instructions in RISC-V Design

* To support jump and link instructions, the Program Counter (PC) update logic was extended.

* In the case of `jal`, the immediate value (sign-extended and shifted left by one) is added to the current PC to form the new target address. The instruction also writes the return address (PC + 4) into the specified destination register.

* For `jalr`, the target address is computed by adding the sign-extended immediate to the contents of the base register (`rs1`). The least significant bit (LSB) of the target address is forced to zero, ensuring proper alignment. The return address (PC + 4) is similarly stored in the destination register.

* Both instructions redirect the program flow by updating the PC multiplexer to select the computed jump address instead of the sequential PC + 4.

* Hazard-free operation is ensured by writing back the link value and updating the PC in the same cycle.

  <img width="688" height="672" alt="Screenshot From 2025-09-08 21-44-09" src="https://github.com/user-attachments/assets/343f0367-d625-4fac-8dfa-9436311271da" />

---

# Implementation of Upper Immediate and Branch Instructions in RISC-V Design

* Upper immediate instructions (`LUI`, `AUIPC`) are supported by directly placing the 20-bit immediate into the upper portion of the destination register, with `LUI` writing the value as-is and `AUIPC` adding it to the current PC for PC-relative addressing.

* Branch instructions (`BEQ`, `BNE`, `BLT`, `BGE`, `BLTU`, `BGEU`) are handled by performing comparisons between the specified source registers using the ALU. The ALU was enhanced with status flags (Zero, Negative, Overflow, Carry), and branch instructions were evaluated based on these flags to ensure accurate condition checking.

* If the branch condition evaluates to true, the PC is updated with the branch target address computed by adding the sign-extended immediate offset to the current PC. If the condition is false, the PC increments normally to the next sequential instruction.

* Branch target calculation and condition evaluation occur within a single cycle, maintaining consistency and ensuring control flow correctness. The design ensures proper handling of both signed and unsigned comparisons as required by the instruction type.

# Complete RISC-V Single Cycle Architecture Block Diagram
![single_cycle(1)](https://github.com/user-attachments/assets/bd093ba0-33ea-49dc-b37c-43f3883645b8)

![ControlUnit](https://github.com/user-attachments/assets/2b8e810a-7af0-438a-98ec-52b84bc0b2e5)

