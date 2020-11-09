// id_decoder.sv
// decode instructions
`timescale 1ns/1ps
module id_decoder(
	input logic							rst,			// reset
	// combinational logic, no clock needed
	
	// value from Instruction Fetch
	input logic [`InstAddrBus]		if_pc,		// PC value from Instruction Fetch
	input logic [`InstBus]			if_inst,		// instruction from Instruction Fetch
	
	//	value from Registers
	input logic [`RegBus]			reg1_data_in,	// data from register read port 1
	input logic [`RegBus]			reg2_data_in,	// data from register read port 2
	
	// operation to RegFile
	output logic						reg1_read,		// register read port 1 enable
	output logic						reg2_read,		//	register read port 2 enable
	
	output logic[`RegAddrBus]		reg1_read_addr,// register read port 1 address
	output logic[`RegAddrBus]		reg2_read_addr,// register read port 2 address
	
	// operation to EXecute phase
	output logic[`AluOpBus]			aluop,			// ALU Operation sub code
	output logic[`AluSelBus]		alusel,			// ALU Operation code
	
	output logic[`RegBus]			reg1_data_out,	// data from register read port 1, pass to EX phase
	output logic[`RegBus]			reg2_data_out	//	data from register read port 2, pass to EX phase

	output logic[`RegAddrBus]		wd_o,				// register address to write to
	output logic						wreg_o,			// whether to write to register
);
	
	
	logic[5:0] opcode = if_inst[15:10];
	
	logic[`RegBus]	imm;
	
	logic inst_valid;
	
	// Phase 1: decode
	
	always_comb begin
		if (rst == `RstEnable) begin
			aluop = `EXE_NOP_OP;
			alusel = `EXE_RES_NOP;
			wd_o = `NOPRegAddr;
			wreg_o = `WriteDisable;
			inst_valid = `InstValid;
			reg1_read = 1'b0;
			reg2_read = 1'b0;
			reg1_read_addr = `NOPRegAddr;
			reg2_read_addr = `NOPRegAddr;
			imm = `ZeroWord;
		end else begin
			aluop = `EXE_NOP_OP;
			alusel = `EXE_RES_NOP;
			wd_o = `NOPRegAddr;
			wreg_o = `WriteDisable;
			inst_valid = `InstValid;
			reg1_read = 1'b0;
			reg2_read = 1'b0;
			reg1_read_addr = if_inst[9:6];
			reg2_read_addr = if_inst[5:2];
			imm = `ZeroWord;



endmodule
