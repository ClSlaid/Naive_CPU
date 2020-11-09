// regfile.sv
// registers!
`timescale 1ns/1ps
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
	output logic[`RegBus]	r2data	// read port 2 data
	);
	
	
	//------------registers--------
	logic [`RegWidth - 1 : 0] Registers[0 : `RegNum - 1];	// Registers
	
	
	//------------write------------
	always_ff @(posedge clk) begin
		if (rst == `RstDisable) begin
			if ((we == `WriteEnable) && (waddr != `RegNumLog2'b0)) begin
				Registers[waddr] <= wdata;
			end
		end
	end
	
	
	//------------read 1-------------
	always_comb begin
		if (rst == `RstEnable) begin
			r1data = `ZeroWord;
		end else if(raddr1 == `RegNumLog2'h0) begin
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
		end else if(raddr2 == `RegNumLog2'h0) begin
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
	
endmodule
