// id_decoder.sv
// decode instructions
`timescale 1ns/1ps
`include "defines.sv"

module id(
	input logic							rst,			// reset
	// combinational logic, no clock needed
	
	// value from Instruction Fetch
	input logic [`InstAddrBus]		if_pc,		// PC value from Instruction Fetch
	input logic [`InstBus]			if_inst,		// instruction from Instruction Fetch
	
	//	value from Registers
	input logic [`RegBus]			reg1_data_in,	// data from register read port 1
	input logic [`RegBus]			reg2_data_in,	// data from register read port 2

	/* data forwarding */
	// data forward from EXecute phase
	input logic						ex_wreg_i,
	input logic [`RegBus]			ex_wdata_i,
	input logic [`RegAddrBus]		ex_wd_i,
	// data forward from MEMory phase
	input logic						mem_wreg_i,
	input logic [`RegBus]			mem_wdata_i,
	input logic [`RegAddrBus]		mem_wd_i,
	/* end data forwarding*/

	// operation to RegFile
	output logic						reg1_read,		// register read port 1 enable
	output logic						reg2_read,		//	register read port 2 enable
	
	output logic[`RegAddrBus]		reg1_read_addr,// register read port 1 address
	output logic[`RegAddrBus]		reg2_read_addr,// register read port 2 address
	
	// operation to EXecute phase
	output logic[`AluOpBus]			aluop,			// ALU Operation sub code
	output logic[`AluSelBus]		alusel,			// ALU Operation code
	
	output logic[`RegBus]			reg1_data_out,	// data from register read port 1, pass to EX phase
	output logic[`RegBus]			reg2_data_out,	//	data from register read port 2, pass to EX phase

	output logic[`RegAddrBus]		wd_o,				// register address to write to
	output logic						wreg_o			// whether to write to register
);
	
	logic[5:0] opcode;
	assign opcode = if_inst[15:10];
	
	logic[`RegBus]	imm;
	
	logic inst_valid;
	
	// Phase 1: decode
	
	always_comb begin
		if (rst == `RstEnable) begin
			aluop = `EXE_NOP_OP;
			alusel = `EXE_RES_NOP;
			wd_o = `NOPRegAddr;
			wreg_o = `WriteDisable;
			inst_valid = `InstInvalid;
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
			
			case(opcode)
			
				`EXE_ORI:	begin	// is ORI operation:	ORI rd imm
					wreg_o = `WriteEnable;
					aluop = `EXE_OR_OP;
					alusel = `EXE_RES_LOGIC;
					reg1_read_addr = 1'b1;	// read from rd
					reg2_read_addr = 1'b0;	// no rs but imm here
					imm = {10'h0, if_inst[5:0]};
					wd_o = if_inst[9:6];
					inst_valid = `InstValid;
				end
				default:	begin
				end
			
			endcase
		end
	end

// get from reg 1?
	always_comb begin: read_reg_1
		if(rst == `RstEnable)	begin
			reg1_data_out = `ZeroWord;
		end else if((reg1_read == 1'b1) && (ex_wreg_i == 1'b1) && (reg1_read_addr == ex_wd_i))begin
			reg1_data_out = ex_wdata_i;
		end else if((reg1_read == 1'b1) && (mem_wreg_i == 1'b1) && (reg1_read_addr == mem_wd_i))begin
			reg1_data_out = mem_wdata_i;
		end else if (reg1_read == `ReadEnable) begin
			reg1_data_out = reg1_data_in;
		end else if	(reg1_read == `ReadDisable) begin
			reg1_data_out = imm;
		end else begin
			reg1_data_out = `ZeroWord;
		end
	end

// get from reg 2?
	always_comb begin: read_reg_2
		if(rst == `RstEnable)	begin
			reg2_data_out = `ZeroWord;
		end else if ((reg2_read == 1'b1) && (ex_wreg_i == 1'b1) && (reg2_read_addr == ex_wd_i)) begin
			reg2_data_out = ex_wdata_i;
		end else if ((reg2_read == 1'b1) && (mem_wreg_i == 1'b1) && (reg2_read_addr == mem_wd_i)) begin
			reg2_data_out = mem_wdata_i;
		end else if (reg2_read == `ReadEnable) begin
			reg2_data_out = reg2_data_in;
		end else if (reg2_read == `ReadDisable) begin
			reg2_data_out = imm;
		end else begin
			reg2_data_out = `ZeroWord;
		end
	end
	
endmodule
