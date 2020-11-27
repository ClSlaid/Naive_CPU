// CPU/if_pc.sv
//
// Define PC and its logic
`timescale 1ns / 1ps
`include "defines.sv"
parameter RAM_BEGIN = 16'h0;

module if_pc(
	input		rst,	// reset
	input		clk,	// clock
	
	output ce,			// ROM chip read
	output logic [15:0] pc // address contained in PC
);
	
	always_ff @(posedge clk) begin
		if (rst == `RstEnable) begin
			pc <= RAM_BEGIN;
		end else begin
			pc <= pc + 1'b1;
		end
	end

endmodule
