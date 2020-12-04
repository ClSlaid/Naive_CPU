// defines.sv
// defines is here

// --------------------Global defines------------------------
`define Step                16'h1        // single step of pc
`define ZeroWord			16'h0000		// Zero Word in 16 bits

`define RstEnable			1'b1			// rst signal enabled
`define RstDisable		1'b0			// rst signal disabled

`define WriteEnable		1'b1			// Write signal enabled
`define WriteDisable 	1'b0			// Write signal disabled

`define ReadEnable		1'b1			// Read signal enabled
`define ReadDisable		1'b0			// Read signal disabled

`define InstValid			1'b0			// Instruction is valid
`define InstInvalid		1'b1			// Instruction is invalid

`define True_v				1'b1			// Logical True
`define False_v			1'b0			// Logical False

`define AluOpBus			7:0			// width of ALU sub operation code
`define AluSelBus			2:0			// width of ALU operation code

`define ChipEnable		1'b1			// Chip is enabled
`define ChipDisable		1'b0			// Chip is disabled


// -------------------Instruction defines--------------------
// -----------Logic---------
`define EXE_NOP			6'b000000	// Instruction NOP; Known as Doing Nothing;

`define EXE_OR          6'b100101   // Instruction OR; Known as: OR rd rs;
`define EXE_ORI			6'b001101	// Instruction ORI; Known as:	ORI rd imm;

`define EXE_AND         6'b100100   // Instruction AND; Known as: AND rd rs;
`define EXE_ANDI        6'b001100   // Instruction ANDI; Known as: ANDI rd imm;

`define EXE_XOR         6'b100110   // Instruction XOR; Known as: XOR rd rs;
`define EXE_XORI        6'b001110   // Instruction XORI; Known as: XORI rd imm;

`define EXE_NOR         6'b100111
// -----------load---------
`define EXE_LI         6'b001111   // Instruction LUI; Known as: LUI rd imm;
// -----------positional---------
`define EXE_SLL         6'b000000   // Instruction SLL; Know as: SLL rd rs;
`define EXE_SRL         6'b000001   // Instruction SRL; Known as: SRL rd rs;
`define EXE_SLLI        6'b000010   // Instruction SLLI; Known as: SLLI rd imm;
`define EXE_SRLI        6'b000011   // Instruction SRLI; Known as: SRLI rd imm;

// Alu Operations
`define EXE_AND_OP          8'b00100100
`define EXE_OR_OP			8'b00100101
`define EXE_XOR_OP          8'b00100110
`define EXE_NOR_OP          8'b00100111

`define EXE_NOP_OP		8'b00000000

`define EXE_SLL_OP	    8'b00000000
`define EXE_SRL_OP	    8'b00000001
// AluSel
`define EXE_RES_SHIFT   3'b010
`define EXE_RES_LOGIC	3'b001
`define EXE_RES_NOP		3'b000


// -------------------Rom Defines----------------------------
// maybe use less for Cyclone 4 ...?
`define InstAddrBus		15:0			// ROM Address Bus Width
`define InstBus			15:0			// ROM Data Bus width

`define InstMemNum		65535			// ROM Actual Size
`define InstMemNumLog2	16				// Actual ROM Address Bus Width


//--------------------Register Defines------------------------
`define RegAddrBus		3:0			// Regfile Address Bus width (16 register used)
`define RegBus				15:0			// Regfile Data Bus width
`define RegWidth			16				// Regfile data size

`define DoubleRegWidth	32				// Double size of regfile
`define DoubleRegBus		31:0			// Double width of Data Bus

`define RegNum				16				// Number of registers
`define RegNumLog2		4				// Actual Regfile Address Bus width

`define NOPRegAddr		4'b0000
