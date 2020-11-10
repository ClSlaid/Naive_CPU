// CPU/if_pc.sv
//
// Define PC and its logic
`timescale 1ns / 1ps
`include "defines.sv"
parameter RAM_BEGIN = 16'h0;

module if_pc(
	input		rst,	// reset
	input		clk,	// clock

	input		pc_en, // call pc to take in next instruction
	
	input		branch_taken, // Predict branch is taken
	input	[15:0]	branch_addr, // the instruction of branch
	
	output logic [15:0] pc_addr // address contained in PC
);



	logic [15:0] pc_next;
	// the next instruction's address
	
	always_comb begin: generate_pc_next
		
		if(rst) begin
			pc_next = RAM_BEGIN;
		end
		
		else if(pc_en) begin
		
			if(branch_taken) begin
				pc_next = branch_addr;
			end
			
			else begin
				pc_next = pc_addr + 16'd2;
			end
			
		end
		
		else begin
			pc_next = pc_addr;
		end
			
	end
	
	always_ff @(posedge clk) begin
		pc_addr <= pc_next;
	end

endmodule
