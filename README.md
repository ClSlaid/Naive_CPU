# Naïve_CPU
A simple CPU designing task of BUPT CES.

Mainly based on *自己动手写CPU* *(Develop CPU by Youself)* by Silei Lei, ISBN-978-7-121-23950-2.

## Introduction
BUPT Communication Engineer School offers experimental CPU development kits based on *Altera Cyclone 4* FPGAs for its students.
> however the kit only support at most 16-bits CPU development, that's why I adjusted many instructions.
I'm planning to develop a simple 16-bits RISC CPU in *System Verilog*, the instruction set mainly based on adjusting MIPS-32 instructions.

The purpose of developing this respository is to:
- Learn about basic architecture of CPU.
- Practice `VerilogHDL`.
- Learn about `GitHub` and `Git`.
Is not to:
- Develop a CPU that could be used in reality.

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
- [@name1e5s](https://github.com/name1e5s)
Really gave me a lot of courage by finishing [MIPS-Edu](https://github.com/name1e5s/MIPS-Edu) within 2 days.