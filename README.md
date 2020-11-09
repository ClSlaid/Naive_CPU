# Naïve_CPU
A simple CPU designing task of BUPT CES.

## Introduction
BUPT Communication Engineer School offers experimental CPU development kits based on *Altera Cyclone 4* FPGAs for its students.
> however the kit only support at most 16-bits CPU development, that's why I adjusted many instructions.
I'm planning to develop a 16-bits RISC CPU in *System Verilog*, the instruction set mainly based on adjusting MIPS-32 instructions.

## Instruction Set
- RR-type

  | 15~10  | 9~6  | 5~2  |
  | ------ | ---- | ---- |
  | opcode | rd   | rs   |

- RI-type

  | 15~10  | 9~6  | 5~0  |
  | ------ | ---- | ---- |
  | opcode | rd   | imm6 |

- R-type

  | 15~10  | 9~6  |
  | ------ | ---- |
  | opcode | rd   |

  

## Special Thanks
- @name1e5s