// CPU/if_pc.sv
//
// Define PC and its logic
`timescale 1ns / 1ps
`include "defines.sv"

module if_pc(
	input		rst,	// reset
	input		clk,	// clock
	
	output logic ce,			// ROM chip read
	output logic [15:0] pc // address contained in PC
);
	
	always_ff @(posedge clk) begin
		if(rst)begin
			ce <= `WriteDisable;
		end else begin
			ce <= `WriteEnable;
		end
	end
	always_ff @(posedge clk) begin
		if (rst) begin
			pc <= `ZeroWord;
		end else begin
			pc <= pc + 1'b1;
		end
	end

endmodule
