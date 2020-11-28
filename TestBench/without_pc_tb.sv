//ID2MEM_tb.sv
// test centural right of flow
`timescale 1ns/1ps
`include "../CPU/defines.sv"
`include "../CPU/observer.sv"
`include "../CPU/id.sv"
`include "../CPU/ID_EX.sv"
`include "../CPU/ex_alu.sv"
`include "../CPU/EX_MEM.sv"
`include "../CPU/mem.sv"
`include "../CPU/MEM_WB.sv"
`include "../CPU/regfile.sv"

module without_pc_tb;
    reg clk;
    reg rst;

    reg [`RegAddrBus]ob_sel;
    reg [2:0]ob_mode_i;
    wire [`RegBus] ob_data_o;

    // IF/ID -> ID

	reg[`InstAddrBus]	id_pc_i;
	reg[`InstBus]		id_inst_i;

    // ID -> ID/EX
	wire[`AluOpBus]		id_aluop_o;
	wire[`AluSelBus]	id_alusel_o;
	wire[`RegBus]		id_reg1_o;
	wire[`RegBus]		id_reg2_o;
    wire                 id_wreg_o;
	wire[`RegAddrBus]	id_wd_o;	
    
    // ID <-> Regfile
	wire				reg1_read;
	wire				reg2_read;
	wire[`RegBus]		reg1_data;
	wire[`RegBus]		reg2_data;
	wire[`RegAddrBus]	reg1_addr;
	wire[`RegAddrBus]	reg2_addr;


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
    // observer <-> Regfile
	
	wire				ob_reg_read;
	wire[`RegBus]		ob_reg_data;
	wire[`RegAddrBus] 	ob_reg_addr;


	regfile regfile0(
		.clk(clk),
		.rst(rst),

		.we(wb_wreg_i),
		.waddr(wb_wd_i),
		.wdata(wb_wdata_i),

		.r1e(reg1_read),
		.r2e(reg2_read),
		.r1addr(reg1_addr),
		.r2addr(reg2_addr),
		.r1data(reg1_data),
		.r2data(reg2_data),

		.rse(ob_reg_read),
		.rsaddr(ob_reg_addr),
		.rsdata(ob_reg_data)

	);

    observer ob0(
		.clk(clk),
		.reg_data_i (ob_reg_data),
		.reg_sel_o	(ob_reg_addr),
		.reg_read_o (ob_reg_read),

		.pc_i       (pc),
		.ir_i		(id_inst_i),

		.alu_a_i	(ex_reg1_i),
		.alu_b_i	(ex_reg2_i),
		.alu_o_i	(ex_wdata_o),

		.reg_sel_i	(ob_sel),
		.mode_i		(ob_mode_i),
		.data_o		(ob_data_o)
	);

    id	id0(
		.rst(rst),
		.if_pc(id_pc_i),
		.if_inst(id_inst_i),
		
		.reg1_data_in(reg1_data),
		.reg2_data_in(reg2_data),

		.ex_wreg_f(ex_wreg_o),
		.ex_wdata_f(ex_wdata_o),
		.ex_wd_f(ex_wd_o),

		.mem_wreg_f(mem_wreg_o),
		.mem_wdata_f(mem_wdata_o),
		.mem_wd_f(mem_wd_o),

		.reg1_read(reg1_read),
		.reg2_read(reg2_read),
		.reg1_read_addr(reg1_addr),
		.reg2_read_addr(reg2_addr),
		
		.aluop(id_aluop_o),
		.alusel(id_alusel_o),
		.reg1_data_out(id_reg1_o),
		.reg2_data_out(id_reg2_o),
		.wd_o(id_wd_o),
		.wreg_o(id_wreg_o)
	);

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
        rst = `RstEnable;
        clk = 1'b1;

        id_pc_i = 16'h0;
        id_inst_i = 16'h3443;

    //    reg1_data = 16'b110011;
    //    reg2_data = 16'b101001;
        
        #20 rst = `RstDisable;
    end
    always #5 begin
        clk = ~clk;
    end
    always #10 begin
         id_pc_i = id_pc_i + 1;
    end    
    always #5 ob_sel = ob_sel + 1'b1;
    always #25 begin
         ob_mode_i = ob_mode_i + 1'b1;
    end

endmodule