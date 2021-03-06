// regfile.sv
// registers!
`timescale 1ns/1ps
`include "defines.sv"

module regfile(
	input logic clk,
	input logic rst,
	
	// write port
	input logic						we,		// write enable
	input logic [`RegAddrBus]	waddr,	// write address
	input logic [`RegBus]	wdata,	// writer data
	
	// read port 1
	input logic						r1e,		// read port 1 enable
	input logic [`RegAddrBus]	r1addr,	// read port 1 address
	output logic[`RegBus]	r1data,	// read port 1 data
	
	// read port 2
	input logic						r2e,		// read port 2 enable
	input logic [`RegAddrBus]	r2addr,	// read port 2 address
	output logic[`RegBus]	r2data,	// read port 2 data

	// read port for sampling
	input logic					rse,			// sampling read port enable
	input logic[`RegAddrBus]	rsaddr,			// sampling read port address
	output logic[`RegBus]		rsdata		 	// sampling read port data
	);
	
	
	//------------registers--------
	logic [`RegWidth - 1 : 0] Registers[0 : `RegNum - 1];	// Registers
	
	// initial begin
	// 	Registers[0] <= 16'b0;
	// 	Registers[1] <= 16'b0;
	// 	Registers[2] <= 16'b0;
	// 	Registers[3] <= 16'b0;
	// 	Registers[4] <= 16'b0;
	// 	Registers[5] <= 16'b0;
	// 	Registers[6] <= 16'b0;
	// 	Registers[7] <= 16'b0;
	// 	Registers[8] <= 16'b0;
	// 	Registers[9] <= 16'b0;
	// 	Registers[10] <= 16'b0;
	// 	Registers[11] <= 16'b0;
	// 	Registers[12] <= 16'b0;
	// 	Registers[13] <= 16'b0;
	// 	Registers[14] <= 16'b0;
	// 	Registers[15] <= 16'b0;
	// end
	
	//------------write------------
	always_ff @(posedge clk) begin
		if (rst == `RstDisable) begin
			if ((we == `WriteEnable) && (waddr != `RegNumLog2'b0)) begin
				Registers[waddr] <= wdata;
			end
		end else begin
			Registers[0] <= 16'b0;
			Registers[1] <= 16'b0;
			Registers[2] <= 16'b0;
			Registers[3] <= 16'b0;
			Registers[4] <= 16'b0;
			Registers[5] <= 16'b0;
			Registers[6] <= 16'b0;
			Registers[7] <= 16'b0;
			Registers[8] <= 16'b0;
			Registers[9] <= 16'b0;
			Registers[10] <= 16'b0;
			Registers[11] <= 16'b0;
			Registers[12] <= 16'b0;
			Registers[13] <= 16'b0;
			Registers[14] <= 16'b0;
			Registers[15] <= 16'b0;
		end
	end
	
	
	//------------read 1-------------
	always_comb begin
		if (rst == `RstEnable) begin
			r1data = `ZeroWord;
		end else if(r1addr == `RegNumLog2'h0) begin
			r1data = `ZeroWord;
		end else if(r1e == `ReadEnable)begin
			if((we == `WriteEnable)&&(r1addr == waddr))begin
				r1data = wdata;
			end else begin
				r1data = Registers[r1addr];
			end
		end else begin
			r1data = `ZeroWord;
		end
	end
	
	
	//------------read 2-------------
	always_comb begin
		if (rst == `RstEnable) begin
			r2data = `ZeroWord;
		end else if(r2addr == `RegNumLog2'h0) begin
			r2data = `ZeroWord;
		end else if(r2e == `ReadEnable)begin
			if((we == `WriteEnable)&&(r2addr == waddr))begin
				r2data = wdata;
			end else begin
				r2data = Registers[r2addr];
			end
		end else begin
			r2data = `ZeroWord;
		end
	end
	// ------------sampling-------------
	always_comb begin
		if (rst == `RstEnable) begin
			rsdata = `ZeroWord;
		end else if(rsaddr == `RegNumLog2'h0) begin
			rsdata = `ZeroWord;
		end else if(rse == `ReadEnable)begin
			if((we == `WriteEnable)&&(rsaddr == waddr))begin
				rsdata = wdata;
			end else begin
				rsdata = Registers[rsaddr];
			end
		end else begin
			rsdata = `ZeroWord;
		end
	end
endmodule
