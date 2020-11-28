//ID_EX_WB_tb.sv
// test right half of flow
`timescale 1ns/1ps
`include "../CPU/defines.sv"
`include "../CPU/ID_EX.sv"
`include "../CPU/ex_alu.sv"
`include "../CPU/EX_MEM.sv"
`include "../CPU/mem.sv"
`include "../CPU/MEM_WB.sv"

module fuck_flow;
    // ID -> ID/EX
    reg clk;
    reg rst;

	reg[`AluOpBus]		id_aluop_o;
	reg[`AluSelBus]	id_alusel_o;
	reg[`RegBus]		id_reg1_o;
	reg[`RegBus]		id_reg2_o;
	reg				id_wreg_o;
	reg[`RegAddrBus]	id_wd_o;

	// ID/EX -> EX

	wire[`AluOpBus]		ex_aluop_i;
	wire[`AluSelBus]	ex_alusel_i;
	wire[`RegBus]		ex_reg1_i;
	wire[`RegBus]		ex_reg2_i;
	wire 				ex_wreg_i;
	wire[`RegAddrBus]	ex_wd_i;

	// EX -> EX/MEM

	wire				ex_wreg_o;
	wire[`RegBus]		ex_wdata_o;
	wire[`RegAddrBus]	ex_wd_o;

	// EX/MEM -> MEM

	wire 				mem_wreg_i;
	wire[`RegBus]		mem_wdata_i;
	wire[`RegAddrBus]	mem_wd_i;

	// MEM -> MEM/WB

	wire 				mem_wreg_o;
	wire[`RegBus]		mem_wdata_o;
	wire[`RegAddrBus]	mem_wd_o;

	// MEM/WB -> WB   
	// Ko No Write Back Da!

	wire				wb_wreg_i;
	wire[`RegBus]		wb_wdata_i;
	wire[`RegAddrBus]	wb_wd_i;	
    
    ID_EX id_ex0(
		.clk(clk),
		.rst(rst),

		.id_aluop(id_aluop_o),
		.id_alusel(id_alusel_o),

		.id_reg1(id_reg1_o),
		.id_reg2(id_reg2_o),
		.id_wd(id_wd_o),
		.id_wreg(id_wreg_o),

		.ex_aluop(ex_aluop_i),
		.ex_alusel(ex_alusel_i),
		.ex_reg1(ex_reg1_i),
		.ex_reg2(ex_reg2_i),
		.ex_wd(ex_wd_i),
		.ex_wreg(ex_wreg_i)
	);

	// realization of EX

	ex_alu ex_alu0(
		.rst (rst),

		.aluop_i(ex_aluop_i),
		.alusel_i(ex_alusel_i),

		.reg1_i(ex_reg1_i),
		.reg2_i(ex_reg2_i),

		.wd_i(ex_wd_i),
		.wreg_i(ex_wreg_i),

		.wd_o(ex_wd_o),
		.wreg_o(ex_wreg_o),
		.wdata_o(ex_wdata_o)
	);

	// realization of EX/MEM

	EX_MEM ex_mem0(
		.rst(rst),
		.clk(clk),

		.ex_wd(ex_wd_o),
		.ex_wreg(ex_wreg_o),
		.ex_wdata(ex_wdata_o),

		.mem_wd(mem_wd_i),
		.mem_wreg(mem_wreg_i),
		.mem_wdata(mem_wdata_i)
	);

	// realization of MEM
	mem mem0(
		.rst(rst),
		
		.wd_i(mem_wd_i),
		.wreg_i(mem_wreg_i),
		.wdata_i(mem_wdata_i),
		
		.wd_o(mem_wd_o),
		.wreg_o(mem_wreg_o),
		.wdata_o(mem_wdata_o)
	);

	// realization of MEM/WB
	MEM_WB mem_wb0(
		.rst(rst),
		.clk(clk),
		
		.mem_wd(mem_wd_o),
		.mem_wreg(mem_wreg_o),
		.mem_wdata(mem_wdata_o),
		
		.wb_wd(wb_wd_i),
		.wb_wreg(wb_wreg_i),
		.wb_wdata(wb_wdata_i)
	);

    initial begin
        rst = 1'b1;
        clk = 1'b0;
        id_aluop_o = `EXE_AND_OP;
        id_alusel_o = `EXE_RES_LOGIC;
        id_reg1_o = 16'b110011;
        id_reg2_o = 16'b001111;
        id_wreg_o = 1'b1;
        id_wd_o = 4'd2;
        #20 rst = 1'b0;
    end
    always #5 clk = ~clk;
endmodule