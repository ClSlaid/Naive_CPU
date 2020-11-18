// defines.sv
// defines is here

// --------------------Global defines------------------------
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
`define EXE_ORI			6'b001101	// Instruction ORI; Known as:	ORI rd imm;
`define EXE_NOP			6'b000000	// Instruction NOP; Known as Doing Nothing;

// Alu Operations
`define EXE_OR_OP			8'b00100101
`define EXE_NOP_OP		8'b00000000

// AluSel
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
