// IF_ID.sv
// temporarily store instruction and its address
// pass to ID phase at the next clk
`timescale 1ns/1ps
`include "defines.sv"
module IF_ID(
	input logic rst,
	input logic clk,
	
	// Signals from Instrucion Fetch
	input logic [`InstAddrBus]	if_pc,
	input logic [`InstBus]		if_inst,
	
	// Signals to Instruction Decode
	output logic [`InstAddrBus]	id_pc,
	output logic [`InstBus]			id_inst
);

	always_ff @(posedge clk) begin
		if (rst == `RstEnable)	begin
			id_pc <= `ZeroWord;
			id_inst <= `ZeroWord;
		end else begin
			id_pc <= if_pc;
			id_inst <= if_inst;
		end
	end
	
endmodule
